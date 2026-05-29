import Foundation
import Combine

class PodcastPlayer: ObservableObject {
    @Published var currentPodcast: Podcast?
    @Published var isPlaying: Bool = false
    @Published var volume: Double = 0.5
    @Published var currentTime: Double = 0
    @Published var episodes: [Podcast] = []
    @Published var currentIndex: Int = 0
    @Published var playbackSpeed: Double = 1.0

    func play() {
        isPlaying = true
        print("PodcastPlayer: Playing \(currentPodcast?.title ?? "nothing")")
    }

    func pause() {
        isPlaying = false
        print("PodcastPlayer: Paused")
    }

    func stop() {
        isPlaying = false
        currentTime = 0
        print("PodcastPlayer: Stopped")
    }

    func setVolume(_ value: Double) {
        volume = value
    }

    func seekTo(_ time: Double) {
        guard let podcast = currentPodcast else { return }
        currentTime = min(max(0, time), Double(podcast.duration))
    }

    func nextEpisode() {
        if currentIndex < episodes.count - 1 {
            currentIndex += 1
            currentPodcast = episodes[currentIndex]
        }
    }

    func selectEpisode(at index: Int) {
        guard index >= 0 && index < episodes.count else { return }
        currentIndex = index
        currentPodcast = episodes[index]
    }

    func formatTime(_ seconds: Double) -> String {
        let mins = Int(seconds) / 60
        let secs = Int(seconds) % 60
        return String(format: "%02d:%02d", mins, secs)
    }

    func getStatusDescription() -> String {
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
