import Foundation

class RadioPlayer {
    var currentStation: RadioStation?
    var isPlaying: Bool = false       // ❌ DUPLIKAT LAGI!
    var volume: Double = 0.5          // ❌ DUPLIKAT LAGI!

    // ❌ Radio tidak punya currentTime karena live stream
    // Tapi isPlaying dan volume tetap DUPLIKAT dari class lain

    func play() {                     // ❌ DUPLIKAT LAGI!
        isPlaying = true
        print("RadioPlayer: Streaming \(currentStation?.name ?? "nothing")")
    }

    func pause() {                    // ❌ DUPLIKAT LAGI!
        isPlaying = false
        print("RadioPlayer: Paused stream")
    }

    func stop() {                     // ❌ DUPLIKAT LAGI!
        isPlaying = false
        print("RadioPlayer: Disconnected")
    }

    func setVolume(_ value: Double) {  // ❌ DUPLIKAT LAGI!
        volume = value
    }

    func getStatusDescription() -> String {
        // ❌ DUPLIKAT dengan variasi lagi!
        return "Radio: \(isPlaying ? "On Air" : "Off") | Vol: \(Int(volume * 100))%"
    }
}
