//
//  fr1_VC.swift
//  Childneasy
//
//  Created by MacBookPro on 2/12/18.
//  Copyright © 2018 MacBookPro. All rights reserved.
//

import UIKit
import AVFoundation

class fr1_VC: UIViewController,UIScrollViewDelegate {
    var img=["fr1","fr2","fr3","fr4","fr5"]
    var snd=["fr1","fr2","fr3","fr4","fr5"]
    var snd1:String=""
    var player:AVAudioPlayer?
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
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
    
    @IBAction func playSound(_ sender: Any) {
        let path = Bundle.main.path(forResource: snd1, ofType : "m4a")!
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
        scrollView.delegate=self
        
        for index in 0..<img.count {
            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
            frame.size = scrollView.frame.size
            let imgView = UIImageView(frame: frame)
            imgView.image = UIImage.init(named: img[index])
            self.scrollView.addSubview(imgView)
        }
        scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * CGFloat(img.count)), height: scrollView.frame.size.height)
        
        if pageControl.currentPage==0 {
            snd1=snd[0]
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var page = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage=Int(page)
        
        if page < 10 {
            snd1=snd[Int(page)]
        }
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
