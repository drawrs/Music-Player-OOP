import SwiftUI

struct NowPlayingCard: View {
    let artworkName: String
    let title: String
    let subtitle: String
    let isPlaying: Bool

    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.blue.gradient)
                    .frame(width: 80, height: 80)

                Image(systemName: artworkName)
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .symbolEffect(.bounce, isActive: isPlaying)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .lineLimit(1)

                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)

                if isPlaying {
                    Label("Now Playing", systemImage: "waveform")
                        .font(.caption)
                        .foregroundStyle(.blue)
                }
            }

            Spacer()
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal)
        .padding(.top)
    }
}
