
//  DevNetwork
//
//  Created by abuzeid on 08.12.20.
//  Copyright © 2020 abuzeid. All rights reserved.
//

import Accelerate
import AVFoundation
import Foundation.NSURL

public protocol SongPlusesGenerator {
    var url: URL { get }
    func generatePulses() -> [Float]
}

public extension SongPlusesGenerator {
    func generatePulses() -> [Float] {
        let pcmBufferPoints = generatePCMBufferPoints()
        let abs = self.abs(for: pcmBufferPoints)
        let desamp = self.desamp(for: abs)
        return desamp
    }

    private func abs(for points: [Float]) -> [Float] {
        let AStride = 1
        let CStride = 1
        let length = vDSP_Length(points.count)
        var output = [Float](repeating: 0.0, count: Int(length))

        vDSP_vabs(points,
                  AStride,
                  &output,
                  CStride,
                  length)
        return output
    }

    private func desamp(for points: [Float]) -> [Float] {
        let samplesPerPixel = 250
        let filter = [Float](repeating: 1.0 / Float(samplesPerPixel), count: Int(samplesPerPixel))
        let length = Int(points.count / samplesPerPixel)
        var output = [Float](repeating: 0.0, count: length)

        vDSP_desamp(points,
                    vDSP_Stride(samplesPerPixel),
                    filter,
                    &output,
                    vDSP_Length(length),
                    vDSP_Length(samplesPerPixel))
        return output
    }

    private func generatePCMBufferPoints() -> [Float] {
        let audioFile = generateAudioFile()
        let audioFormat = generateAudioFormat(with: audioFile)
        let audioPCMBuffer = generateAudioPCMBuffer(file: audioFile, format: audioFormat)

        do {
            try audioFile.read(into: audioPCMBuffer)
            let pulses = Array(UnsafeBufferPointer(start: audioPCMBuffer.floatChannelData?[0],
                                                   count: Int(audioPCMBuffer.frameLength)))
            return pulses
        } catch {
            fatalError("Couldn't read the file \(audioFile) into the audioPCMBuffer \(audioPCMBuffer)")
        }
    }

    private func generateAudioFile() -> AVAudioFile {
        let audioFile = try? AVAudioFile(forReading: url)
        if let audioFile = audioFile {
            return audioFile
        }
        fatalError("Couldn't get the audioFile for url: \(url)")
    }

    private func generateAudioFormat(with audioFile: AVAudioFile) -> AVAudioFormat {
        let audioFormat = AVAudioFormat(commonFormat: .pcmFormatFloat32,
                                        sampleRate: audioFile.fileFormat.sampleRate,
                                        channels: audioFile.fileFormat.channelCount,
                                        interleaved: false)

        if let audioFormat = audioFormat {
            return audioFormat
        }
        fatalError("Couldn't get the audioFormat for url: \(url)")
    }

    private func generateAudioPCMBuffer(file: AVAudioFile, format: AVAudioFormat) -> AVAudioPCMBuffer {
        let buffer = AVAudioPCMBuffer(pcmFormat: format,
                                      frameCapacity: UInt32(file.length))

        if let buffer = buffer {
            return buffer
        }
        fatalError("Couldn't get the audioPCMBuffer for url: \(url)")
    }
}
