import Foundation

struct Podcast {
    var title: String
    var host: String
    var duration: Int
    var episodeNumber: Int
    var coverArt: String

    // ❌ MASALAH SAMA: episodeNumber bisa diset ke nilai negatif
    // Tidak ada proteksi data sama sekali
}
