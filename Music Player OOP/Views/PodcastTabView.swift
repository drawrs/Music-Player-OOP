import SwiftUI

struct PodcastTabView: View {
    @ObservedObject var player: PodcastPlayer

    private func speedLabel(for speed: Double) -> String {
        String(format: "%.1fx", speed)
    }

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

                HStack(spacing: 40) {
                    Button(action: { player.skipBackward30() }) {
                        Image(systemName: "gobackward.30")
                            .font(.title)
                    }

                    Button(action: {
                        if player.isPlaying {
                            player.pause()
                        } else {
                            player.play()
                        }
                    }) {
                        Image(systemName: player.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                            .font(.system(size: 64))
                    }

                    Button(action: { player.skipForward30() }) {
                        Image(systemName: "goforward.30")
                            .font(.title)
                    }
                }
                .padding()

                // Playback Speed - ini unik untuk Podcast
                HStack {
                    Text("Speed:")
                    ForEach([0.5, 1.0, 1.5, 2.0], id: \.self) { speed in
                        Button(speedLabel(for: speed)) {
                            player.setPlaybackSpeed(speed)
                        }
                        .buttonStyle(.bordered)
                        .tint(player.playbackSpeed == speed ? .blue : .gray)
                    }
                }
                .padding()

                // Duration Slider
                VStack(spacing: 4) {
                    Slider(
                        value: Binding(
                            get: { player.currentTime },
                            set: { player.seekTo($0) }
                        ),
                        in: 0...Double(player.currentPodcast?.duration ?? 1)
                    )
                    .tint(.purple)
                    .padding(.horizontal)

                    HStack {
                        Text(player.formatTime(player.currentTime))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text(player.formatTime(Double(player.currentPodcast?.duration ?? 0)))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical, 4)

                VolumeSlider(volume: Binding(
                    get: { player.volume },
                    set: { player.setVolume($0) }
                ))

                Divider().padding(.vertical, 8)

                List(player.episodes.indices, id: \.self) { index in
                    let episode = player.episodes[index]
                    let isSelected = index == player.currentIndex
                    HStack {
                        Image(systemName: episode.coverArt)
                            .frame(width: 40, height: 40)
                            .background(isSelected ? Color.purple.opacity(0.2) : Color.purple.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 8))

                        VStack(alignment: .leading) {
                            Text(episode.title)
                                .font(.headline)
                                .foregroundStyle(isSelected ? .purple : .primary)
                            Text("Ep. \(episode.episodeNumber) • \(episode.host)").font(.caption).foregroundStyle(.secondary)
                        }

                        Spacer()

                        if isSelected {
                            Image(systemName: player.isPlaying ? "speaker.wave.2.fill" : "speaker.fill")
                                .font(.caption)
                                .foregroundStyle(.purple)
                        }

                        Text(player.formatTime(Double(episode.duration)))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        player.selectEpisode(at: index)
                    }
                }
            }
            .navigationTitle("Podcasts")
        }
    }
}
