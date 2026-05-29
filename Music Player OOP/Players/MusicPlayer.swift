import Foundation
import Combine

// MusicPlayer inherits shared playback state and controls from BasePlayer
class MusicPlayer: BasePlayer {
    @Published var currentSong: Song?
    @Published var playlist: [Song] = []

    // MARK: - Playback Controls (overriding base behavior)

    override func play() {
        isPlaying = true
        print("MusicPlayer: Playing \(currentSong?.title ?? "nothing")")
    }

    override func pause() {
        isPlaying = false
        print("MusicPlayer: Paused")
    }

    override func stop() {
        isPlaying = false
        currentTime = 0
        print("MusicPlayer: Stopped")
    }

    // MARK: - Song-specific Methods

    func seekTo(_ time: Double) {
        guard let song = currentSong else { return }
        currentTime = min(max(0, time), Double(song.duration))
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

    func selectSong(at index: Int) {
        guard index >= 0 && index < playlist.count else { return }
        currentIndex = index
        currentSong = playlist[index]
    }

    // MARK: - Status

    override func getStatusDescription() -> String {
        return "Music: \(isPlaying ? "Playing" : "Paused") | Vol: \(Int(volume * 100))%"
    }
}
