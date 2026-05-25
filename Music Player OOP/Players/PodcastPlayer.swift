import Foundation
import Combine

class PodcastPlayer: BasePlayer {
    @Published var currentPodcast: Podcast?
    @Published private(set) var episodes: [Podcast] = []
    @Published private(set) var currentIndex: Int = 0
    @Published var playbackSpeed: Double = 1.0  // Ini yang unik untuk Podcast

    var nowPlayingArtworkName: String {
        currentPodcast?.coverArt ?? "mic.circle"
    }

    var nowPlayingTitle: String {
        currentPodcast?.title ?? "No Podcast Selected"
    }

    var nowPlayingSubtitle: String {
        guard let podcast = currentPodcast else { return "Choose an episode to start" }
        return "by \(podcast.host) • Ep. \(podcast.episodeNumber)"
    }

    override func play() {
        super.play()
        print("PodcastPlayer: Playing \(currentPodcast?.title ?? "nothing")")
    }

    override func pause() {
        super.pause()
        print("PodcastPlayer: Paused")
    }

    override func stop() {
        super.stop()
        print("PodcastPlayer: Stopped")
    }

    func loadEpisodes(_ podcasts: [Podcast]) {
        episodes = podcasts
        currentIndex = 0
        currentPodcast = podcasts.first
        stop()
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
