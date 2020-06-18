//
//  ViewController.swift
//  EggTimer
//
//  Created by Vahe Aslanyan on 04/17/2020.
//  Copyright © 2020 Vahe Aslanyan. All rights reserved.
//

import UIKit
import AVFoundation

var player: AVAudioPlayer?

func playSound() {
    guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

    do {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try AVAudioSession.sharedInstance().setActive(true)

        player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

        guard let player = player else { return }

        player.play()

    } catch let error {
        print(error.localizedDescription)
    }
}


class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    let eggTimes = ["Soft": 5, "Medium": 7, "Hard": 12]

    var timer = Timer()
    var totalTime: Float = 0
    var secondsPassed: Float = 0

    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        let hardness = sender.currentTitle!
        
        //resets the timer everytime a button is pressed
        timer.invalidate()
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        totalTime = Float(eggTimes[hardness]!) //* 60

        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    //@objc is a Objective-C function
   @objc func updateCounter() {
    if secondsPassed < totalTime {
           secondsPassed += 1
            progressBar.progress = secondsPassed / totalTime
       } else {
        timer.invalidate()
        titleLabel.text = "Done!"
        playSound()
        
    }
   }
    
}
