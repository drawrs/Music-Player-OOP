import SwiftUI

struct RadioTabView: View {
    @ObservedObject var player: RadioPlayer

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if let station = player.currentStation {
                    NowPlayingCard(
                        artworkName: station.artworkName,
                        title: station.stationName,
                        subtitle: "\(station.frequency) • \(station.currentShow)",
                        isPlaying: player.isPlaying
                    )
                }

                HStack(spacing: 40) {
                    Button(action: { player.previousStation() }) {
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

                    Button(action: { player.nextStation() }) {
                        Image(systemName: "forward.fill")
                            .font(.title)
                    }
                }
                .padding()

                VolumeSlider(volume: Binding(
                    get: { player.volume },
                    set: { player.setVolume($0) }
                ))

                Divider().padding(.vertical, 8)

                List(player.stations.indices, id: \.self) { index in
                    let station = player.stations[index]
                    let isSelected = index == player.currentIndex

                    HStack {
                        Image(systemName: station.artworkName)
                            .frame(width: 40, height: 40)
                            .background(isSelected ? Color.orange.opacity(0.2) : Color.orange.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 8))

                        VStack(alignment: .leading) {
                            Text(station.stationName)
                                .font(.headline)
                                .foregroundStyle(isSelected ? .orange : .primary)
                            Text("\(station.frequency) • \(station.genre)")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }

                        Spacer()

                        if isSelected {
                            Image(systemName: player.isPlaying ? "dot.radiowaves.left.and.right" : "radio")
                                .font(.caption)
                                .foregroundStyle(.orange)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        player.selectStation(at: index)
                    }
                }
            }
            .navigationTitle("Radio")
        }
    }
}
