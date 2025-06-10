#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

// MARK: - Enhanced Glow Effect
[[ stitchable ]] half4 glowEffect(float2 position,
                                  SwiftUI::Layer layer,
                                  float4 bounds,
                                  float intensity,
                                  float4 color) {
    float2 center = bounds.xy + bounds.zw * 0.5;
    float distance = length(position - center);
    float maxDistance = length(bounds.zw) * 0.5;

    float glow = 1.0 - smoothstep(0.0, maxDistance, distance);
    glow = pow(glow, 2.0 / intensity);

    half4 originalColor = layer.sample(position);
    half4 glowColor = half4(color);

    return mix(originalColor, glowColor, glow * glowColor.a);
}

// MARK: - Ripple Effect
[[ stitchable ]] half4 rippleEffect(float2 position,
                                    SwiftUI::Layer layer,
                                    float4 bounds,
                                    float time,
                                    float intensity,
                                    float4 center) {
    float2 uv = (position - bounds.xy) / bounds.zw;
    float2 rippleCenter = center.xy;
    
    float distance = length(uv - rippleCenter);
    float ripple = sin(distance * 20.0 - time * 8.0) * intensity;
    ripple *= exp(-distance * 3.0); // Fade out with distance
    
    float2 offset = normalize(uv - rippleCenter) * ripple * 0.02;
    float2 newPosition = position + offset * bounds.zw;
    
    half4 originalColor = layer.sample(newPosition);
    
    // Add ripple highlight
    float highlight = abs(ripple) * 0.5;
    half4 rippleColor = half4(0.5, 0.8, 1.0, highlight);
    
    return mix(originalColor, rippleColor, highlight);
}

// MARK: - Wave Distortion
[[ stitchable ]] float2 waveDistortion(float2 position,
                                       float time,
                                       float amplitude,
                                       float frequency,
                                       float speed) {
    float wave = sin(position.y * frequency + time * speed) * amplitude;
    return float2(position.x + wave, position.y);
}

// MARK: - Enhanced Spectrum Visualizer
[[ stitchable ]] half4 spectrumVisualizer(float2 position,
                                          float4 bounds,
                                          float time,
                                          float intensity) {
    float2 uv = (position - bounds.xy) / bounds.zw;

    // Create frequency bands
    float band = floor(uv.x * 32.0) / 32.0;
    float bandHeight = sin(band * 3.14159 + time * 2.0) * 0.5 + 0.5;
    bandHeight *= intensity;

    // Create bar effect
    float bar = step(uv.y, bandHeight);

    // Enhanced color gradient with more vibrant colors
    half3 color = half3(
        0.5 + 0.5 * sin(band * 6.28318 + time),
        0.5 + 0.5 * sin(band * 6.28318 + time + 2.094),
        0.5 + 0.5 * sin(band * 6.28318 + time + 4.188)
    );
    
    // Add intensity-based brightness
    color *= (1.0 + intensity * 0.5);

    return half4(color * bar, bar);
}

// MARK: - Audio Level Meter
[[ stitchable ]] half4 audioLevelMeter(float2 position,
                                       float4 bounds,
                                       float level) {
    float2 uv = (position - bounds.xy) / bounds.zw;

    // Create gradient colors
    half3 green = half3(0.0, 1.0, 0.0);
    half3 yellow = half3(1.0, 1.0, 0.0);
    half3 red = half3(1.0, 0.0, 0.0);

    half3 color;
    if (uv.x < 0.6) {
        color = green;
    } else if (uv.x < 0.8) {
        color = mix(green, yellow, (uv.x - 0.6) / 0.2);
    } else {
        color = mix(yellow, red, (uv.x - 0.8) / 0.2);
    }

    float visible = step(uv.x, level);
    return half4(color, visible);
}

// MARK: - LED Matrix Effect
[[ stitchable ]] half4 ledMatrix(float2 position,
                                 SwiftUI::Layer layer,
                                 float4 bounds,
                                 float pixelSize) {
    float2 pixelPos = floor(position / pixelSize) * pixelSize + pixelSize * 0.5;
    half4 color = layer.sample(pixelPos);

    float2 localPos = fmod(position, pixelSize);
    float distance = length(localPos - pixelSize * 0.5);
    float ledSize = pixelSize * 0.4;

    float led = 1.0 - smoothstep(ledSize * 0.8, ledSize, distance);

    return color * led;
}

// MARK: - Analog Meter Needle
[[ stitchable ]] half4 analogNeedle(float2 position,
                                    float4 bounds,
                                    float value,
                                    float4 needleColor) {
    float2 center = bounds.xy + bounds.zw * float2(0.5, 0.9);
    float2 direction = position - center;
    float angle = atan2(direction.y, direction.x);
    float targetAngle = mix(-2.356, -0.785, value); // -135° to -45°

    float needleWidth = 0.02;
    float needleLength = bounds.w * 0.4;
    float distance = length(direction);

    float angleDiff = abs(angle - targetAngle);
    float needle = step(angleDiff, needleWidth) * step(distance, needleLength);

    return half4(needleColor) * needle;
}

