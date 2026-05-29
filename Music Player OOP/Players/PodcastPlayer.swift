import Foundation
import Combine

// PodcastPlayer inherits shared playback state and controls from BasePlayer,
// and adds podcast-specific features like playback speed and episode skipping.
class PodcastPlayer: BasePlayer {
    @Published var currentPodcast: Podcast?
    @Published var episodes: [Podcast] = []
    @Published var playbackSpeed: Double = 1.0

    // MARK: - Playback Controls (overriding base behavior)

    override func play() {
        isPlaying = true
        print("PodcastPlayer: Playing \(currentPodcast?.title ?? "nothing")")
    }

    override func pause() {
        isPlaying = false
        print("PodcastPlayer: Paused")
    }

    override func stop() {
        isPlaying = false
        currentTime = 0
        print("PodcastPlayer: Stopped")
    }

    // MARK: - Episode-specific Methods

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

    func setPlaybackSpeed(_ speed: Double) {
        playbackSpeed = speed
    }

    func skipForward30() {
        currentTime += 30
    }

    func skipBackward30() {
        currentTime = max(0, currentTime - 30)
    }

    // MARK: - Status

    override func getStatusDescription() -> String {
        return "Podcast: \(isPlaying ? "Playing" : "Paused") | Vol: \(Int(volume * 100))% | Speed: \(playbackSpeed)x"
    }
}
