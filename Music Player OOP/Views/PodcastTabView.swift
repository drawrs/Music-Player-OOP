import SwiftUI

struct PodcastTabView: View {
    let player: PodcastPlayer
    let viewModel: MusicAppViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if let podcast = player.currentPodcast {
                    NowPlayingCard(
                        artworkName: podcast.coverArt,
                        title: podcast.title,
                        subtitle: "by \(podcast.host) • Ep. \(podcast.episodeNumber)",
                        isPlaying: player.isPlaying
                    )
                }

                // ❌ HAMPIR SAMA dengan Music controls tapi tidak bisa di-share!
                HStack(spacing: 40) {
                    Button(action: { viewModel.podcastPlayer.skipForward30() }) {
                        Image(systemName: "gobackward.30")
                            .font(.title)
                    }

                    Button(action: {
                        if player.isPlaying {
                            viewModel.podcastPlayer.pause()
                        } else {
                            viewModel.podcastPlayer.play()
                        }
                    }) {
                        Image(systemName: player.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                            .font(.system(size: 64))
                    }

                    Button(action: { viewModel.podcastPlayer.skipForward30() }) {
                        Image(systemName: "goforward.30")
                            .font(.title)
                    }
                }
                .padding()

                // Playback Speed - ini unik untuk Podcast
                HStack {
                    Text("Speed:")
                    ForEach([0.5, 1.0, 1.5, 2.0], id: \.self) { speed in
                        Button("\(speed)x") {
                            viewModel.podcastPlayer.setPlaybackSpeed(speed)
                        }
                        .buttonStyle(.bordered)
                        .tint(player.playbackSpeed == speed ? .blue : .gray)
                    }
                }
                .padding()

                VolumeSlider(volume: Binding(
                    get: { player.volume },
                    set: { viewModel.podcastPlayer.setVolume($0) }
                ))

                Divider().padding(.vertical, 8)

                List(player.episodes, id: \.title) { episode in
                    HStack {
                        Image(systemName: episode.coverArt)
                            .frame(width: 40, height: 40)
                            .background(Color.purple.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 8))

                        VStack(alignment: .leading) {
                            Text(episode.title).font(.headline)
                            Text("Ep. \(episode.episodeNumber) • \(episode.host)").font(.caption).foregroundStyle(.secondary)
                        }

                        Spacer()

                        // ❌ DUPLIKAT lagi - formatTime di Podcast player juga sama!
                        Text(player.formatTime(Double(episode.duration)))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("Podcasts")
        }
    }
}
