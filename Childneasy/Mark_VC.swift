//
//  Mark_VC.swift
//  Childneasy
//
//  Created by MacBookPro on 1/12/18.
//  Copyright © 2018 MacBookPro. All rights reserved.
//

import UIKit
import AVFoundation

class Mark_VC: UIViewController {
    var sound:String=""
    var player:AVAudioPlayer?
    
    @IBOutlet weak var a: UILabel!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet var popUp1: UIView!
    
    @IBAction func closePopup1(_ sender: Any) {
        let path = Bundle.main.path(forResource: "clicksound", ofType : "mp3")!
        let url = URL(fileURLWithPath : path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("error")
        }
        animateOut()
    }
    
    @IBAction func close(_ sender: Any) {
        let path = Bundle.main.path(forResource: "clicksound", ofType : "mp3")!
        let url = URL(fileURLWithPath : path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("error")
        }
    }
    
    
    @IBAction func playA1(_ sender: Any) {
        let path = Bundle.main.path(forResource: sound, ofType : "m4a")!
        let url = URL(fileURLWithPath : path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("error")
        }
    }
    
    @IBAction func a1Button(_ sender: Any) {
        sound="A11"
        let path = Bundle.main.path(forResource: sound, ofType : "m4a")!
        let url = URL(fileURLWithPath : path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("error")
        }
        
        a.text = "ā"
        detail.text = "    วรรณยุกต์เสียงที่ 1 เทียบเท่ากับเสียงสามัญ ของภาษาไทย แต่จะอ่าน ออกเสียงลากยาว"
        animateIn()
    }
    @IBAction func a2Button(_ sender: Any) {
        sound="A22"
        let path = Bundle.main.path(forResource: sound, ofType : "m4a")!
        let url = URL(fileURLWithPath : path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("error")
        }
        
        a.text = "á"
        detail.text = "    วรรณยุกต์เสียงที่ 2 จะออกเสียงเหมือน “ ๋ ” ในวรรณยุกต์ไทย"
        animateIn()
    }
    @IBAction func a3Button(_ sender: Any) {
        sound="A33"
        let path = Bundle.main.path(forResource: sound, ofType : "m4a")!
        let url = URL(fileURLWithPath : path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("error")
        }
        
        a.text = "ǎ"
        detail.text = "    วรรณยุกต์เสียงที่ 3 จะออกเสียงเหมือน “ ่ ” ในวรรณยุกต์ไทย"
        animateIn()
    }
    @IBAction func a4Button(_ sender: Any) {
        sound="A44"
        let path = Bundle.main.path(forResource: sound, ofType : "m4a")!
        let url = URL(fileURLWithPath : path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("error")
        }
        
        a.text = "à"
        detail.text = "    วรรณยุกต์เสียงที่ 4 จะออกเสียงเหมือน “ ้” ในวรรณยุกต์ไทย"
        animateIn()
    }
    @IBAction func aButton(_ sender: Any) {
        sound="AA"
        let path = Bundle.main.path(forResource: sound, ofType : "m4a")!
        let url = URL(fileURLWithPath : path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("error")
        }
        
        a.text = "a"
        detail.text = "   คือตัวอ่านพินอินที่ไม่ มีวรรณยุกต์ จะอ่านออก เสียงให้สั้นและเบาลง"
        animateIn()
    }
    
    func animateIn() {
        self.view.addSubview(popUp1)
        popUp1.center = self.view.center
        popUp1.transform=CGAffineTransform.init(scaleX: 1.3, y:1.3)
        popUp1.alpha=0
        
        UIView.animate(withDuration: 0.4) {
            self.popUp1.alpha=1
            self.popUp1.transform=CGAffineTransform.identity
        }
    }
    
    func animateOut() {
        UIView.animate(withDuration: 0.3, animations: {
            self.popUp1.transform=CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.popUp1.alpha=0
        }) { (success:Bool) in
            self.popUp1.removeFromSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
