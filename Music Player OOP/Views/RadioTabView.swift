import SwiftUI

struct RadioTabView: View {
    let player: RadioPlayer
    let viewModel: MusicAppViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                if let station = player.currentStation {
                    NowPlayingCard(
                        artworkName: station.logoName,
                        title: station.name,
                        subtitle: "\(station.genre) • LIVE",
                        isPlaying: player.isPlaying
                    )
                }

                // ❌ Hampir sama dengan controls di atas tapi beda lagi
                HStack(spacing: 40) {
                    Button(action: { viewModel.radioPlayer.stop() }) {
                        Image(systemName: "stop.fill")
                            .font(.title)
                    }

                    Button(action: {
                        if player.isPlaying {
                            viewModel.radioPlayer.pause()
                        } else {
                            viewModel.radioPlayer.play()
                        }
                    }) {
                        Image(systemName: player.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                            .font(.system(size: 64))
                    }

                    Button(action: {}) {
                        Image(systemName: "antenna.radiowaves.left.and.right")
                            .font(.title)
                    }
                }
                .padding()

                VolumeSlider(volume: Binding(
                    get: { player.volume },
                    set: { viewModel.radioPlayer.setVolume($0) }
                ))

                Spacer()

                // Status info
                Text(viewModel.radioPlayer.getStatusDescription())
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .padding()

                Spacer()
            }
            .navigationTitle("Radio")
        }
    }
}
