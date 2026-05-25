import Foundation
import Combine

class BasePlayer: ObservableObject, Playable, VolumeControllable, Seekable {
    @Published private(set) var isPlaying: Bool = false
    @Published private(set) var volume: Double = 0.5
    @Published private(set) var currentTime: Double = 0

    func play() {
        isPlaying = true
    }

    func pause() {
        isPlaying = false
    }

    func stop() {
        isPlaying = false
        currentTime = 0
    }

    func setVolume(_ value: Double) {
        volume = min(max(value, 0.0), 1.0)
    }

    func seek(to time: Double) {
        currentTime = max(0, time)
    }
}
