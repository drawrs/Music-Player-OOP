import SwiftUI

func volumeBinding<Player: VolumeControllable>(for player: Player) -> Binding<Double> {
    Binding(
        get: { player.volume },
        set: { player.setVolume($0) }
    )
}
