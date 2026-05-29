import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MusicAppViewModel()

    var body: some View {
        TabView(selection: $viewModel.currentTab) {
            MusicTabView(player: viewModel.musicPlayer)
                .safeAreaInset(edge: .bottom, spacing: 0) {
                    MusicMiniPlayer(player: viewModel.musicPlayer)
                }
                .tabItem {
                    Label("Music", systemImage: "music.note")
                }
                .tag(0)

            PodcastTabView(player: viewModel.podcastPlayer)
                .safeAreaInset(edge: .bottom, spacing: 0) {
                    PodcastMiniPlayer(player: viewModel.podcastPlayer)
                }
                .tabItem {
                    Label("Podcast", systemImage: "mic.circle")
                }
                .tag(1)

            RadioTabView(player: viewModel.radioPlayer)
                .safeAreaInset(edge: .bottom, spacing: 0) {
                    RadioMiniPlayer(player: viewModel.radioPlayer)
                }
                .tabItem {
                    Label("Radio", systemImage: "radio")
                }
                .tag(2)
        }
    }
}

private struct MusicMiniPlayer: View {
    @ObservedObject var player: MusicPlayer

    private var progress: Double {
        guard let duration = player.currentSong?.duration, duration > 0 else { return 0 }
        return player.currentTime / Double(duration)
    }

    var body: some View {
        if let song = player.currentSong {
            MiniPlayerBar(
                artworkName: song.albumArt,
                title: song.title,
                subtitle: song.artist,
                isPlaying: player.isPlaying,
                progress: progress,
                accentColor: .blue,
                onTogglePlayback: togglePlayback
            )
        }
    }

    private func togglePlayback() {
        player.isPlaying ? player.pause() : player.play()
    }
}

private struct PodcastMiniPlayer: View {
    @ObservedObject var player: PodcastPlayer

    private var progress: Double {
        guard let duration = player.currentPodcast?.duration, duration > 0 else { return 0 }
        return player.currentTime / Double(duration)
    }

    var body: some View {
        if let podcast = player.currentPodcast {
            MiniPlayerBar(
                artworkName: podcast.coverArt,
                title: podcast.title,
                subtitle: "Ep. \(podcast.episodeNumber) • \(podcast.host)",
                isPlaying: player.isPlaying,
                progress: progress,
                accentColor: .purple,
                onTogglePlayback: togglePlayback
            )
        }
    }

    private func togglePlayback() {
        player.isPlaying ? player.pause() : player.play()
    }
}

private struct RadioMiniPlayer: View {
    @ObservedObject var player: RadioPlayer

    var body: some View {
        if let station = player.currentStation {
            MiniPlayerBar(
                artworkName: station.artworkName,
                title: station.stationName,
                subtitle: "\(station.frequency) • \(station.currentShow)",
                isPlaying: player.isPlaying,
                progress: player.isPlaying ? 1 : 0,
                accentColor: .orange,
                onTogglePlayback: togglePlayback
            )
        }
    }

    private func togglePlayback() {
        player.isPlaying ? player.pause() : player.play()
    }
}
