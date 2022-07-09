import AVFoundation
import DependencyInjection
import Foundation

protocol BeeperContract: Injectable {
    func playLong()
    func playBeep()
    func playIntervals()
    func setInterval(_ spacing: Double)
    func stopIntervals()
}

final class Beeper: BeeperContract {
    private var audioPlayer: AVAudioPlayer?
    private var bundle: Bundle { Bundle(for: type(of: self)) }
    private var timer: Timer?
    private var waitDuration: TimeInterval = 0
    private let waitQueue = DispatchQueue(label: "intervals-queue", qos: .userInteractive)

    func playLong() {
        preparePlayer("start_beep")
        audioPlayer?.rate = 0.5
        audioPlayer?.play()
    }

    func playBeep() {
        preparePlayer("start_beep")
        audioPlayer?.rate = 1
        audioPlayer?.play()
    }

    func playIntervals() {
        stopIntervals()
        preparePlayer("foot_beep", .mixWithOthers)
        audioPlayer?.rate = 1
        audioPlayer?.play()
        intervalsLoop()
    }

    func setInterval(_ spacing: Double) {
        let duration = getAssetDuration("foot_beep")
        waitDuration = max(0, spacing - duration)
    }

    func stopIntervals() {
        timer?.invalidate()
        timer = nil
        audioPlayer?.stop()
        audioPlayer = nil
    }

    private func intervalsLoop() {
        waitQueue.async { [weak self] in
            guard let self = self, self.audioPlayer != nil else { return }
            Thread.sleep(forTimeInterval: self.waitDuration)
            self.audioPlayer?.play()
            self.intervalsLoop()
        }
    }

    private func getAssetDuration(_ resource: String) -> Double {
        guard let url = bundle.url(forResource: resource, withExtension: "mp3") else {
            return 0
        }
        let asset = AVURLAsset(url: url)
        return asset.duration.seconds
    }

    private func preparePlayer(_ resource: String, _ mode: AVAudioSession.CategoryOptions = .duckOthers) {
        guard let path = bundle.path(forResource: resource, ofType: "mp3") else {
            return
        }
        try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [mode])
        try? AVAudioSession.sharedInstance().setActive(true)
        audioPlayer = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
        audioPlayer?.enableRate = true
        audioPlayer?.prepareToPlay()
    }
}
