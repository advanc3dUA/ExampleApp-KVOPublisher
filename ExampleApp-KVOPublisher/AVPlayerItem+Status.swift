//
//  AVPlayerItem+Status.swift
//  ExampleApp-KVOPublisher
//
//  Created by Yuriy Gudimov on 14.01.2023.
//

import AVKit

extension AVPlayerItem.Status {
    public var stringValue: String {
        switch self {
        case .failed: return "Player item failed"
        case .readyToPlay: return "Ready to play"
        default: return "???"
        }
    }
}
