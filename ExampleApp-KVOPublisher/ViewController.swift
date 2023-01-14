//
//  ViewController.swift
//  ExampleApp-KVOPublisher
//
//  Created by Yuriy Gudimov on 14.01.2023.
//

import UIKit
import AVKit
import Combine

class ViewController: UIViewController {
    
    //MARK: - Outlets

    @IBOutlet weak var videoContainer: UIView!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var logTextView: UITextView!
    
    private var playerController: AVPlayerViewController!
    
    var playerItemStatusCancellable: AnyCancellable?
    var cancellables: Set<AnyCancellable> = []
    
    @Published
    var videoIsLoaded = false
    
    //MARK: - Viewcycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPlayerController()
    }

    private func setupPlayerController() {
        playerController = AVPlayerViewController()

        videoContainer.addSubview(playerController.view)
        playerController.view.frame = videoContainer.bounds
        playerController.view.backgroundColor = .black
        playerController.didMove(toParent: self)

        let player = AVPlayer()
        player.volume = 0
        playerController.player = player
        
        let isPlaying = player.publisher(for: \.rate)
            .map { $0 > 0 }
        
        isPlaying
            .assign(to: \.isEnabled, on: pauseButton)
            .store(in: &cancellables)
        

        isPlaying
            .combineLatest($videoIsLoaded)
            .map { isPlaying, videoIsLoaded in
                return !isPlaying && videoIsLoaded
            }
            .assign(to: \.isEnabled, on: playButton)
            .store(in: &cancellables)
    }
    
    //MARK: - Actions

    @IBAction func loadVideoPressed(_ sender: UIButton) {
        playerController.player?.pause()

        let playItem = AVPlayerItem(url: URL(string: "https://download.samplelib.com/mp4/sample-5s.mp4")!)

        playerController.player?.replaceCurrentItem(with: playItem)
        
        playerItemStatusCancellable = playItem.publisher(for: \.status)
            .sink { [weak self] status in
                self?.statusLabel.text = status.stringValue
            }
        
        playItem.publisher(for: \.status)
            .map { $0 == .readyToPlay }
            .sink { [weak self] in
                self?.videoIsLoaded = $0
            }
            .store(in: &cancellables)
    }
    
    @IBAction func playPressed(_ sender: UIButton) {
        playerController.player?.play()
    }
    
    @IBAction func pausePressed(_ sender: UIButton) {
        playerController.player?.pause()
    }
    
    private func appendLog(_ text: String) {
        logTextView.text.append("\(text)\n")
    }
}
