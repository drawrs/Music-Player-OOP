import SwiftUI

struct MiniPlayerBar: View {
    @ObservedObject var player: BasePlayer

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 12) {
                Image(systemName: player.miniPlayerArtworkName)
                    .font(.title3)
                    .foregroundStyle(.white)
                    .frame(width: 44, height: 44)
                    .background(Color.blue.gradient)
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                VStack(alignment: .leading, spacing: 2) {
                    Text(player.miniPlayerTitle)
                        .font(.subheadline.weight(.semibold))
                        .lineLimit(1)

                    Text(player.miniPlayerSubtitle)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }

                Spacer()

                Button(action: { player.togglePlayback() }) {
                    Image(systemName: player.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .font(.system(size: 36))
                }
            }

            if let seekablePlayer = player as? Seekable, seekablePlayer.seekDuration > 0 {
                Slider(
                    value: Binding(
                        get: { seekablePlayer.currentTime },
                        set: { seekablePlayer.seek(to: $0) }
                    ),
                    in: 0...seekablePlayer.seekDuration
                )
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(.bar)
    }
}
