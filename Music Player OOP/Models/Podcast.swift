import Foundation

struct Podcast {
    var title: String
    var host: String
    private(set) var duration: Int
    private(set) var episodeNumber: Int
    var coverArt: String
    
    init(title: String, host: String, duration: Int, episodeNumber: Int, coverArt: String) {
        self.title = title
        self.host = host
        self.duration = max(0, duration)
        self.episodeNumber = max(1, episodeNumber)
        self.coverArt = coverArt
    }
    
    mutating func incrementEpisodeNumber() {
        episodeNumber += 1
    }
    
    mutating func incrementDuration(by amount: Int) {
        guard amount > 0 else { return }
        duration += amount
    }
}
