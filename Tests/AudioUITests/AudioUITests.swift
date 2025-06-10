import XCTest
@testable import AudioUI
@testable import AudioUICore
@testable import AudioUITheme  
@testable import AudioUIComponents
@testable import AudioUIMetalFX

final class AudioUITests: XCTestCase {
    
    func testAudioUIVersion() {
        XCTAssertEqual(AudioUI.version, "2.0.0")
        XCTAssertEqual(AudioUI.description, "Unified framework for audio user interfaces")
    }
    
    func testModuleIntegration() {
        // Test that all modules are accessible through the umbrella import
        XCTAssertEqual(AudioUICore.version, "2.0.0")
        XCTAssertEqual(AudioUITheme.version, "2.0.0") 
        XCTAssertEqual(AudioUIComponents.version, "2.0.0")
        XCTAssertEqual(AudioUIMetalFX.version, "2.0.0")
    }
}
