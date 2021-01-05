//
//  AudioPlayerState.swift
//  UPlayer
//
//  Created by abuzeid on 01.12.20.
//  Copyright © 2020 abuzeid. All rights reserved.
//

import Foundation

public enum State: Equatable {
    case playing
    case paused
    case idle
    case error(String)
    public static func == (lhs: State, rhs: State) -> Bool {
        switch (lhs, rhs) {
        case let (.error(lMsg), .error(item: rMsg)):
            return lMsg == rMsg
        case (.idle, .idle),
             (.playing, .playing),
             (.paused, .paused):
            return true
        default:
            return false
        }
    }
}
