import SwiftUI

struct MiniPlayerBar: View {
    let artworkName: String
    let title: String
    let subtitle: String
    let isPlaying: Bool
    let progress: Double
    let accentColor: Color
    let onTogglePlayback: () -> Void

    private var clampedProgress: Double {
        min(max(progress, 0), 1)
    }

    var body: some View {
        VStack(spacing: 8) {
            GeometryReader { proxy in
                Capsule()
                    .fill(accentColor.opacity(0.18))
                    .overlay(alignment: .leading) {
                        Capsule()
                            .fill(accentColor)
                            .frame(width: proxy.size.width * clampedProgress)
                    }
            }
            .frame(height: 4)

            HStack(spacing: 12) {
                Image(systemName: artworkName)
                    .font(.title3)
                    .foregroundStyle(.white)
                    .frame(width: 42, height: 42)
                    .background(accentColor.gradient)
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
                        .font(.system(size: 34))
                        .foregroundStyle(accentColor)
                }
            }
        }
        .padding(.horizontal)
        .padding(.top, 8)
        .padding(.bottom, 10)
        .background(.bar)
    }
}
