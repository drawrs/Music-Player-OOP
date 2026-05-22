import SwiftUI

// ✅ Ini juga sudah reusable
struct VolumeSlider: View {
    @Binding var volume: Double

    var body: some View {
        HStack {
            Image(systemName: "speaker.fill")
                .foregroundStyle(.secondary)
            Slider(value: $volume, in: 0...1)
            Image(systemName: "speaker.wave.3.fill")
                .foregroundStyle(.secondary)
        }
        .padding(.horizontal)
    }
}
