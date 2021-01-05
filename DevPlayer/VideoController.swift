//
//  VideoController.swift
//  Direct
//
//  Created by abuzeid on 7/5/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import AVFoundation
import AVKit

public final class VideoController: UIViewController {
    private var videoUrl: URL
    private(set) lazy var player: AVPlayer = AVPlayer(url: self.videoUrl)
    private let playerView: AVPlayerViewController
    private var autoPlay: Bool
    override public func loadView() {
        view = UIView()
        playerView.player = player
        addChild(playerView)
        view.addSubview(playerView.view)
        playerView.view.frame = view.bounds
        playerView.player = player
    }

    public init(url: URL, autoPlay: Bool = true) {
        videoUrl = url
        self.autoPlay = autoPlay
        playerView = AVPlayerViewController()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard autoPlay else {
            return
        }
        playVideo(url: videoUrl)
    }

    public func playVideo(url: URL) {
        playerView.player?.play()
    }

    public func pauseVideo(url: URL) {
        playerView.player?.pause()
    }
}
