//
//  ViewController.swift
//  Egg Timer
//
//  Created by ALISHA JOSHI K on 31/03/21.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var lblDone: UILabel!
    @IBOutlet weak var thumbsUpIcon: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    
    var player: AVAudioPlayer?
    
    let softTime = 5
    let mediumTime = 7
    let hardTime = 12
    var timer = Timer()
    var requiredTime    = 0//for boiling eggs
    var secondsPassed   = 0
    var percentageProgress  = 0.00

    
    
    
    override func viewDidLoad() {
        
        self.progressView.progress = 0.0
        thumbsUpIcon.isHidden = true
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func eggAction(_ sender: UIButton) {
        timer.invalidate()
        thumbsUpIcon.isHidden = true
        print(sender.currentTitle ?? "")
        let eggTimes = ["Soft" : 5, "Medium" : 7, "Hard" : 12]
        let hardness = sender.currentTitle ?? ""
        
        //MARK: by using key value pair in dictionary
        //        for keys in eggTimes.keys{
        //            print("\(keys) is hardess")
        //            if keys == hardness {
        //                print("Hardness selected is : \(eggTimes[hardness] ?? 0) Minutes")
        //            }
        //
        //        }
        //MARK: simple method
        
        //        let result = eggTimes[hardness]
        //        print("Hardness is: \(result ?? 0)")
        
        
        
        //MARK: By using switch
        //        switch hardness {
        //        case "Soft":
        //            print("\(softTime) Minutes")
        //        case "Medium":
        //            print("\(mediumTime) Minutes")
        //        case "Hard":
        //            print("\(hardTime) Minutes")
        //        default:
        //            print("Error")
        //        }
        
        
        //MARK: OPtional Unwrappping - forced
        let hardnesType = sender.currentTitle!
        self.requiredTime = eggTimes[hardnesType]!
        
        print(eggTimes[hardnesType]) //this will result in optional value
        print(requiredTime) //unwrapp the value and print it out
        progressView.progress = 0.0 //set progress to 0 on the button click
        self.secondsPassed = 0
//        self.player?.stop()

        lblDone.text = hardnesType
       timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
        
    }
    
    //MARK: Count Down Timer
    
    
    @objc func updateCounter() {
        //example functionality
        if   secondsPassed < requiredTime{
            
            self.secondsPassed += 1
            self.percentageProgress = Double(Float(secondsPassed)/Float(requiredTime))
            self.progressView.setProgress(Float(percentageProgress),animated:true)

        }else  {

            timer.invalidate()
            lblDone.text = "DONE"
            thumbsUpIcon.isHidden = false
            self.setAlarmsound()
            lblDone.textColor = UIColor.systemGreen

        }
        
        
    }
    
    //MARK: Play Alarm
    
    func setAlarmsound() {
        
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
}
