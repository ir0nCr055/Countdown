import AppKit

final class ConfigurationWindowController: NSWindowController, NSWindowDelegate {

	// MARK: - NSWindowController

	override var windowNibName: NSNib.Name {
		return NSNib.Name(stringLiteral: "Configuration")
	}
    
    // MARK: - NSWindowDelegate
    func windowDidChangeOcclusionState(_ notification: Notification) {
        if let theWindow = self.window {
            if theWindow.occlusionState.contains(NSWindow.OcclusionState.visible)
            {
                //Media chooser
                if let curMediaPath = prefsManager.mediaPath {
                    mediaPathControl.url = URL(fileURLWithPath: curMediaPath)
                }
                else {
                    mediaPathControl.url = nil
                }
            }
            else
            {
                // NO OP
            }
        }
    }
    
    // MARK: - Outlets

    @IBOutlet var prefsManager: Preferences!
    @IBOutlet var mediaPathControl: NSPathControl!
    
	// MARK: - Action

	@IBAction func close(_ sender: Any?) {
		window?.close()
	}
    @IBAction func mediaPathUpdated(_ sender: NSPathControl) {
        // Check the state of the path control
        if let curURL = sender.url, curURL.path.count > 0 {
            // set the path setting
            prefsManager.mediaPath = curURL.path
        }
        else {
            prefsManager.mediaPath = nil
        }
    }
}
