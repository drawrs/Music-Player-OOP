import Foundation

struct Song {
    var title: String
    var artist: String
    private(set) var duration: Int  // in seconds
    var albumArt: String // SF Symbol name
    
    init(title: String, artist: String, duration: Int, albumArt: String) {
        self.title = title
        self.artist = artist
        self.duration = max(0, duration)
        self.albumArt = albumArt
    }
    
    mutating func changeDuration(to duration: Int) {
        self.duration = max(0, duration)
    }
}
