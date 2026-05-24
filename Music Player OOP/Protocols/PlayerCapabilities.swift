import Foundation

protocol Playable {
    var isPlaying: Bool { get }

    func play()
    func pause()
    func stop()
}

protocol VolumeControllable {
    var volume: Double { get }

    func setVolume(_ value: Double)
}

protocol Seekable {
    var currentTime: Double { get }

    func seek(to time: Double)
}
