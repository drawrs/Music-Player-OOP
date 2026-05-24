import Foundation
import Combine

// ❌ MASALAH BESAR: MusicPlayer dan PodcastPlayer adalah CLASS TERPISAH
//    yang tidak punya hubungan apapun, padahal keduanya adalah "player"
//    dan punya banyak behavior yang sama persis!

class MusicPlayer: ObservableObject {
    @Published var currentSong: Song?
    @Published var isPlaying: Bool = false
    @Published private(set) var volume: Double = 0.5
    @Published private(set) var currentTime: Double = 0
    @Published var playlist: [Song] = []
    @Published private(set) var currentIndex: Int = 0

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

    func setVolume(_ value: Double) {
        volume = min(max(value, 0.0), 1.0)
    }

    func seek(to time: Double) {
        currentTime = max(0, time)
    }

    func selectTrack(at index: Int) {
        guard playlist.indices.contains(index) else { return }
        currentIndex = index
        currentSong = playlist[index]
    }

    func nextTrack() {
        if currentIndex < playlist.count - 1 {
            selectTrack(at: currentIndex + 1)
        }
    }

    func previousTrack() {
        if currentIndex > 0 {
            selectTrack(at: currentIndex - 1)
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
