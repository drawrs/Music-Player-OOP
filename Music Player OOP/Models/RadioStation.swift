import Foundation

struct RadioStation {
    var name: String
    var genre: String
    var streamURL: String
    var logoName: String

    // ❌ MASALAH: streamURL bisa diset ke string kosong ""
    // Tidak ada validasi format URL
}
