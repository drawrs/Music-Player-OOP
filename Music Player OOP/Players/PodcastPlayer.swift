import Foundation
import Combine

class PodcastPlayer: ObservableObject, Playable, VolumeControllable, Seekable {
    @Published var currentPodcast: Podcast?
    @Published var isPlaying: Bool = false      // ❌ DUPLIKAT dari MusicPlayer
    @Published private(set) var volume: Double = 0.5         // ❌ DUPLIKAT dari MusicPlayer
    @Published private(set) var currentTime: Double = 0      // ❌ DUPLIKAT dari MusicPlayer
    @Published private(set) var episodes: [Podcast] = []
    @Published private(set) var currentIndex: Int = 0        // ❌ DUPLIKAT dari MusicPlayer
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
        volume = min(max(value, 0.0), 1.0)
    }

    func seek(to time: Double) {
        currentTime = max(0, time)
    }

    func loadEpisodes(_ podcasts: [Podcast]) {
        episodes = podcasts
        currentIndex = 0
        currentPodcast = podcasts.first
        currentTime = 0
        isPlaying = false
    }

    func selectEpisode(at index: Int) {
        guard episodes.indices.contains(index) else { return }
        currentIndex = index
        currentPodcast = episodes[index]
    }

    func nextEpisode() {
        if currentIndex < episodes.count - 1 {
            selectEpisode(at: currentIndex + 1)
        }
    }

    func getStatusDescription() -> String {
        // ❌ DUPLIKAT dengan sedikit modifikasi - susah di-maintain!
        return "Podcast: \(isPlaying ? "Playing" : "Paused") | Vol: \(Int(volume * 100))% | Speed: \(playbackSpeed)x"
    }

    func setPlaybackSpeed(_ speed: Double) {
        playbackSpeed = speed
    }

    func skipForward30() {
        seek(to: currentTime + 30)
    }

    func skipBackward30() {
        seek(to: currentTime - 30)
    }
}
