//
//  ViewController.swift
//  Childneasy
//
//  Created by MacBookPro on 14/11/18.
//  Copyright © 2018 MacBookPro. All rights reserved.
//

import UIKit
import FMDB
import AVFoundation

class Register_ViewController: UIViewController {
    var player:AVAudioPlayer?
    var mDatabase: FMDatabase!
    var mDataArray: [String:String] = [:]
    var dummyArray: [String] = []
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtUser: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var txtRepass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        openDB()
        //queryDB()
        configtext()
    }
    
    func alert(titlemsg:String, msg:String){
        let alert = UIAlertController(title: titlemsg, message: msg, preferredStyle: .alert)
        //        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true)
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
    
    @IBAction func backbtn(_ sender: Any) {
        let path = Bundle.main.path(forResource: "clicksound", ofType : "mp3")!
        let url = URL(fileURLWithPath : path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("error")
        }
    }
    
    @IBAction func insertDB(){
        let path = Bundle.main.path(forResource: "buttonsound", ofType : "mp3")!
        let url = URL(fileURLWithPath : path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("error")
        }
        
        if txtName.text?.isEmpty == false && txtPass.text?.isEmpty == false && txtUser.text?.isEmpty == false {
            if txtPass.text == txtRepass.text {
                let cmd = "insert into Member (name, username, password) values ('\(txtName.text!)','\(txtUser.text!)','\(txtPass.text!)')"
                if !self.mDatabase.executeUpdate(cmd, withArgumentsIn: []){
                    print("Error1!")
                }
                else{
                    alert(titlemsg: "ลงทะเบียนเรียบร้อยแล้ว!", msg: "")
                    txtName.text=""
                    txtUser.text=""
                    txtPass.text=""
                    txtRepass.text=""
                }
                
                self.queryDB()
            }
            else{
                alert(titlemsg: "รหัสยืนยันไม่ตรงกันนะ!!!", msg: "")
                self.txtRepass.becomeFirstResponder()
                
            }
        }
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
    
    override var prefersStatusBarHidden: Bool {
            return true
    }
    
    private func configtext() {
        txtName.delegate=self
        txtUser.delegate=self
        txtPass.delegate=self
        txtRepass.delegate=self
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension Register_ViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
