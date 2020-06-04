//
//  quizNumber_VC.swift
//  Childneasy
//
//  Created by MacBookPro on 1/12/18.
//  Copyright © 2018 MacBookPro. All rights reserved.
//

import UIKit
import AVFoundation
import FMDB

class quizNumber_VC: UIViewController {
    var mDatabase: FMDatabase!
    var mDataArray: [String:String] = [:]
    var dummyArray: [String] = []
    
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
    
    @IBOutlet weak var soundQ: UIButton!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    @IBOutlet weak var answer4: UIButton!
    
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
    
    @IBAction func playQuestion(_ sender: Any) {
        let path = Bundle.main.path(forResource: sound, ofType : "m4a")!
        let url = URL(fileURLWithPath : path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("error")
        }
    }

    @IBOutlet weak var bg: UIView!
    @IBOutlet weak var lb321: UILabel!
    @IBOutlet weak var start: UIButton!
    
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
        
        done.isHidden=true
        lb.isHidden=true
        scoreLb.isHidden=true
        
        openDB()
    }
    
    func openDB(){     //SQlite database
        let databaseName = "childneasyDB1.db"
        //        let databaseName = "Account.db"
        let documentsFolder = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let path = documentsFolder + "/\(databaseName))"
        print("\n\ndb path: \(path)\n\n")
        
        let fileManager = FileManager()
        
        if (!fileManager.fileExists(atPath: path)){
            let dbFilePath = Bundle.main.path(forResource: databaseName, ofType: nil)!
            print(dbFilePath)
            do { //ดักจับ error do...try...catch
                try fileManager.copyItem(atPath: dbFilePath, toPath: path)
            }catch{
                print(error)
            }
        }
        
        self.mDatabase = FMDatabase(path: path)
        self.mDatabase.open()
    }
    
    func queryDB(){
        //self.mDataArray.removeAll()
        let command = "SELECT name, username, password FROM Member ORDER BY username"
        print(command)
        if let rs = self.mDatabase.executeQuery(command, withArgumentsIn: []){
            
            while rs.next() {
                let data_field_data1 = rs.string(forColumn: "name")
                let data_rowID = rs.string(forColumn: "username")
                let data_field_data = rs.string(forColumn: "password")
                
                print(data_field_data1)
                print(data_rowID!)
                print(data_field_data!)
                
                let item: [String:String] = [
                    "name": data_field_data1!,
                    "username": data_rowID!,
                    "password": data_field_data!
                ]
                mDataArray=item
                
            }
        } else {
            print("select failed: \(self.mDatabase.lastErrorMessage())")
        }
    }
    
    func loadQuestions() -> Void {
        let question1 = Question(
            question: "เสียงที่ได้ยิน คือข้อใด?",
            soundQuestion: "sound2",
            imgQuestion: "",
            answers: [
                Answer(answer: "五 wǔ", isRight: false),
                Answer(answer: "二 èr", isRight: true),
                Answer(answer: "七 qī", isRight: false),
                Answer(answer: "一 yī", isRight: false)]
        )
        
        
        let question2 = Question(
            question: "เสียงที่ได้ยิน คือข้อใด?",
            soundQuestion: "sound4",
            imgQuestion: "",
            answers: [
                Answer(answer: "十 shí", isRight: false),
                Answer(answer: "三 sān", isRight: false),
                Answer(answer: "九 jiǔ", isRight: false),
                Answer(answer: "四 sì", isRight: true)]
        )
        
        let question3 = Question(
            question: "一,五 แปลว่าอะไร?",
            soundQuestion: "sound1_5",
            imgQuestion: "",
            answers: [
                Answer(answer: "1 5", isRight: true),
                Answer(answer: "4 6", isRight: false),
                Answer(answer: "2 7", isRight: false),
                Answer(answer: "9 8", isRight: false)]
        )
        
        let question4 = Question(
            question: "เสียงที่ได้ยิน ตรงกับข้อใด?",
            soundQuestion: "sound7_2",
            imgQuestion: "",
            answers: [
                Answer(answer: "wǔ jiǔ", isRight: false),
                Answer(answer: "sān sì", isRight: false),
                Answer(answer: "qī èr", isRight: true),
                Answer(answer: "bā shí", isRight: false)
            ]
            
        )
        
        let question5 = Question(
            question: "三,六,十 แปลว่าอะไร?",
            soundQuestion: "sound3_6_10",
            imgQuestion: "",
            answers: [
                Answer(answer: "1 3 5", isRight: false),
                Answer(answer: "7 8 9", isRight: false),
                Answer(answer: "2 4 6", isRight: false),
                Answer(answer: "3 6 10", isRight: true)
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
            self.soundQ.isHidden = true
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
