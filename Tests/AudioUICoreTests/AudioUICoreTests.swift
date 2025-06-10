import XCTest
@testable import AudioUICore

final class AudioUICoreTests: XCTestCase {
    
    func testAudioUICoreVersion() {
        XCTAssertEqual(AudioUICore.version, "2.0.0")
        XCTAssertEqual(AudioUICore.description, "Foundation primitives for audio user interfaces")
    }
    
    func testModuleAccessibility() {
        // Test that the module is accessible and contains expected properties
        XCTAssertFalse(AudioUICore.version.isEmpty)
        XCTAssertFalse(AudioUICore.description.isEmpty)
    }
}
