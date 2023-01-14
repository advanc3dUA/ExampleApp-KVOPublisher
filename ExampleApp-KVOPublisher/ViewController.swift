//
//  ViewController.swift
//  ExampleApp-KVOPublisher
//
//  Created by Yuriy Gudimov on 14.01.2023.
//

import UIKit
import AVKit
import AVFoundation
import Combine

class ViewController: UIViewController {

    @IBOutlet weak var videoContainer: UIView!
    
    private var playerController: AVPlayerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPlayerController()
    }

    private func setupPlayerController() {
        playerController = AVPlayerViewController()
//        addChild(playerController)

        videoContainer.addSubview(playerController.view)
        playerController.view.frame = videoContainer.bounds
        playerController.view.backgroundColor = .black
        playerController.didMove(toParent: self)

        let player = AVPlayer()
        player.volume = 0
        playerController.player = player
    }

    @IBAction func loadVideoPressed(_ sender: UIButton) {
        playerController.player?.pause()

        let playItem = AVPlayerItem(url: URL(string: "https://download.samplelib.com/mp4/sample-5s.mp4")!)

        playerController.player?.replaceCurrentItem(with: playItem)
    }
}

