import XCTest
@testable import AudioUIMetalFX

@available(iOS 17.0, macOS 14.0, *)
final class AudioUIMetalFXTests: XCTestCase {
    
    func testAudioUIMetalFXVersion() {
        XCTAssertEqual(AudioUIMetalFX.version, "2.0.0")
        XCTAssertEqual(AudioUIMetalFX.description, "Metal-powered effects for audio interfaces")
    }
    
    func testModuleAccessibility() {
        // Test that the module is accessible and contains expected properties
        XCTAssertFalse(AudioUIMetalFX.version.isEmpty)
        XCTAssertFalse(AudioUIMetalFX.description.isEmpty)
    }
}
