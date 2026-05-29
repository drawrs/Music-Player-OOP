import SwiftUI

struct MiniPlayerBar: View {
    let artworkName: String
    let title: String
    let subtitle: String
    let isPlaying: Bool
    let onTogglePlayback: () -> Void

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 12) {
                Image(systemName: artworkName)
                    .font(.title3)
                    .foregroundStyle(.white)
                    .frame(width: 44, height: 44)
                    .background(Color.blue.gradient)
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.subheadline.weight(.semibold))
                        .lineLimit(1)

                    Text(subtitle)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }

                Spacer()

                Button(action: onTogglePlayback) {
                    Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .font(.system(size: 36))
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(.bar)
    }
}
