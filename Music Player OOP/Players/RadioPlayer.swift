import Foundation
import Combine

// RadioPlayer inherits shared playback state and controls from BasePlayer,
// and adds station-specific navigation.
class RadioPlayer: BasePlayer {
    @Published var currentStation: Radio?
    @Published var stations: [Radio] = []

    // MARK: - Playback Controls (overriding base behavior)

    override func play() {
        isPlaying = true
        print("RadioPlayer: Streaming \(currentStation?.stationName ?? "nothing")")
    }

    override func pause() {
        isPlaying = false
        print("RadioPlayer: Paused")
    }

    override func stop() {
        isPlaying = false
        currentTime = 0
        print("RadioPlayer: Stopped")
    }

    // MARK: - Station-specific Methods

    func nextStation() {
        if currentIndex < stations.count - 1 {
            currentIndex += 1
            currentStation = stations[currentIndex]
        }
    }

    func previousStation() {
        if currentIndex > 0 {
            currentIndex -= 1
            currentStation = stations[currentIndex]
        }
    }

    func selectStation(at index: Int) {
        guard index >= 0 && index < stations.count else { return }
        currentIndex = index
        currentStation = stations[index]
    }

    // MARK: - Status

    override func getStatusDescription() -> String {
        return "Radio: \(isPlaying ? "Playing" : "Paused") | Vol: \(Int(volume * 100))%"
    }
}
