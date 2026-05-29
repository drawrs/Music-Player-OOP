import SwiftUI

func volumeBinding(for player: BasePlayer) -> Binding<Double> {
    Binding(
        get: { player.volume },
        set: { player.setVolume($0) }
    )
}
