//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!

    var audioPlayer = AVAudioPlayer()
    var countdownTimer = Timer()
    var totalTime: Int = 0
    var elapsedTime: Int = 0
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        let eggTimes = ["Soft": 5, "Medium": 420, "Hard": 720]
        
        titleLabel.text = hardness
        countdownTimer.invalidate()
        elapsedTime = 0
        
        totalTime = eggTimes[hardness]!
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    

    @objc func updateTime() {
        if elapsedTime < totalTime {
            print("\(totalTime - elapsedTime) seconds")
            
            elapsedTime += 1
            progressView.progress = Float(elapsedTime) / Float(totalTime)
        } else {
            let alarm_sound = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            audioPlayer = try! AVAudioPlayer(contentsOf: alarm_sound!)
            audioPlayer.play()
            
            titleLabel.text = "Done!"
            countdownTimer.invalidate()
        }
    }
}


