import Foundation
import Combine

class BasePlayer: ObservableObject {
    @Published private(set) var isPlaying: Bool = false
    @Published private(set) var volume: Double = 0.5

    var miniPlayerArtworkName: String {
        "play.circle"
    }

    var miniPlayerTitle: String {
        "Nothing Playing"
    }

    var miniPlayerSubtitle: String {
        "Choose something to start"
    }

    func play() {
        isPlaying = true
    }

    func pause() {
        isPlaying = false
    }

    func stop() {
        isPlaying = false
    }

    func togglePlayback() {
        if isPlaying {
            pause()
        } else {
            play()
        }
    }

    func setVolume(_ value: Double) {
        volume = min(max(value, 0.0), 1.0)
    }
}
