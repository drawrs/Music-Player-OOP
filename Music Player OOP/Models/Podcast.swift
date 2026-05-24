import Foundation

struct Podcast {
    var title: String
    var host: String
    private(set) var duration: Int
    private(set) var episodeNumber: Int
    var coverArt: String

    // ❌ MASALAH SAMA: episodeNumber bisa diset ke nilai negatif
    // Tidak ada proteksi data sama sekali
    
    init(title: String, host: String, duration: Int, episodeNumber: Int, coverArt: String) {
        self.title = title
        self.host = host
        self.duration = max(0, duration)
        self.episodeNumber = max(1, episodeNumber)
        self.coverArt = coverArt
    }
}
