import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MusicAppViewModel()

    var body: some View {
        TabView(selection: $viewModel.currentTab) {
            MusicTabView(player: viewModel.musicPlayer)
                .tabItem {
                    Label("Music", systemImage: "music.note")
                }
                .tag(0)

            PodcastTabView(player: viewModel.podcastPlayer)
                .tabItem {
                    Label("Podcast", systemImage: "mic.circle")
                }
                .tag(1)
        }
    }
}
