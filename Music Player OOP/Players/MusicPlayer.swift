import Foundation
import Combine

// ❌ MASALAH BESAR: MusicPlayer dan PodcastPlayer adalah CLASS TERPISAH
//    yang tidak punya hubungan apapun, padahal keduanya adalah "player"
//    dan punya banyak behavior yang sama persis!

class MusicPlayer: ObservableObject {
    @Published var currentSong: Song?
    @Published var isPlaying: Bool = false
    @Published var volume: Double = 0.5
    @Published var currentTime: Double = 0
    @Published var playlist: [Song] = []
    @Published var currentIndex: Int = 0

    // ❌ MASALAH ENCAPSULATION: volume bisa diset 999.0 dari luar!
    // Tidak ada yang mencegah: musicPlayer.volume = 999.0

    func play() {
        isPlaying = true
        print("MusicPlayer: Playing \(currentSong?.title ?? "nothing")")
    }

    func pause() {
        isPlaying = false
        print("MusicPlayer: Paused")
    }

    func stop() {
        isPlaying = false
        currentTime = 0
        print("MusicPlayer: Stopped")
    }

    // ❌ MASALAH: setVolume() ada, tapi volume property tetap bisa diakses langsung
    func setVolume(_ value: Double) {
        volume = value  // Tidak ada validasi range 0.0 - 1.0 !
    }

    func nextTrack() {
        if currentIndex < playlist.count - 1 {
            currentIndex += 1
            currentSong = playlist[currentIndex]
        }
    }

    func previousTrack() {
        if currentIndex > 0 {
            currentIndex -= 1
            currentSong = playlist[currentIndex]
        }
    }

    func formatTime(_ seconds: Double) -> String {
        let mins = Int(seconds) / 60
        let secs = Int(seconds) % 60
        return String(format: "%02d:%02d", mins, secs)
        // ❌ MASALAH: Fungsi ini DUPLIKAT persis di PodcastPlayer!
    }

    func getStatusDescription() -> String {
        return "Music: \(isPlaying ? "Playing" : "Paused") | Vol: \(Int(volume * 100))%"
        // ❌ MASALAH: Logic ini DUPLIKAT di PodcastPlayer dengan sedikit beda
    }
}
