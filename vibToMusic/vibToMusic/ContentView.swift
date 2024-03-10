import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var searchText = ""
    @State private var songNames: [String] = []
    @State private var player: AVPlayer?
    @State private var lowPassFilter: AVAudioUnitEQ?

    let audioEngine = AVAudioEngine()

    var body: some View {
        VStack {
            TextField("Enter song name", text: $searchText, onCommit: searchForSongs)
                .padding()

            List(songNames, id: \.self) { songName in
                Button(action: {
                    playSong(songName) // Pass song name to playSong function
                }) {
                    Text(songName)
                }
            }
            .padding()
        }
        .onAppear {
            setupLowPassFilter()
        }
    }

    private func setupLowPassFilter() {
        let filter = AVAudioUnitEQ(numberOfBands: 1)
        filter.bands[0].filterType = .lowPass
        filter.bands[0].frequency = 1000 // Adjust cutoff frequency as needed

        lowPassFilter = filter // Assign to the @State variable

        guard let lowPassFilter = lowPassFilter else {
            return
        }

        audioEngine.attach(lowPassFilter)
        audioEngine.connect(lowPassFilter, to: audioEngine.outputNode, format: nil)

        do {
            try audioEngine.start()
        } catch {
            print("Error starting audio engine: \(error.localizedDescription)")
        }
    }

    private func searchForSongs() {
        let searchTerm = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://shazam.p.rapidapi.com/search?term=\(searchTerm)&locale=en-US&offset=0&limit=5"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        let headers = [
            "X-RapidAPI-Key": "eb23d7d04bmsh26ad78ef94040d0p1dc27ejsnf0a99727737e",
            "X-RapidAPI-Host": "shazam.p.rapidapi.com"
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Invalid HTTP response")
                return
            }

            if let responseData = data {
                if let decodedResponse = try? JSONDecoder().decode(SearchResponse.self, from: responseData) {
                    DispatchQueue.main.async {
                        self.songNames = decodedResponse.tracks.hits.map { $0.track.title }
                    }
                } else {
                    print("Failed to decode response")
                }
            }
        }.resume()
    }

    private func playSong(_ songName: String) {
        // Manually provide the URL to the audio file for the selected song
        guard let url = URL(string: "https://ia803005.us.archive.org/23/items/LuisFonsiDespacitoInstrumentalfeat.DaddyYankeeViaInstrumentalstv.com/Luis%20Fonsi%20-%20Despacito%20%28Instrumental%29%20%28feat.%20Daddy%20Yankee%29%20via%20instrumentalstv.com.mp3") else {
            print("Invalid audio URL")
            return
        }

        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        player?.play()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SearchResponse: Decodable {
    let tracks: Tracks
}

struct Tracks: Decodable {
    let hits: [Hit]
}

struct Hit: Decodable {
    let track: Track
}

struct Track: Decodable {
    let title: String
}
