import SwiftUI

struct MusicTabView: View {
    @ObservedObject var player: MusicPlayer

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Now Playing Card
                if let song = player.currentSong {
                    NowPlayingCard(
                        artworkName: song.albumArt,
                        title: song.title,
                        subtitle: song.artist,
                        isPlaying: player.isPlaying
                    )
                }

                // Controls
                HStack(spacing: 40) {
                    Button(action: { player.previousTrack() }) {
                        Image(systemName: "backward.fill")
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

                    Button(action: { player.nextTrack() }) {
                        Image(systemName: "forward.fill")
                            .font(.title)
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
                        in: 0...Double(player.currentSong?.duration ?? 1)
                    )
                    .tint(.blue)
                    .padding(.horizontal)

                    HStack {
                        Text(player.formatTime(player.currentTime))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text(player.formatTime(Double(player.currentSong?.duration ?? 0)))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical, 4)

                // Volume Slider
                VolumeSlider(volume: Binding(
                    get: { player.volume },
                    set: { player.setVolume($0) }
                ))

                Divider().padding(.vertical, 8)

                // Playlist
                List(player.playlist.indices, id: \.self) { index in
                    let song = player.playlist[index]
                    let isSelected = index == player.currentIndex
                    HStack {
                        Image(systemName: song.albumArt)
                            .frame(width: 40, height: 40)
                            .background(isSelected ? Color.blue.opacity(0.2) : Color.blue.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 8))

                        VStack(alignment: .leading) {
                            Text(song.title)
                                .font(.headline)
                                .foregroundStyle(isSelected ? .blue : .primary)
                            Text(song.artist).font(.caption).foregroundStyle(.secondary)
                        }

                        Spacer()

                        if isSelected {
                            Image(systemName: player.isPlaying ? "speaker.wave.2.fill" : "speaker.fill")
                                .font(.caption)
                                .foregroundStyle(.blue)
                        }

                        Text(player.formatTime(Double(song.duration)))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        player.selectSong(at: index)
                    }
                }
            }
            .navigationTitle("Music")
        }
    }
}
