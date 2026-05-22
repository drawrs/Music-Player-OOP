import Foundation
import Combine

class PodcastPlayer: ObservableObject {
    @Published var currentPodcast: Podcast?
    @Published var isPlaying: Bool = false      // ❌ DUPLIKAT dari MusicPlayer
    @Published var volume: Double = 0.5         // ❌ DUPLIKAT dari MusicPlayer
    @Published var currentTime: Double = 0      // ❌ DUPLIKAT dari MusicPlayer
    @Published var episodes: [Podcast] = []
    @Published var currentIndex: Int = 0        // ❌ DUPLIKAT dari MusicPlayer
    @Published var playbackSpeed: Double = 1.0  // Ini yang unik untuk Podcast

    func play() {                    // ❌ DUPLIKAT dari MusicPlayer
        isPlaying = true
        print("PodcastPlayer: Playing \(currentPodcast?.title ?? "nothing")")
    }

    func pause() {                   // ❌ DUPLIKAT dari MusicPlayer
        isPlaying = false
        print("PodcastPlayer: Paused")
    }

    func stop() {                    // ❌ DUPLIKAT dari MusicPlayer
        isPlaying = false
        currentTime = 0
        print("PodcastPlayer: Stopped")
    }

    func setVolume(_ value: Double) { // ❌ DUPLIKAT dari MusicPlayer
        volume = value
    }

    func nextEpisode() {
        if currentIndex < episodes.count - 1 {
            currentIndex += 1
            currentPodcast = episodes[currentIndex]
        }
    }

    func formatTime(_ seconds: Double) -> String {  // ❌ DUPLIKAT PERSIS dari MusicPlayer!
        let mins = Int(seconds) / 60
        let secs = Int(seconds) % 60
        return String(format: "%02d:%02d", mins, secs)
    }

    func getStatusDescription() -> String {
        // ❌ DUPLIKAT dengan sedikit modifikasi - susah di-maintain!
        return "Podcast: \(isPlaying ? "Playing" : "Paused") | Vol: \(Int(volume * 100))% | Speed: \(playbackSpeed)x"
    }

    func setPlaybackSpeed(_ speed: Double) {
        playbackSpeed = speed
    }

    func skipForward30() {
        currentTime += 30
    }

    func skipBackward30() {
        currentTime = max(0, currentTime - 30)
    }
}
