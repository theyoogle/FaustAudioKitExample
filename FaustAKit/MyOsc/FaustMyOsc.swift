// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/
import AVFoundation
import CAudioKit
import AudioKit

/// Faust node
public class FaustMyOsc: Node, AudioUnitContainer, Toggleable {

	/// Unique four-letter identifier. If using multiple Faust generated nodes, make this unique for each
	public static let ComponentDescription = AudioComponentDescription(instrument: "Fdsp")

	/// Internal type of audio unit for this node
	public typealias AudioUnitType = InternalAU

	public private(set) var internalAU: AudioUnitType?

	// MARK: - Parameters

	// freq
	public static var letfreqDef = NodeParameterDef(identifier: "freq", name: "freq", address: akGetParameterAddress("MyOsc_freq"), range: 20 ... 20000, unit: .customUnit, flags: .default)

	@Parameter public var freq: AUValue

	// gain
	public static var letgainDef = NodeParameterDef(identifier: "gain", name: "gain", address: akGetParameterAddress("MyOsc_gain"), range: 0 ... 1, unit: .customUnit, flags: .default)

	@Parameter public var gain: AUValue

	// MARK: - Audio Unit
	public class InternalAU: AudioUnitBase {
		/// Get an array of the parameter definitions
		/// - Returns: Array of parameter definitions
		public override func getParameterDefs() -> [NodeParameterDef] {
			[FaustMyOsc.letfreqDef,
			FaustMyOsc.letgainDef]
		}
		/// Create the DSP Refence for this node
		/// - Returns: DSP Reference
		public override func createDSP() -> DSPRef { akCreateDSP("FaustMyOsc") }
	}

	// MARK: - Initialization
	public init(_ input: Node? = nil, freq: AUValue = 440, gain: AUValue = 1) {
		super.init(avAudioNode: input?.avAudioUnitOrNode ?? AVAudioNode())
		instantiateAudioUnit { avAudioUnit in
			self.avAudioUnit = avAudioUnit
			self.avAudioNode = avAudioUnit
			guard let audioUnit = avAudioUnit.auAudioUnit as? AudioUnitType else { fatalError("Couldn't create audio unit") }
			self.internalAU = audioUnit
			self.stop()
			self.freq = freq
			self.gain = gain
		}
	}
}

