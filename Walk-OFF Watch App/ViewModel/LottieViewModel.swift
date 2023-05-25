//
//  LottieViewModel.swift
//  Walk-OFF Watch App
//
//  Created by Brandon Nicolas Marlim on 5/22/23.
//

import Foundation
import SwiftUI
import UIKit
import SDWebImageLottieCoder

class LottieViewModel: ObservableObject {
    @Published private(set) var image: UIImage = UIImage(named: "WalkOFF")!

    // MARK: - Animation

    private var coder: SDImageLottieCoder?
    private var animationTimer: Timer?
    private var currentFrame: UInt = 0
    private var playing: Bool = false
    private var speed: Double = 0.5

    /// Loads animation data
    /// - Parameter url: url of animation JSON
    func loadAnimation(url: URL) {
        let session = URLSession.shared
        let dataTask = session.dataTask(with: URLRequest(url: url)) { (data, response, error) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.setupAnimation(with: data)
            }
        }
        dataTask.resume()
    }

    /// Loads animation data from local file
    /// - Parameter filename: name of the local Lottie file
    func loadAnimationFromFile(filename: String) {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            print("Error: JSON file not found")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("Error: No data received")
                return
            }

            DispatchQueue.main.async {
                self.setupAnimation(with: data)
            }
        }.resume()
    }


    /// Decodify animation with given data
    /// - Parameter data: data of animation
    private func setupAnimation(with data: Data) {
        coder = SDImageLottieCoder(animatedImageData: data, options: [SDImageCoderOption.decodeLottieResourcePath: Bundle.main.resourcePath!])

        // resets to first frame
        currentFrame = 0
        setImage(frame: currentFrame)

        play()
    }

    /// Set current animation
    /// - Parameter frame: Set image for given frame
    private func setImage(frame: UInt) {
        guard let coder = coder,
              let uiImage = coder.animatedImageFrame(at: frame) else { return }
        self.image = uiImage
    }

    /// Replace current frame with next one
    private func nextFrame() {
        guard let coder = coder else { return }

        currentFrame += 1
        // make sure that current frame is within frame count
        // if reaches the end, we set it back to 0 so it loops
        if currentFrame >= coder.animatedImageFrameCount {
            currentFrame = 0
        }

        setImage(frame: currentFrame)
    }

    /// Start playing animation
    private func play() {
        playing = true

        animationTimer?.invalidate()
        animationTimer = Timer.scheduledTimer(withTimeInterval: 0.0125/speed, repeats: true, block: { (timer) in
            guard self.playing else {
                timer.invalidate()
                return
            }
            self.nextFrame()
        })
    }

    /// Pauses animation
    private func pause() {
        playing = false
        animationTimer?.invalidate()
    }
}
