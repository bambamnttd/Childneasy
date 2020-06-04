//
//  quizColor_VC.swift
//  Childneasy
//
//  Created by MacBookPro on 3/12/18.
//  Copyright © 2018 MacBookPro. All rights reserved.
//

import UIKit
import AVFoundation

class quizColor_VC: UIViewController {
    var player:AVAudioPlayer?
    var countDown = Timer()
    var time = 3
    
    var sound:String!
    var questions : [Question]!
    var currentQuestion = 0
    var grade = 0
    var quizEnded = false
    
    var buttonArray=[UIButton]()
    
    
    @IBOutlet weak var done: UIButton!
    @IBOutlet weak var bglast: UIView!
    @IBOutlet weak var scoreLb: UILabel!
    @IBOutlet weak var lb: UILabel!
    
    @IBOutlet weak var textFeedback: UILabel!
    @IBOutlet weak var viewFedback: UIView!
    
    @IBOutlet weak var imgQ: UIImageView!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    @IBOutlet weak var answer4: UIButton!
    
    @IBOutlet weak var bg: UIView!
    @IBOutlet weak var lb321: UILabel!
    @IBOutlet weak var start: UIButton!
    
    @IBAction func donebtn(_ sender: Any) {
        let path = Bundle.main.path(forResource: "buttonsound", ofType : "mp3")!
        let url = URL(fileURLWithPath : path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("error")
        }
    }
    
