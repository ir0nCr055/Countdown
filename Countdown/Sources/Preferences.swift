import Foundation
import ScreenSaver

final class Preferences: NSObject {

	// MARK: - Properties

	private let dateKey = "Date2"
    private let messageKey = "Message"
    private let mediaPathKey = "Media"

	@objc var date: Date? {
		get {
            let timestamp = defaults?.object(forKey: dateKey) as? TimeInterval
			return timestamp.map { Date(timeIntervalSince1970: $0) }
		}

		set {
			if let date = newValue {
                defaults?.set(date.timeIntervalSince1970, forKey: dateKey)
			} else {
                defaults?.removeObject(forKey: dateKey)
			}
			defaults?.synchronize()

            NotificationCenter.default.post(name: .dateDidChange, object: newValue)
		}
	}
    
    @objc var message: String? {
        get {
            return defaults?.object(forKey: messageKey) as? String
        }
        
        set {
            if let message = newValue {
                defaults?.set(message, forKey: messageKey)
            } else {
                defaults?.removeObject(forKey: messageKey)
            }
            defaults?.synchronize()
            
            NotificationCenter.default.post(name: .messageDidChange, object: newValue)
        }
    }
    
    @objc var mediaPath: String? {
        get {
            return defaults?.object(forKey: mediaPathKey) as? String
        }
        
        set {
            if let mediaPath = newValue {
                defaults?.set(mediaPath, forKey: mediaPathKey)
            } else {
                defaults?.removeObject(forKey: mediaPathKey)
            }
            defaults?.synchronize()
            
            NotificationCenter.default.post(name: .mediaPathDidChange, object: newValue)
        }
    }

	private let defaults: ScreenSaverDefaults? = {
        let bundleIdentifier = Bundle(for: Preferences.self).bundleIdentifier
		return bundleIdentifier.flatMap { ScreenSaverDefaults(forModuleWithName: $0) }
	}()
}

extension Notification.Name {
    static let dateDidChange = Notification.Name(rawValue: "Preferences.dateDidChangeNotification")
    static let messageDidChange = Notification.Name(rawValue: "Preferences.messageDidChangeNotification")
    static let mediaPathDidChange = Notification.Name(rawValue: "Preferences.mediaPathDidChangeNotification")
}
