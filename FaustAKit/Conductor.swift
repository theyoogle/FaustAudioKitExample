//
//  Conductor.swift
//  FaustAKit
//
//  Created by The YooGle on 18/08/22.
//

import AudioKit

class Conductor {
    
    let engine = AudioEngine()
    let myOsc = FaustMyOsc()
    
    init() {
        myOsc.freq = 440
        myOsc.gain = 1.0
        myOsc.gate = 1.0
        
        engine.output = myOsc
        myOsc.start()
        
        startEngine()
    }
    
    func startEngine() {
        do {
            try engine.start()
        } catch let err {
            Log(err)
        }
    }
    
}