    @IBAction func buttonStart(_ sender: Any) {
        let path = Bundle.main.path(forResource: "buttonsound", ofType : "mp3")!
        let url = URL(fileURLWithPath : path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("error")
        }
        
        lb321.isHidden=false
        start.isHidden=true
        countDown = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(action), userInfo: nil, repeats: true)
        self.perform(#selector(hidelb321), with: nil, afterDelay: 3)
        self.perform(#selector(delaySoundBG), with: nil, afterDelay: 2.5)
    }
    
    @objc func delaySoundBG() {
        let path = Bundle.main.path(forResource: "soundBG", ofType : "mp3")!
        let url = URL(fileURLWithPath : path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("error")
        }
    }
    
    @objc func hidelb321() {
        countDown.invalidate()
        lb321.isHidden=true
        bg.isHidden=true
    }
    
    @objc func action() {
        time-=1
        lb321.text=String(time)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lb321.isHidden=true
        
        loadQuestions()
        startQuiz()
        
        lb.isHidden=true
        scoreLb.isHidden=true
        done.isHidden=true
    }
    
    func loadQuestions() -> Void {
        let question1 = Question(
            question: "นี่คือสีอะไร?",
            soundQuestion: "",
            imgQuestion: "blueC.png",
            answers: [
                Answer(answer: "黄色 huángsè", isRight: false),
                Answer(answer: "蓝色 lánsè", isRight: true),
                Answer(answer: "红色 hóngsè", isRight: false),
                Answer(answer: "粉红色 fěnhóngsè", isRight: false)]
        )
        
        
        let question2 = Question(
            question: "นี่คือสีอะไร?",
            soundQuestion: "",
            imgQuestion: "pinkC.png",
            answers: [
                Answer(answer: "绿色 lǜsè", isRight: false),
                Answer(answer: "黄色 huángsè", isRight: false),
                Answer(answer: "粉红色 fěnhóngsè", isRight: true),
                Answer(answer: "蓝色 lánsè", isRight: false)]
        )
        
        let question3 = Question(
            question: "นี่คือสีอะไร?",
            soundQuestion: "",
            imgQuestion: "redC.png",
            answers: [
                Answer(answer: "绿色 lǜsè", isRight: false),
                Answer(answer: "蓝色 lánsè", isRight: false),
                Answer(answer: "黄色 huángsè", isRight: false),
                Answer(answer: "红色 hóngsè", isRight: true)]
        )
        
        let question4 = Question(
            question: "นี่คือสีอะไร?",
            soundQuestion: "",
            imgQuestion: "yellowC.png",
            answers: [
                Answer(answer: "粉红色 fěnhóngsè", isRight: false),
                Answer(answer: "红色 hóngsè", isRight: false),
                Answer(answer: "黄色 huángsè", isRight: true),
                Answer(answer: "蓝色 lánsè", isRight: false)
            ]
        )
        
        let question5 = Question(
            question: "นี่คือสีอะไร?",
            soundQuestion: "",
            imgQuestion: "greenC.png",
            answers: [
                Answer(answer: "蓝色 lánsè", isRight: false),
                Answer(answer: "绿色 lǜsè", isRight: true),
                Answer(answer: "黄色 huángsè", isRight: false),
                Answer(answer: "红色 hóngsè", isRight: false)
            ]
            
        )
        
        self.questions = [
            question1,
            question2,
            question3,
            question4,
            question5,
        ]
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func chooseAnswer1(_ sender: AnyObject) {
        selectAnswer(0)
    }
    
    @IBAction func chooseAnswer2(_ sender: AnyObject) {
        selectAnswer(1)
    }
    
    @IBAction func chooseAnswer3(_ sender: AnyObject) {
        selectAnswer(2)
    }
    
    @IBAction func chooseAnswer4(_ sender: AnyObject) {
        selectAnswer(3)
    }
    
    func startQuiz() -> Void {
        questions.shuffle()
        
        for i in 0 ..< questions.count {
            questions.shuffle()
        }
        grade = 0
        quizEnded = false
        currentQuestion = 0
        showQuestion(0)
    }
    
    func showQuestion(_ questionId : Int) -> Void {
        enableButtons()
        
        let selectedQuestion : Question = questions[questionId]
        imgQ.image=UIImage.init(named: selectedQuestion.imgQuestion!)
        question.text = selectedQuestion.question
        sound = selectedQuestion.soundQuestion
        
        answer1.setTitle(selectedQuestion.answers[0].response, for: UIControlState())
        answer2.setTitle(selectedQuestion.answers[1].response, for: UIControlState())
        answer3.setTitle(selectedQuestion.answers[2].response, for: UIControlState())
        answer4.setTitle(selectedQuestion.answers[3].response, for: UIControlState())
    }
    
    func disableButtons() -> Void {
        answer1.isEnabled = false
        answer2.isEnabled = false
        answer3.isEnabled = false
        answer4.isEnabled = false
        question.isHidden = true
    }
    
    func enableButtons() -> Void {
        answer1.isEnabled = true
        answer2.isEnabled = true
        answer3.isEnabled = true
        answer4.isEnabled = true
        question.isHidden = false
    }
    
    func selectAnswer(_ answerId : Int) -> Void {
        disableButtons()
        
        let answer : Answer = questions[currentQuestion].answers[answerId]
        
        if (true == answer.isRight) {
            grade += 1
            nextQuestion()
            if currentQuestion == 5 {
                self.perform(#selector(delayPlay), with: nil, afterDelay: 0.1)
            }
        } else {
            textFeedback.text = "ผิด!!"
            viewFedback.isHidden=false
            self.perform(#selector(hideFeedback), with: nil, afterDelay: 1.5)
            nextQuestion()
            if currentQuestion == 5 {
                self.perform(#selector(delayPlay), with: nil, afterDelay: 1.5)
            }
        }
    }
    
    @objc func hideFeedback() {
        viewFedback.isHidden=true
    }
    
    func nextQuestion() {
        currentQuestion += 1
        
        if (currentQuestion < questions.count) {
            showQuestion(currentQuestion)
        } else {
            endQuiz()
        }
    }
    
    func endQuiz() {
        grade=grade*20
        scoreLb.text=String(grade)
        self.bglast.backgroundColor=UIColor.init(red: 229/255, green: 225/255, blue: 224/255, alpha: 1)
        UIView.animate(withDuration: 2, animations: {
            self.done.isHidden=false
            self.lb.isHidden=false
            self.scoreLb.isHidden=false
            self.answer1.isHidden = true
            self.answer2.isHidden = true
            self.answer3.isHidden = true
            self.answer4.isHidden = true
            self.question.isHidden = true
            self.imgQ.isHidden = true
            self.quizEnded = true
        })
    }
    
    @objc func delayPlay() {
        let path1 = Bundle.main.path(forResource: "yeahsound", ofType : "mp3")!
        let url1 = URL(fileURLWithPath : path1)
        do {
            player = try AVAudioPlayer(contentsOf: url1)
            player?.play()
        } catch {
            print("error")
        }
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

