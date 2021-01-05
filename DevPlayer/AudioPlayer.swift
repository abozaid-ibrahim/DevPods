//
//  AudioPlayer.swift
//  UPlayer
//
//  Created by abuzeid on 25.11.20.
//  Copyright © 2020 abuzeid. All rights reserved.
//

import AVFoundation
import Foundation
import MobileCoreServices
import RxRelay
import RxSwift
//public typealias PlayerItem = (url: URL, duration: Double)
public struct PlayerItem{
    let url: URL
    let duration: Double
}
public protocol AudioPlayerType {
    var state: BehaviorRelay<State> { get }
    var play: PublishRelay<PlayerItem> { get }
    var audioProgress: PublishRelay<Double> { get }
    func pause()
    func toggle()
    func seek(to percentage: Double)
    func resume(to percentage: Double)
}

public final class AudioPlayer: NSObject, AudioPlayerType {
    public let play = PublishRelay<PlayerItem>()
    public let audioProgress = PublishRelay<Double>()
    public let state = BehaviorRelay<State>(value: .idle)
    private let disposeBag = DisposeBag()
    private var player: AVPlayer?
    public static let shared = AudioPlayer()
    override private init() {
        super.init()
        play.observeOn(SerialDispatchQueueScheduler(qos: .default))
            .bind(onNext: { [unowned self] in self.play(with: $0.url, duration: $0.duration) })
            .disposed(by: disposeBag)
    }

    public func pause() {
        player?.pause()
        state.accept(.paused)
    }

    public func resume() {
        player?.play()
        state.accept(.playing)
    }

    public func toggle() {
        if state.value == .playing {
            pause()
        } else if state.value == .paused {
            resume()
        }
    }

    public func seek(to percentage: Double) {
        guard let player = player else { return }
        let duration = player.currentItem?.duration.seconds ?? 0
        let time = CMTime(seconds: duration * percentage, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        player.seek(to: time)
    }

    public func resume(to percentage: Double) {
        guard let player = player else { return }
        state.accept(.playing)
        seek(to: percentage)
        player.play()
    }
}

private extension AudioPlayer {
    func play(with url: URL, duration: Double) {
        let item = AVPlayerItem(url: url)
        setPlaybackActive()
        guard player == nil else {
            playCurrent(item: item)
            return
        }
        player = AVPlayer(playerItem: item)
        player?.rx.error
            .filter { $0 != nil }
            .bind(onNext: { [unowned self] in self.state.accept(.error($0?.localizedDescription ?? "")) })
            .disposed(by: disposeBag)
        playCurrent(item: item)
        updateProgress(with: duration)
    }

    func playCurrent(item: AVPlayerItem) {
        player?.replaceCurrentItem(with: item)
        player?.play()
        state.accept(.playing)
    }

    func setPlaybackActive() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            state.accept(.error(error.localizedDescription))
        }
    }

    func updateProgress(with duration: Double) {
        player?.rx.periodicTimeObserver(interval: CMTime(seconds: 0.2, preferredTimescale: CMTimeScale(NSEC_PER_SEC)))
            .distinctUntilChanged()
            .map { $0.seconds / duration }
            .bind(to: audioProgress)
            .disposed(by: disposeBag)
    }
}
