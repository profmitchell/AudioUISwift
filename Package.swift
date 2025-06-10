// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AudioUI",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .watchOS(.v8),
        .tvOS(.v15)
    ],
    products: [
        // Unified AudioUI library (includes all modules)
        .library(
            name: "AudioUI",
            targets: ["AudioUI"]
        ),
        
        // Individual module access (for granular imports)
        .library(
            name: "AudioUICore",
            targets: ["AudioUICore"]
        ),
        .library(
            name: "AudioUITheme", 
            targets: ["AudioUITheme"]
        ),
        .library(
            name: "AudioUIComponents",
            targets: ["AudioUIComponents"]
        ),
        .library(
            name: "AudioUIMetalFX",
            targets: ["AudioUIMetalFX"]
        )
    ],
    dependencies: [
        // No external dependencies - fully self-contained
    ],
    targets: [
        // MARK: - Main Targets
        
        // Umbrella module that re-exports everything
        .target(
            name: "AudioUI",
            dependencies: [
                "AudioUICore",
                "AudioUITheme", 
                "AudioUIComponents",
                "AudioUIMetalFX"
            ],
            path: "Sources/AudioUI"
        ),
        
        // Core primitives and foundation
        .target(
            name: "AudioUICore",
            dependencies: [],
            path: "Sources/AudioUICore"
        ),
        
        // Theme system (Looks & Feels)
        .target(
            name: "AudioUITheme",
            dependencies: [],
            path: "Sources/AudioUITheme"
        ),
        
        // Production-ready components
        .target(
            name: "AudioUIComponents", 
            dependencies: [
                "AudioUICore",
                "AudioUITheme"
            ],
            path: "Sources/AudioUIComponents"
        ),
        
        // Metal-powered effects and visualizations
        .target(
            name: "AudioUIMetalFX",
            dependencies: [
                "AudioUICore",
                "AudioUITheme"
            ],
            path: "Sources/AudioUIMetalFX",
            resources: [
                .process("Shaders")
            ]
        ),
        
        // MARK: - Test Targets
        
        .testTarget(
            name: "AudioUITests",
            dependencies: ["AudioUI"],
            path: "Tests/AudioUITests"
        ),
        
        .testTarget(
            name: "AudioUICoreTests",
            dependencies: ["AudioUICore"],
            path: "Tests/AudioUICoreTests"
        ),
        
        .testTarget(
            name: "AudioUIThemeTests",
            dependencies: ["AudioUITheme"],
            path: "Tests/AudioUIThemeTests"
        ),
        
        .testTarget(
            name: "AudioUIComponentsTests",
            dependencies: [
                "AudioUIComponents",
                "AudioUICore", 
                "AudioUITheme"
            ],
            path: "Tests/AudioUIComponentsTests"
        ),
        
        .testTarget(
            name: "AudioUIMetalFXTests",
            dependencies: [
                "AudioUIMetalFX",
                "AudioUICore",
                "AudioUITheme"
            ],
            path: "Tests/AudioUIMetalFXTests"
        )
    ]
)
