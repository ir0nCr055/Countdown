//
//  mediaView.swift
//  Countdown
//
//  Created by Michael Cross on 10/19/19.
//  Copyright © 2019 Sam Soffes. All rights reserved.
//

import AVKit

class mediaView: AVPlayerView {
    
    //Based on strategy found here: https://stackoverflow.com/questions/39258312/how-to-loop-video-with-avplayerlooper
    var playerLooper: NSObject?
    var opacityView: NSTextField
    
    init(mediaPath: String?) {
        let opacityView = NSTextField(frame: .zero)
        opacityView.translatesAutoresizingMaskIntoConstraints = false
        opacityView.backgroundColor = NSColor(white: 0.0, alpha: 0.25)
        opacityView.stringValue = ""
        opacityView.drawsBackground = true
        opacityView.isEditable = false
        opacityView.isBordered = false
        opacityView.isBezeled = false
        opacityView.alignment = .center
        self.opacityView = opacityView
        
        super.init(frame: .zero)
        self.controlsStyle = .none
        self.postsFrameChangedNotifications = true
        addSubview(self.opacityView)
        
        self.updateMediaPath(mediaPath)
        
        //Respond to frame changes (e.g. due to constraints, autoresizing)
        NotificationCenter.default.addObserver(self, selector: #selector(frameDidChange), name: NSView.frameDidChangeNotification, object: nil)
    }
    
    //MARK: NSNotificationCenter
    @objc private func frameDidChange(_ notification: NSNotification?) {
        self.opacityView.frame = self.frame
    }
    
    func updateMediaPath(_ mPath: String?) {
        if let path = mPath {
            let url =  URL(fileURLWithPath: path)
            // Use a new player looper with the queue player and template item
            let playerItem = AVPlayerItem(url: url as URL)
            let aNewPlayer = AVQueuePlayer(items: [playerItem])
            self.player = aNewPlayer
            self.playerLooper = AVPlayerLooper(player: aNewPlayer, templateItem: playerItem)
            self.player?.play()
        }
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
