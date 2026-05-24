import SwiftUI
import Combine

// Versi latihan ini sengaja disederhanakan agar fokus pembelajaran tetap di
// encapsulation, abstraction, inheritance, dan protocol.
class MusicAppViewModel: ObservableObject {
    let musicPlayer = MusicPlayer()
    let podcastPlayer = PodcastPlayer()

    @Published var currentTab: Int = 0

    init() {
        setupSampleData()
    }

    private func setupSampleData() {
        musicPlayer.loadPlaylist([
            Song(title: "Bohemian Rhapsody", artist: "Queen", duration: 354, albumArt: "music.note"),
            Song(title: "Hotel California", artist: "Eagles", duration: 391, albumArt: "guitars"),
            Song(title: "Imagine", artist: "John Lennon", duration: 187, albumArt: "music.mic"),
            Song(title: "Stairway to Heaven", artist: "Led Zeppelin", duration: 482, albumArt: "music.quarternote.3")
        ])

        podcastPlayer.loadEpisodes([
            Podcast(title: "Swift Concurrency Deep Dive", host: "Swift Talk", duration: 3600, episodeNumber: 42, coverArt: "mic.circle"),
            Podcast(title: "Building Better Apps", host: "Indie Dev", duration: 2700, episodeNumber: 15, coverArt: "headphones"),
            Podcast(title: "SwiftUI Tips & Tricks", host: "Hacking with Swift", duration: 1800, episodeNumber: 88, coverArt: "waveform")
        ])

        // ❌ BUG: Volume bisa diset ke nilai invalid, dan tidak ada yang mencegah!
        musicPlayer.setVolume(1.5)  // Sekarang akan di-clamp ke 1.0
    }
}
