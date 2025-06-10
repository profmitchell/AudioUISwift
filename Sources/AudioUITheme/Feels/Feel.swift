//
//  Feel.swift
//  AudioUI-Theme
//
//  Created by Mitchell Cohen on 6/6/25.
//


import SwiftUI

@available(iOS 18.0, macOS 15.0, *)
public protocol Feel: Sendable {
    // Shape properties
    var cornerRadius: CGFloat { get }
    var borderWidth: CGFloat { get }
    
    // Shadow properties
    var shadowRadius: CGFloat { get }
    var shadowOpacity: Double { get }
    
    // Effect properties
    var glowIntensity: Double { get }
    var blurRadius: CGFloat { get }
    
    // Animation properties
    var animationDuration: Double { get }
    var animationCurve: Animation { get }
}

@available(iOS 18.0, macOS 15.0, *)
public extension Feel {
    // Default implementations using @ViewBuilder
    @ViewBuilder
    func applyToContainer<Content: View>(_ content: Content, look: Look) -> some View {
        content
    }
    
    @ViewBuilder
    func applyToButton<Content: View>(_ content: Content, look: Look, isPressed: Bool) -> some View {
        content
    }
    
    @ViewBuilder
    func applyToInteractive<Content: View>(_ content: Content, look: Look, isActive: Bool) -> some View {
        content
    }
}
