import UIKit
import AVFoundation

class ViewController: UIViewController {

    let audioEngine = AVAudioEngine()
    let audioPlayerNode = AVAudioPlayerNode()
    var lowPassFilter: AVAudioUnitEQ!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Load your audio file
        guard let audioFileURL = Bundle.main.url(forResource: "your_audio_file", withExtension: "mp3") else {
            fatalError("Audio file not found")
        }
        let audioFile = try! AVAudioFile(forReading: audioFileURL)

        // Attach player node to the audio engine
        audioEngine.attach(audioPlayerNode)

        // Connect player node to the audio engine's main mixer node
        audioEngine.connect(audioPlayerNode, to: audioEngine.mainMixerNode, format: nil)

        // Initialize the low-pass filter
        lowPassFilter = AVAudioUnitEQ(numberOfBands: 1)
        lowPassFilter.bands[0].filterType = .lowPass
        lowPassFilter.bands[0].frequency = 1000 // Set the cutoff frequency to 1000 Hz
        lowPassFilter.bands[0].bypass = false
        audioEngine.attach(lowPassFilter)

        // Connect player node to the low-pass filter
        audioEngine.connect(audioPlayerNode, to: lowPassFilter, format: nil)

        // Connect the low-pass filter to the main mixer node
        audioEngine.connect(lowPassFilter, to: audioEngine.mainMixerNode, format: nil)

        // Start the audio engine
        do {
            try audioEngine.start()
        } catch {
            print("Error starting audio engine: \(error.localizedDescription)")
        }

        // Start playing the audio file
        audioPlayerNode.scheduleFile(audioFile, at: nil, completionHandler: nil)
        audioPlayerNode.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
