//
//  ViewController.swift
//  SignUp
//
//  Created by KM_TM on 2018. 7. 23..
//  Copyright © 2018년 KM_TM. All rights reserved.
//

import UIKit
import Toast_Swift
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var pwField: UITextField!
    
    let url = "http://207.148.88.110:3000"
    var autologin = true
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.value(forKey: "IDauto") != nil {
            let loginURL:URL = URL(string: url + "/login")!
            //data --> json
            let param = [
                "id":UserDefaults.standard.value(forKey: "IDauto") as! String ,
                "pw":UserDefaults.standard.value(forKey: "PWauto") as! String
            ]
            //HTTP header
            let header = ["Content-Type":"application/json", "Accept":"application/json"]
            Alamofire.request(loginURL, method: .post, parameters: param, encoding: JSONEncoding.default, headers: header).responseJSON(completionHandler: {res in
                switch res.result {
                case .success(let value):
                    let temJSON = JSON(value)
                    print("\(temJSON)")
                    if temJSON["result"]["success"].bool! {
                        self.view.makeToast("Auto Login Success")
                        self.performSegue(withIdentifier: "LoginSegue", sender: nil)
                    }
                    else {
                        self.view.makeToast("Auto Login Failed")
                    }
                case .failure(let error):
                    print("\(error)")
                    self.view.makeToast("Network is not working")
                }
            })
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButton(_ sender: Any) {
        //url setting
        let loginURL:URL = URL(string: url+"/login")!
        //check id,pwfield
        guard idField.text != nil else{
            self.view.makeToast("Please write down ID")
            return
        }
        guard pwField.text != nil else {
            self.view.makeToast("Please write down PW")
            return
        }
        //data --> json
        let param = ["id":idField.text,"pw":pwField.text]
        //HTTP Header
        let header = ["Content-Type":"application/json", "Accept":"application/json"]
        //request
        Alamofire.request(loginURL, method: .post, parameters: param, encoding: JSONEncoding.default, headers: header).responseJSON(completionHandler: {res in
            switch res.result {
            case .success(let value):
                let temJSON = JSON(value)
                print("\(temJSON)")
                if temJSON["result"]["success"].bool!{
                    self.view.makeToast("Login success")
                    self.performSegue(withIdentifier: "LoginSegue", sender: self)
                    if self.autologin == true {
                        UserDefaults.standard.set(self.idField.text, forKey: "IDauto")
                        UserDefaults.standard.set(self.pwField.text, forKey: "PWauto")
                    }
                }
                else{
                    self.view.makeToast("Login Failed")
                }
            case .failure(let error):
                print("\(error)")
                self.view.makeToast("Network communication is Not working")
            }
        })
        
    }
    
    @IBAction func registerButton(_ sender: Any) {
        self.performSegue(withIdentifier: "RegisterSegue", sender: self)
    }
    
    @IBAction func autoLogin(_ sender: Any) {
        if autologin == true{
            self.autologin = false
        }else {
            self.autologin = true
        }
    }
    
}

