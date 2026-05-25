import SwiftUI

// ❌ MASALAH: MusicTabView dan PodcastTabView sangat mirip strukturnya
//    tapi tidak bisa di-reuse karena tidak ada abstraksi/protocol yang sama
struct MusicTabView: View {
    @ObservedObject var player: MusicPlayer

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                NowPlayingCard(
                    artworkName: player.nowPlayingArtworkName,
                    title: player.nowPlayingTitle,
                    subtitle: player.nowPlayingSubtitle,
                    isPlaying: player.isPlaying
                )

                // Controls
                // ❌ MASALAH: Controls ini hampir sama dengan PodcastTabView
                //    tapi tidak bisa di-share karena beda tipe
                HStack(spacing: 40) {
                    Button(action: { player.previousTrack() }) {
                        Image(systemName: "backward.fill")
                            .font(.title)
                    }

                    Button(action: {
                        player.togglePlayback()
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

                // Volume Slider
                VolumeSlider(volume: volumeBinding(for: player))

                Divider().padding(.vertical, 8)

                // Playlist
                List(player.playlist, id: \.title) { song in
                    HStack {
                        Image(systemName: song.albumArt)
                            .frame(width: 40, height: 40)
                            .background(Color.blue.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 8))

                        VStack(alignment: .leading) {
                            Text(song.title).font(.headline)
                            Text(song.artist).font(.caption).foregroundStyle(.secondary)
                        }

                        Spacer()

                        Text(PlaybackTimeFormatter.format(seconds: Double(song.duration)))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("Music")
        }
    }
}
