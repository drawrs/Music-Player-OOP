import Foundation
import Combine

class RadioPlayer: ObservableObject {
    @Published var currentStation: Radio?
    @Published var isPlaying: Bool = false
    @Published var volume: Double = 0.5
    @Published var stations: [Radio] = []
    @Published var currentIndex: Int = 0

    func play() {
        isPlaying = true
        print("RadioPlayer: Streaming \(currentStation?.stationName ?? "nothing")")
    }

    func pause() {
        isPlaying = false
        print("RadioPlayer: Paused")
    }

    func stop() {
        isPlaying = false
        print("RadioPlayer: Stopped")
    }

    func setVolume(_ value: Double) {
        volume = value
    }

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

    func getStatusDescription() -> String {
        return "Radio: \(isPlaying ? "Playing" : "Paused") | Vol: \(Int(volume * 100))%"
    }
}
