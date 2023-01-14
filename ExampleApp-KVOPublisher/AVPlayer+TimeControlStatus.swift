//
//  AVPlayer+TimeControlStatus.swift
//  ExampleApp-KVOPublisher
//
//  Created by Yuriy Gudimov on 14.01.2023.
//

import AVKit

extension AVPlayer.TimeControlStatus {
    var stringValue: String {
        switch self {
        case .paused: return "Paused"
        case .playing: return "Playing"
        case .waitingToPlayAtSpecifiedRate: return "Buffering"
        default: return "?"
        }
    }
}
