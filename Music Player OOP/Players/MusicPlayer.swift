import Foundation
import Combine

// ❌ MASALAH BESAR: MusicPlayer dan PodcastPlayer adalah CLASS TERPISAH
//    yang tidak punya hubungan apapun, padahal keduanya adalah "player"
//    dan punya banyak behavior yang sama persis!

class MusicPlayer: BasePlayer {
    @Published var currentSong: Song?
    @Published private(set) var playlist: [Song] = []
    @Published private(set) var currentIndex: Int = 0

    override func play() {
        super.play()
        print("MusicPlayer: Playing \(currentSong?.title ?? "nothing")")
    }

    override func pause() {
        super.pause()
        print("MusicPlayer: Paused")
    }

    override func stop() {
        super.stop()
        print("MusicPlayer: Stopped")
    }

    func loadPlaylist(_ songs: [Song]) {
        playlist = songs
        currentIndex = 0
        currentSong = songs.first
        stop()
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

    func getStatusDescription() -> String {
        return "Music: \(isPlaying ? "Playing" : "Paused") | Vol: \(Int(volume * 100))%"
        // ❌ MASALAH: Logic ini DUPLIKAT di PodcastPlayer dengan sedikit beda
    }
}
