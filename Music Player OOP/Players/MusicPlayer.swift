import Foundation
import Combine

class MusicPlayer: ObservableObject {
    @Published var currentSong: Song?
    @Published var isPlaying: Bool = false
    @Published var volume: Double = 0.5
    @Published var currentTime: Double = 0
    @Published var playlist: [Song] = []
    @Published var currentIndex: Int = 0

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
        volume = value
    }

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

    func formatTime(_ seconds: Double) -> String {
        let mins = Int(seconds) / 60
        let secs = Int(seconds) % 60
        return String(format: "%02d:%02d", mins, secs)
    }

    func getStatusDescription() -> String {
        return "Music: \(isPlaying ? "Playing" : "Paused") | Vol: \(Int(volume * 100))%"
    }
}
