import Foundation

// ✅ Struct ini sudah OK sebagai data model sederhana
struct Song {
    var title: String
    var artist: String
    private(set) var duration: Int  // in seconds
    var albumArt: String // SF Symbol name

    // ❌ MASALAH: Tidak ada validasi. duration bisa diset ke -999
    // Siapapun bisa melakukan: song.duration = -999 dan tidak ada yang mencegah
    
    init(title: String, artist: String, duration: Int, albumArt: String) {
        self.title = title
        self.artist = artist
        self.duration = max(0, duration)
        self.albumArt = albumArt
    }
}
