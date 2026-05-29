import Foundation
import Combine

// Parent class — shared playback behavior for all player types
class BasePlayer: ObservableObject {
    @Published var isPlaying: Bool = false
    @Published var volume: Double = 0.5
    @Published var currentTime: Double = 0
    @Published var currentIndex: Int = 0

    // MARK: - Playback Controls

    func play() {
        isPlaying = true
        print("BasePlayer: Playing")
    }

    func pause() {
        isPlaying = false
        print("BasePlayer: Paused")
    }

    func stop() {
        isPlaying = false
        currentTime = 0
        print("BasePlayer: Stopped")
    }

    func setVolume(_ value: Double) {
        volume = min(max(0, value), 1.0)
    }

    // MARK: - Utilities

    func formatTime(_ seconds: Double) -> String {
        let mins = Int(seconds) / 60
        let secs = Int(seconds) % 60
        return String(format: "%02d:%02d", mins, secs)
    }

    func getStatusDescription() -> String {
        return "BasePlayer: \(isPlaying ? "Playing" : "Paused") | Vol: \(Int(volume * 100))%"
    }
}
