import AppKit

final class ConfigurationWindowController: NSWindowController {

	// MARK: - NSWindowController

	override var windowNibName: NSNib.Name {
		return NSNib.Name(stringLiteral: "Configuration")
	}


	// MARK: - Action

	@IBAction func close(_ sender: Any?) {
		window?.close()
	}
}
