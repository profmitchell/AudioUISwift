// Placeholder Metal shader file
// TODO: Move actual shaders from AudioUIMetalFX package

#include <metal_stdlib>
using namespace metal;

/// Basic vertex shader for audio visualization effects
vertex float4 basic_vertex_shader(uint vertex_id [[vertex_id]],
                                constant float2 *vertices [[buffer(0)]]) {
    return float4(vertices[vertex_id], 0.0, 1.0);
}

/// Fragment shader for glow effect used in AudioUI components
fragment float4 glow_fragment_shader(float4 position [[position]],
                                   constant float4 &color [[buffer(0)]],
                                   constant float &intensity [[buffer(1)]],
                                   constant float &radius [[buffer(2)]]) {
    float2 center = float2(0.5, 0.5);
    float2 uv = position.xy;
    float distance = length(uv - center);
    
    // Create glow falloff
    float glow = 1.0 - smoothstep(0.0, radius, distance);
    glow = pow(glow, 2.0) * intensity;
    
    return float4(color.rgb, glow * color.a);
}

/// Fragment shader for ripple effect used in XY pads
fragment float4 ripple_fragment_shader(float4 position [[position]],
                                     constant float2 &center [[buffer(0)]],
                                     constant float &time [[buffer(1)]],
                                     constant float4 &color [[buffer(2)]]) {
    float2 uv = position.xy;
    float distance = length(uv - center);
    
    // Create expanding ripple
    float ripple = sin(distance * 10.0 - time * 5.0) * 0.5 + 0.5;
    ripple *= 1.0 - smoothstep(0.0, 1.0, distance);
    
    return float4(color.rgb, ripple * color.a);
}

/// Fragment shader for level meter visualization
fragment float4 level_meter_fragment_shader(float4 position [[position]],
                                          constant float &level [[buffer(0)]],
                                          constant float4 &lowColor [[buffer(1)]],
                                          constant float4 &highColor [[buffer(2)]]) {
    float2 uv = position.xy;
    
    // Vertical level meter
    float meterValue = 1.0 - uv.y;
    float4 color = mix(lowColor, highColor, meterValue);
    
    // Only show meter up to current level
    float alpha = step(meterValue, level);
    
    return float4(color.rgb, alpha);
}

/// Fragment shader for spectrum analyzer bars
fragment float4 spectrum_fragment_shader(float4 position [[position]],
                                       constant float *spectrum [[buffer(0)]],
                                       constant int &barCount [[buffer(1)]],
                                       constant float4 &color [[buffer(2)]]) {
    float2 uv = position.xy;
    
    // Determine which frequency bar this pixel belongs to
    int barIndex = int(uv.x * float(barCount));
    barIndex = clamp(barIndex, 0, barCount - 1);
    
    // Get spectrum value for this bar
    float spectrumValue = spectrum[barIndex];
    
    // Vertical fill based on spectrum value
    float fill = step(1.0 - uv.y, spectrumValue);
    
    // Color based on frequency (hue shift)
    float hue = float(barIndex) / float(barCount);
    float3 hsvColor = float3(hue, 1.0, 1.0);
    
    // Convert HSV to RGB (simplified)
    float3 rgbColor = mix(color.rgb, hsvColor, 0.3);
    
    return float4(rgbColor, fill * color.a);
}
