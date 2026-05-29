import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MusicAppViewModel()

    var body: some View {
        TabView(selection: $viewModel.currentTab) {
            MusicTabView(player: viewModel.musicPlayer)
                .tabItem {
                    Label("Music", systemImage: "music.note")
                }
                .tag(0)

            PodcastTabView(player: viewModel.podcastPlayer)
                .tabItem {
                    Label("Podcast", systemImage: "mic.circle")
                }
                .tag(1)
            RadioTabView(player: viewModel.radioPlayer)
                .tabItem {
                    Label("Radio", systemImage: "radio")
                }
                .tag(2)
        }
        .overlay(alignment: .bottom) {
            MiniPlayerHost(
                currentTab: viewModel.currentTab,
                musicPlayer: viewModel.musicPlayer,
                podcastPlayer: viewModel.podcastPlayer,
                radioPlayer: viewModel.radioPlayer
            )
            .padding(.bottom, 52)
        }
    }
}

private struct MiniPlayerHost: View {
    let currentTab: Int
    @ObservedObject var musicPlayer: MusicPlayer
    @ObservedObject var podcastPlayer: PodcastPlayer
    @ObservedObject var radioPlayer: RadioPlayer

    var body: some View {
        switch currentTab {
        case 0:
            if let song = musicPlayer.currentSong {
                MiniPlayerBar(
                    artworkName: song.albumArt,
                    title: song.title,
                    subtitle: song.artist,
                    isPlaying: musicPlayer.isPlaying,
                    onTogglePlayback: toggleMusicPlayback
                )
            }
        case 1:
            if let podcast = podcastPlayer.currentPodcast {
                MiniPlayerBar(
                    artworkName: podcast.coverArt,
                    title: podcast.title,
                    subtitle: podcast.host,
                    isPlaying: podcastPlayer.isPlaying,
                    onTogglePlayback: togglePodcastPlayback
                )
            }
        case 2:
            if let station = radioPlayer.currentStation {
                MiniPlayerBar(
                    artworkName: station.artworkName,
                    title: station.stationName,
                    subtitle: "\(station.frequency) • \(station.currentShow)",
                    isPlaying: radioPlayer.isPlaying,
                    onTogglePlayback: toggleRadioPlayback
                )
            }
        default:
            EmptyView()
        }
    }

    private func toggleMusicPlayback() {
        musicPlayer.isPlaying ? musicPlayer.pause() : musicPlayer.play()
    }

    private func togglePodcastPlayback() {
        podcastPlayer.isPlaying ? podcastPlayer.pause() : podcastPlayer.play()
    }

    private func toggleRadioPlayback() {
        radioPlayer.isPlaying ? radioPlayer.pause() : radioPlayer.play()
    }
}