// MARK: - VU Meter Gradient
[[ stitchable ]] half4 vuMeterGradient(float2 position,
                                       float4 bounds,
                                       float level) {
    float2 uv = (position - bounds.xy) / bounds.zw;

    // Create gradient colors
    half3 green = half3(0.0, 1.0, 0.0);
    half3 yellow = half3(1.0, 1.0, 0.0);
    half3 red = half3(1.0, 0.0, 0.0);

    half3 color;
    if (uv.x < 0.6) {
        color = green;
    } else if (uv.x < 0.8) {
        color = mix(green, yellow, (uv.x - 0.6) / 0.2);
    } else {
        color = mix(yellow, red, (uv.x - 0.8) / 0.2);
    }

    float visible = step(uv.x, level);
    return half4(color, visible);
}

// MARK: - Oscilloscope
[[ stitchable ]] half4 oscilloscope(float2 position,
                                    float4 bounds,
                                    float time,
                                    float4 lineColor) {
    float2 uv = (position - bounds.xy) / bounds.zw;

    // Generate waveform
    float wave = 0.5 + 0.3 * sin(uv.x * 12.566 + time * 2.0);
    wave += 0.1 * sin(uv.x * 25.132 + time * 3.0);

    float lineThickness = 0.02;
    float distance = abs(uv.y - wave);
    float line = 1.0 - smoothstep(0.0, lineThickness, distance);

    return half4(lineColor) * line;
}

// MARK: - Particle Effect
[[ stitchable ]] half4 particleEffect(float2 position,
                                      float4 bounds,
                                      float time,
                                      float intensity,
                                      float4 particleColor) {
    float2 uv = (position - bounds.xy) / bounds.zw;
    
    half4 result = half4(0.0);
    
    // Generate multiple particles
    for (int i = 0; i < 8; i++) {
        float offset = float(i) * 0.785398; // π/4
        float2 particlePos = float2(
            0.5 + 0.3 * sin(time * 2.0 + offset),
            0.5 + 0.3 * cos(time * 1.5 + offset)
        );
        
        float distance = length(uv - particlePos);
        float particle = 1.0 - smoothstep(0.0, 0.05, distance);
        particle *= intensity;
        
        // Add particle trail
        float trail = exp(-distance * 10.0) * 0.3;
        particle = max(particle, trail * intensity);
        
        result += half4(half3(particleColor.rgb), half(particle * particleColor.a));
    }
    
    return result;
}

// MARK: - Enhanced Knob Glow
[[ stitchable ]] half4 knobGlow(float2 position,
                                SwiftUI::Layer layer,
                                float4 bounds,
                                float knobValue,
                                float glowIntensity,
                                float4 glowColor) {
    float2 center = bounds.xy + bounds.zw * 0.5;
    float distance = length(position - center);
    float maxDistance = length(bounds.zw) * 0.5;
    
    // Create multiple glow layers
    float innerGlow = 1.0 - smoothstep(0.0, maxDistance * 0.6, distance);
    float outerGlow = 1.0 - smoothstep(0.0, maxDistance * 1.2, distance);
    
    // Modulate glow based on knob value
    float valueGlow = knobValue * glowIntensity;
    
    innerGlow = pow(innerGlow, 2.0) * valueGlow;
    outerGlow = pow(outerGlow, 4.0) * valueGlow * 0.5;
    
    half4 originalColor = layer.sample(position);
    half4 glow = half4(half3(glowColor.rgb), half((innerGlow + outerGlow) * glowColor.a));
    
    return originalColor + glow;
}

// MARK: - Pad Ripple Effect
[[ stitchable ]] half4 padRipple(float2 position,
                                 SwiftUI::Layer layer,
                                 float4 bounds,
                                 float time,
                                 float isPressed,
                                 float4 rippleColor) {
    float2 center = bounds.xy + bounds.zw * 0.5;
    float distance = length(position - center);
    float maxDistance = length(bounds.zw) * 0.7;
    
    half4 originalColor = layer.sample(position);
    
    if (isPressed > 0.5) {
        // Create expanding ripple
        float rippleRadius = fmod(time * 200.0, maxDistance);
        float rippleWidth = 20.0;
        
        float ripple = 1.0 - abs(distance - rippleRadius) / rippleWidth;
        ripple = max(0.0, ripple);
        ripple *= exp(-distance / maxDistance); // Fade with distance
        
        half4 ripple_color = half4(half3(rippleColor.rgb), half(ripple * rippleColor.a));
        return mix(originalColor, ripple_color, ripple * 0.6);
    }
    
    return originalColor;
}

// MARK: - Audio Reactive Background
[[ stitchable ]] half4 audioReactiveBackground(float2 position,
                                               float4 bounds,
                                               float time,
                                               float audioLevel,
                                               float4 baseColor) {
    float2 uv = (position - bounds.xy) / bounds.zw;
    
    // Create animated pattern based on audio level
    float pattern = sin(uv.x * 10.0 + time) * sin(uv.y * 10.0 + time * 0.7);
    pattern = (pattern + 1.0) * 0.5; // Normalize to 0-1
    
    // Modulate by audio level
    pattern *= audioLevel;
    
    // Create color gradient
    half3 color1 = half3(baseColor.rgb);
    half3 color2 = half3(color1.b, color1.r, color1.g); // Rotate colors
    
    half3 finalColor = mix(color1, color2, pattern);
    
    return half4(finalColor, baseColor.a);
}
