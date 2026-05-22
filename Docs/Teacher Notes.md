# Teacher Notes

Project ini sudah disederhanakan agar fokus learner tetap berada di OOP, bukan di kompleksitas UI atau variasi fitur yang terlalu banyak.

## Teaching Goal

Learner diharapkan mampu:
- mengenali state yang belum teren kapsulasi dengan baik
- membedakan duplication vs reusable abstraction
- memahami kapan inheritance membantu dan kapan protocol lebih fleksibel
- melihat dampak coupling antara UI, view model, dan domain object

## Masalah yang Sengaja Dipertahankan

1. Encapsulation lemah
- `volume`, `currentTime`, `currentIndex`, `playlist`, dan `episodes` masih bisa dimodifikasi langsung dari luar.
- `Song.duration` dan `Podcast.episodeNumber` belum punya validasi.
- `setVolume(_:)` juga belum memvalidasi range `0...1`.

2. Duplication antarkelas player
- `MusicPlayer` dan `PodcastPlayer` punya banyak state dan method yang mirip.
- Ini sengaja dipertahankan sebagai pintu masuk diskusi tentang base class, composition, atau protocol.

3. Abstraction belum jelas
- `formatTime(_:)` muncul di lebih dari satu player, padahal bukan behavior yang unik untuk satu player.
- Status description juga masih tersebar di concrete player.

4. Coupling view ke concrete type
- `MusicTabView` dan `PodcastTabView` langsung bergantung pada `MusicPlayer` dan `PodcastPlayer`.
- Learner bisa diarahkan untuk berpikir apakah ada protocol tampilan atau abstraction yang lebih netral.

## Masalah yang Sudah Disederhanakan

- `RadioPlayer` dihapus agar learner fokus pada dua class yang paling mudah dibandingkan.
- `MiniPlayerBar` dihapus agar tidak ada percabangan lintas-player yang terlalu besar di UI.
- Masalah reactivity SwiftUI dirapikan dengan `ObservableObject` dan `@ObservedObject`, supaya app lebih stabil saat dipakai eksplorasi.
- Bug tombol podcast mundur/maju dirapikan agar perhatian tidak pecah ke bug UI kecil.

## Arah Refactor yang Mungkin Muncul

Refactor level dasar:
- tambah validasi properti
- gunakan `private(set)`
- pindahkan mutasi penting ke method object

Refactor level menengah:
- buat protocol seperti `Playable` atau `VolumeControllable`
- ekstrak data presentasi untuk now playing
- pindahkan time formatting ke helper atau abstraction yang lebih tepat

Refactor level lanjut:
- buat base class player untuk behavior umum jika ingin menekankan inheritance
- bandingkan dengan solusi protocol-oriented agar learner memahami trade-off

## Catatan Fasilitasi

- Jika learner terlalu cepat memilih inheritance, dorong mereka membandingkan dengan protocol.
- Jika learner terlalu fokus ke UI duplication, arahkan kembali ke pertanyaan: "object mana yang seharusnya bertanggung jawab atas aturan ini?"
- Jika learner ingin rewrite total, minta mereka mulai dari satu problem prioritas terlebih dahulu.
