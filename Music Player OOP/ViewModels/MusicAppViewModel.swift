import SwiftUI
import Combine

// ❌ MASALAH BESAR: ViewModel ini harus menangani 3 tipe player secara terpisah.
//    Setiap kali tambah tipe player baru, harus ubah class ini!
class MusicAppViewModel: ObservableObject {
    @Published var musicPlayer = MusicPlayer()
    @Published var podcastPlayer = PodcastPlayer()
    @Published var radioPlayer = RadioPlayer()

    @Published var currentTab: Int = 0
    @Published var showingNowPlaying: Bool = false

    // ❌ MASALAH: Tidak ada cara unified untuk tahu "apakah ada sesuatu yang sedang play"
    //    Harus cek satu-satu!
    var isAnythingPlaying: Bool {
        return musicPlayer.isPlaying || podcastPlayer.isPlaying || radioPlayer.isPlaying
    }

    // ❌ MASALAH: Untuk stop semua, harus panggil stop() di masing-masing secara manual
    func stopAll() {
        musicPlayer.stop()      // Kalau ada player ke-4, harus tambah di sini juga!
        podcastPlayer.stop()
        radioPlayer.stop()
    }

    // ❌ MASALAH: getStatusDescription harus tahu ada 3 tipe player berbeda
    func getCurrentStatus() -> String {
        if musicPlayer.isPlaying { return musicPlayer.getStatusDescription() }
        if podcastPlayer.isPlaying { return podcastPlayer.getStatusDescription() }
        if radioPlayer.isPlaying { return radioPlayer.getStatusDescription() }
        return "Nothing playing"
    }

    init() {
        setupSampleData()
    }

    private func setupSampleData() {
        // Setup songs
        musicPlayer.playlist = [
            Song(title: "Bohemian Rhapsody", artist: "Queen", duration: 354, albumArt: "music.note"),
            Song(title: "Hotel California", artist: "Eagles", duration: 391, albumArt: "guitars"),
            Song(title: "Imagine", artist: "John Lennon", duration: 187, albumArt: "music.mic"),
            Song(title: "Stairway to Heaven", artist: "Led Zeppelin", duration: 482, albumArt: "music.quarternote.3")
        ]
        musicPlayer.currentSong = musicPlayer.playlist.first

        // Setup podcasts
        podcastPlayer.episodes = [
            Podcast(title: "Swift Concurrency Deep Dive", host: "Swift Talk", duration: 3600, episodeNumber: 42, coverArt: "mic.circle"),
            Podcast(title: "Building Better Apps", host: "Indie Dev", duration: 2700, episodeNumber: 15, coverArt: "headphones"),
            Podcast(title: "SwiftUI Tips & Tricks", host: "Hacking with Swift", duration: 1800, episodeNumber: 88, coverArt: "waveform")
        ]
        podcastPlayer.currentPodcast = podcastPlayer.episodes.first

        // Setup radio
        radioPlayer.currentStation = RadioStation(name: "Jazz FM", genre: "Jazz", streamURL: "https://stream.jazz.fm", logoName: "radio")

        // ❌ BUG: Volume bisa diset ke nilai invalid, dan tidak ada yang mencegah!
        musicPlayer.volume = 1.5  // INI VALID PADAHAL HARUSNYA TIDAK! Volume max harusnya 1.0
    }
}
