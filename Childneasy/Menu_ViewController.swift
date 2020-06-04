//
//  Menu_ViewController.swift
//  Childneasy
//
//  Created by MacBookPro on 15/11/18.
//  Copyright © 2018 MacBookPro. All rights reserved.
//

import UIKit
import AVFoundation

class Menu_ViewController: UIViewController,UIScrollViewDelegate {
    var player:AVAudioPlayer?
    var name2:String=""
    var effect:UIVisualEffect!
    var imageTip:Array = ["1","2","3"]
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    var click:Int=1
    
    @IBOutlet weak var showName: UILabel!
    
    var menu1ButtonCenter:CGPoint!
    var menu2ButtonCenter:CGPoint!
    var menu3ButtonCenter:CGPoint!
    var menu4ButtonCenter:CGPoint!
    
    @IBOutlet weak var more: UIButton!
    @IBOutlet weak var menu1: UIButton!
    @IBOutlet weak var menu2: UIButton!
    @IBOutlet weak var menu3: UIButton!
    @IBOutlet weak var menu4: UIButton!
    
    @IBOutlet weak var blurEffect: UIVisualEffectView!
    
    @IBAction func moreButton(_ sender: UIButton) {
        let path = Bundle.main.path(forResource: "clicksound", ofType : "mp3")!
        let url = URL(fileURLWithPath : path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("error")
        }
        
        if click%2 != 0 {
            UIView.animate(withDuration: 0.5, animations: {
                self.blurEffect.isHidden=false
                self.blurEffect.effect=self.effect
                
                self.menu1.alpha = 1
                self.menu2.alpha = 1
                self.menu3.alpha = 1
                self.menu4.alpha = 1
                
                self.menu1.frame.size=CGSize(width: 120, height: 120)
                self.menu2.frame.size=CGSize(width: 120, height: 120)
                self.menu3.frame.size=CGSize(width: 120, height: 120)
                self.menu4.frame.size=CGSize(width: 120, height: 120)
                
                self.menu1.center = self.menu1ButtonCenter
                self.menu2.center = self.menu2ButtonCenter
                self.menu3.center = self.menu3ButtonCenter
                self.menu4.center = self.menu4ButtonCenter
            })
            click+=1
        }
        else {
            UIView.animate(withDuration: 0.5, animations: {
                self.blurEffect.effect=nil
                
                self.menu1.alpha = 0
                self.menu2.alpha = 0
                self.menu3.alpha = 0
                self.menu4.alpha = 0
                
                self.menu1.frame.size=CGSize(width: 30, height: 30)
                self.menu2.frame.size=CGSize(width: 30, height: 30)
                self.menu3.frame.size=CGSize(width: 30, height: 30)
                self.menu4.frame.size=CGSize(width: 30, height: 30)
                
                self.menu1.center=self.more.center
                self.menu2.center=self.more.center
                self.menu3.center=self.more.center
                self.menu4.center=self.more.center
            })
            self.perform(#selector(hideBlur), with: nil, afterDelay: 0.5)
            click+=1
        }
    }
    
    @IBAction func grammaButton(_ sender: Any) {
        let path = Bundle.main.path(forResource: "buttonsound", ofType : "mp3")!
        let url = URL(fileURLWithPath : path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("error")
        }
    }
    
    
    @IBAction func pinyinButton(_ sender: UIButton) {
        let path = Bundle.main.path(forResource: "buttonsound", ofType : "mp3")!
        let url = URL(fileURLWithPath : path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("error")
        }
    }
    
    @IBAction func vocabButton(_ sender: UIButton) {
        let path = Bundle.main.path(forResource: "buttonsound", ofType : "mp3")!
        let url = URL(fileURLWithPath : path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("error")
        }
    }
    
    
    @IBAction func logoutButton(_ sender: UIButton) {
        let path = Bundle.main.path(forResource: "buttonsound", ofType : "mp3")!
        let url = URL(fileURLWithPath : path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("error")
        }
    }
    
    @objc func hideBlur() {
        self.blurEffect.isHidden=true
    }
    
    @objc func delayNihao() {
        let path = Bundle.main.path(forResource: "Nihao", ofType : "m4a")!
        let url = URL(fileURLWithPath : path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("error")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.perform(#selector(delayNihao), with: nil, afterDelay: 1.5)
        
        effect = blurEffect.effect
        blurEffect.effect=nil
        self.blurEffect.isHidden=true
        
        self.menu1.alpha = 0
        self.menu2.alpha = 0
        self.menu3.alpha = 0
        self.menu4.alpha = 0
        
        menu1ButtonCenter = menu1.center
        menu2ButtonCenter = menu2.center
        menu3ButtonCenter = menu3.center
        menu4ButtonCenter = menu4.center
        
        menu1.center=more.center
        menu2.center=more.center
        menu3.center=more.center
        menu4.center=more.center
        
        showName.text=name2
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
