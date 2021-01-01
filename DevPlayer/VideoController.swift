//
//  VideoController.swift
//  Direct
//
//  Created by abuzeid on 7/5/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import AVFoundation
import AVKit

class VideoController: UIViewController {
    private var videoUrl: String
    var player: AVPlayer
    var autoPlay: Bool
    override func loadView() {
        view = UIView()
    }

    init(url: String, autoPlay: Bool = true) {
        self.videoUrl = url
        self.autoPlay = autoPlay
        self.player = AVPlayer(url: URL(string: url)!)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if autoPlay {
            guard let url = URL(string: videoUrl) else {
                return
            }
            playVideo(url: url)
        }
    }

    func playVideo(url: URL) {
        let player = AVPlayer(url: url)

        let vc = AVPlayerViewController()
        vc.player = player
    
        addChild(vc)
        view.addSubview(vc.view)
        vc.view.frame = view.bounds

        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
            DispatchQueue.main.sync {
                vc.player?.play()
            }
        }
    }
}
