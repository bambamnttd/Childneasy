//
//  Login_ViewController.swift
//  Childneasy
//
//  Created by MacBookPro on 14/11/18.
//  Copyright © 2018 MacBookPro. All rights reserved.
//

import UIKit
import FMDB
import AVFoundation
import UserNotifications

class Login_ViewController: UIViewController {
    let content = UNMutableNotificationContent()  //
    
    var player:AVAudioPlayer?
    var name1:String=""
    var mDatabase: FMDatabase!
    var mDataArray: [String:String] = [:]
    var dummyArray: [String] = []
    
    @IBOutlet weak var textUsername: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in
        })
        
        openDB()
        configtext()
    }
    
    func alert(titlemsg:String, msg:String){
        let alert = UIAlertController(title: titlemsg, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func openDB(){     //SQlite database
        let databaseName = "childneasyDB1.db"
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
    
    @IBAction func registerbtn(_ sender: Any) {
        let path = Bundle.main.path(forResource: "buttonsound", ofType : "mp3")!
        let url = URL(fileURLWithPath : path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("error")
        }
    }
    
    @IBAction func queryDB(){
        content.title = "มาทบทวนภาษาจีนกัน"
        content.body = "คำศัพท์น่าอ่านรอเด็กๆอยู่"
        content.badge = 0
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        let path = Bundle.main.path(forResource: "buttonsound", ofType : "mp3")!
        let url = URL(fileURLWithPath : path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("error")
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "goMenu" {
            let command = "SELECT name, username, password FROM member where username='\(textUsername.text!)' and password='\(textPassword.text!)'"
            print(command)
            if let rs = self.mDatabase.executeQuery(command, withArgumentsIn: []){
                if rs.next(){
                    let data_name = rs.string(forColumn: "name")
                    let data_rowID = rs.string(forColumn: "username")
                    let data_field_data = rs.string(forColumn: "password")
                    name1=data_name!
                    print(name1)
//                    alert(titlemsg: data_rowID!, msg: data_field_data!)
                    return true
                }   // if rs.next
                else if textUsername.text?.isEmpty == true || textPassword.text?.isEmpty == true {
                    alert(titlemsg: "กรุณาใส่ชื่อผู้ใช้และรหัสผ่านให้ครบถ้วน!", msg: textUsername.text!)
                    return false
                }
                else{
                    //print("Hello No Recordset!")
                    alert(titlemsg: "ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง!", msg: textUsername.text!)
                    return false
                }
            }  // if let
            else {
                print("Database not found : \(self.mDatabase.lastErrorMessage())")
                return false
            }
        }
        else if identifier == "goReg" {
            return true
        }
        else {
            return false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func configtext() {
        textUsername.delegate=self
        textPassword.delegate=self
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "goMenu" {
            let vc1 = segue.destination as! Menu_ViewController
            vc1.name2 = name1
        }
    }
}

extension Login_ViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
