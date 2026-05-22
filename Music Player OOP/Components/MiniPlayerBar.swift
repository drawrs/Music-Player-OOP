import SwiftUI

// ❌ MASALAH: MiniPlayerBar harus tahu detail semua tipe player
//    dan punya if-else yang makin panjang kalau player bertambah
struct MiniPlayerBar: View {
    let viewModel: MusicAppViewModel

    // ❌ Harus cek satu-satu untuk tahu apa yang sedang play
    private var currentTitle: String {
        if viewModel.musicPlayer.isPlaying {
            return viewModel.musicPlayer.currentSong?.title ?? ""
        } else if viewModel.podcastPlayer.isPlaying {
            return viewModel.podcastPlayer.currentPodcast?.title ?? ""
        } else if viewModel.radioPlayer.isPlaying {
            return viewModel.radioPlayer.currentStation?.name ?? ""
        }
        return ""
    }

    private var currentSubtitle: String {
        if viewModel.musicPlayer.isPlaying {
            return viewModel.musicPlayer.currentSong?.artist ?? ""
        } else if viewModel.podcastPlayer.isPlaying {
            return viewModel.podcastPlayer.currentPodcast?.host ?? ""
        } else if viewModel.radioPlayer.isPlaying {
            return "LIVE"
        }
        return ""
    }

    private var currentArt: String {
        if viewModel.musicPlayer.isPlaying {
            return viewModel.musicPlayer.currentSong?.albumArt ?? "music.note"
        } else if viewModel.podcastPlayer.isPlaying {
            return viewModel.podcastPlayer.currentPodcast?.coverArt ?? "mic"
        } else if viewModel.radioPlayer.isPlaying {
            return viewModel.radioPlayer.currentStation?.logoName ?? "radio"
        }
        return "music.note"
    }

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: currentArt)
                .font(.title2)
                .frame(width: 44, height: 44)
                .background(Color.blue.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 2) {
                Text(currentTitle)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .lineLimit(1)
                Text(currentSubtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }

            Spacer()

            // ❌ Stop button juga harus tahu semua tipe player
            Button(action: { viewModel.stopAll() }) {
                Image(systemName: "stop.circle.fill")
                    .font(.title)
                    .foregroundStyle(.red)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal)
        .shadow(radius: 4)
    }
}
