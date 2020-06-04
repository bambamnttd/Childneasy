//
//  Letter_ViewController.swift
//  Childneasy
//
//  Created by MacBookPro on 16/11/18.
//  Copyright © 2018 MacBookPro. All rights reserved.
//

import UIKit
import AVFoundation

class Letter_ViewController: UIViewController {
    var player:AVAudioPlayer?
    var click=1
    
    @IBOutlet weak var hl1: UIImageView!
    @IBOutlet weak var hl2: UIImageView!
    @IBOutlet weak var hl3: UIImageView!
    @IBOutlet weak var hl4: UIImageView!
    @IBOutlet weak var hl5: UIImageView!
    @IBOutlet weak var hl6: UIImageView!
    @IBOutlet weak var hl7: UIImageView!
    
    @IBAction func closeButton(_ sender: Any) {
        let path = Bundle.main.path(forResource: "clicksound", ofType : "mp3")!
        let url = URL(fileURLWithPath : path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("error")
        }
    }
    
    @IBAction func soundLetterButton(_ sender: Any) {
        let path = Bundle.main.path(forResource: "soundLetter", ofType : "m4a")!
        let url = URL(fileURLWithPath : path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("error")
        }
        letterPlay()
    }
    
    func letterPlay() {
        if click%2 != 0  {
            hl1.isHidden=false
            hl2.isHidden=false
            hl3.isHidden=false
            hl4.isHidden=false
            hl5.isHidden=false
            hl6.isHidden=false
            hl7.isHidden=false
            UIView.animate(withDuration: 0.5, animations: {
            self.hl1.alpha = 1
            })
            self.perform(#selector(hl2Delay), with: nil, afterDelay: 4)
            self.perform(#selector(hl3Delay), with: nil, afterDelay: 9)
            self.perform(#selector(hl4Delay), with: nil, afterDelay: 13)
            self.perform(#selector(hl5Delay), with: nil, afterDelay: 17)
            self.perform(#selector(hl6Delay), with: nil, afterDelay: 21)
            self.perform(#selector(hl7Delay), with: nil, afterDelay: 26)
            self.perform(#selector(hl7Hide), with: nil, afterDelay: 28)
        }
        else {
            player?.stop()
            hl1.isHidden=true
            hl2.isHidden=true
            hl3.isHidden=true
            hl4.isHidden=true
            hl5.isHidden=true
            hl6.isHidden=true
            hl7.isHidden=true
        }
        click+=1
    }
    
    @objc func hl2Delay() {
        UIView.animate(withDuration: 0.5, animations: {
            self.hl1.alpha = 0
            self.hl2.alpha = 1
        })
    }
    
    @objc func hl3Delay() {
        UIView.animate(withDuration: 0.5, animations: {
            self.hl2.alpha = 0
            self.hl3.alpha = 1
        })
    }
    
    @objc func hl4Delay() {
        UIView.animate(withDuration: 0.5, animations: {
            self.hl3.alpha = 0
            self.hl4.alpha = 1
        })
    }
    
    @objc func hl5Delay() {
        UIView.animate(withDuration: 0.5, animations: {
            self.hl4.alpha = 0
            self.hl5.alpha = 1
        })
    }
    
    @objc func hl6Delay() {
        UIView.animate(withDuration: 0.5, animations: {
            self.hl5.alpha = 0
            self.hl6.alpha = 1
        })
    }
    
    @objc func hl7Delay() {
        UIView.animate(withDuration: 0.5, animations: {
            self.hl6.alpha = 0
            self.hl7.alpha = 1
        })
    }
    
    @objc func hl7Hide() {
        UIView.animate(withDuration: 0.5, animations: {
            self.hl7.alpha = 0
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
