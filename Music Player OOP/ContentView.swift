import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MusicAppViewModel()

    var body: some View {
        TabView(selection: $viewModel.currentTab) {
            MusicTabView(player: viewModel.musicPlayer, viewModel: viewModel)
                .tabItem {
                    Label("Music", systemImage: "music.note")
                }
                .tag(0)

            PodcastTabView(player: viewModel.podcastPlayer, viewModel: viewModel)
                .tabItem {
                    Label("Podcast", systemImage: "mic.circle")
                }
                .tag(1)

            RadioTabView(player: viewModel.radioPlayer, viewModel: viewModel)
                .tabItem {
                    Label("Radio", systemImage: "radio")
                }
                .tag(2)
        }
        .overlay(alignment: .bottom) {
            if viewModel.isAnythingPlaying {
                MiniPlayerBar(viewModel: viewModel)
                    .padding(.bottom, 50)
            }
        }
    }
}

#Preview {
    ContentView()
}
