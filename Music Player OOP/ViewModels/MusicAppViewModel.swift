import SwiftUI
import Combine

class MusicAppViewModel: ObservableObject {
    let musicPlayer = MusicPlayer()
    let podcastPlayer = PodcastPlayer()
    let radioPlayer = RadioPlayer()

    @Published var currentTab: Int = 0

    init() {
        setupSampleData()
    }

    private func setupSampleData() {
        // Setup songs
        musicPlayer.playlist = [
            Song(title: "Bohemian Rhapsody", artist: "Queen", duration: 354, albumArt: "music.note"),
            Song(title: "Hotel California", artist: "Eagles", duration: 391, albumArt: "guitars"),
            Song(title: "Imagine", artist: "John Lennon", duration: 187, albumArt: "music.mic"),
            Song(title: "Stairway to Heaven", artist: "Led Zeppelin", duration: 482, albumArt: "music.quarternote.3")
        ]
        musicPlayer.currentSong = musicPlayer.playlist.first

        // Setup podcasts
        podcastPlayer.episodes = [
            Podcast(title: "Swift Concurrency Deep Dive", host: "Swift Talk", duration: 3600, episodeNumber: 42, coverArt: "mic.circle"),
            Podcast(title: "Building Better Apps", host: "Indie Dev", duration: 2700, episodeNumber: 15, coverArt: "headphones"),
            Podcast(title: "SwiftUI Tips & Tricks", host: "Hacking with Swift", duration: 1800, episodeNumber: 88, coverArt: "waveform")
        ]
        podcastPlayer.currentPodcast = podcastPlayer.episodes.first

        // Setup radio stations
        radioPlayer.stations = [
            Radio(stationName: "Jakarta Hits FM", frequency: "101.4 FM", genre: "Pop", currentShow: "Morning Drive", artworkName: "radio"),
            Radio(stationName: "Indie Wave", frequency: "96.8 FM", genre: "Indie", currentShow: "Fresh Finds", artworkName: "dot.radiowaves.left.and.right"),
            Radio(stationName: "Night Jazz", frequency: "88.2 FM", genre: "Jazz", currentShow: "Late Lounge", artworkName: "music.note.list"),
            Radio(stationName: "Campus Talk", frequency: "107.7 FM", genre: "Talk", currentShow: "Student Voices", artworkName: "person.wave.2")
        ]
        radioPlayer.currentStation = radioPlayer.stations.first

        musicPlayer.volume = 1.5
    }
}
