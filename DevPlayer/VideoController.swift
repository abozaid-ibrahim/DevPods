//
//  VideoController.swift
//  DevNetwork
//
//  Created by abuzeid on 08.12.20.
//  Copyright © 2020 abuzeid. All rights reserved.
//

import AVFoundation
import AVKit

public final class VideoController: UIViewController {
    private var videoUrl: URL
    private(set) lazy var player = AVPlayer(url: self.videoUrl)
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

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard autoPlay else {
            return
        }
        playVideo(url: videoUrl)
    }

    public func playVideo(url _: URL) {
        playerView.player?.play()
    }

    public func pauseVideo(url _: URL) {
        playerView.player?.pause()
    }
}
