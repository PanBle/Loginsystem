//
//  RegisterViewController.swift
//  SignUp
//
//  Created by KM_TM on 2018. 9. 15..
//  Copyright © 2018년 KM_TM. All rights reserved.
//

import UIKit
import Alamofire
import Toast_Swift
import SwiftyJSON

class RegisterViewController: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var reIDField: UITextField!
    @IBOutlet weak var rePWField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var rePHField: UITextField!
    
    let url = "http://207.148.88.110:3000"
    let picker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        profile_circler()
        self.picker.delegate = self
        super.viewDidLoad()
    }
    
    func profile_circler() {
        self.profile.layer.cornerRadius = self.profile.frame.size.width / 2
        self.profile.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    @IBAction func chage_image(_ sender: Any) {
        let alert = UIAlertController(title: "앨범", message: "사진을 선택해 주세요", preferredStyle: .actionSheet)
        
        let library =  UIAlertAction(title: "사진앨범", style: .default) { (action) in self.openLibrary()}
        let camera =  UIAlertAction(title: "카메라", style: .default) { (action) in self.openCamera()}
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func registerButton(_ sender: Any) {
        //URL setting
        let regURL:URL = URL(string: url + "/register")!
        //HTTP header
        let header = ["Content-Type": "multipart/form-data","Accept":"multipart/form-data"]
        //data --> json
        guard reIDField.text != nil else {
            self.view.makeToast("Please write down ID")
            return
        }
        guard rePWField.text != nil else {
            self.view.makeToast("Please write down PW")
            return
        }
        guard nameField.text != nil else {
            self.view.makeToast("Please write down Name")
            return
        }
        guard rePHField.text != nil else {
            self.view.makeToast("Please write down Phone Number")
            return
        }
        guard emailField.text != nil else {
            self.view.makeToast("Please write down Email")
            return
        }
        let param = ["data":"\"id\":\(reIDField.text),\"pw\":\(rePWField.text),\"name\":\(nameField.text),\"phone\":\(rePHField.text),\"email\":\(emailField.text)"]
        
        let imageData = UIImageJPEGRepresentation(self.profile.image!, 1.0)
        Alamofire.upload(multipartFormData: {MultipartFormData in
            MultipartFormData.append(imageData!, withName: "file", fileName: "", mimeType: "image/jpeg")
            for(key,value) in param {
                MultipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
        }, usingThreshold: UInt64.init(), to: regURL, method: .post, headers: header) { result in
            switch result {
            case .success(let upload, _, _):
                upload.responseData(completionHandler: {response in
                    let json = JSON(response.result.value!)
                    if json["result"]["success"].bool! {
                        self.view.makeToast("Register success")
                        self.dismiss(animated: true, completion: nil)
                    }
                    else{
                        print("\(json["result"]["message"].string!)")
                        self.view.makeToast("\(json["result"]["message"].string!)")
                    }
                })
            case .failure(let error):
                print("\(error)")
                self.view.makeToast("Network is not working")
            }
        }
    }
    
    @IBAction func returnLoginButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            profile.image = image
            print(info)
        }
        dismiss(animated: true, completion: nil)
    }
    func openLibrary() {
        picker.sourceType = .photoLibrary
        
        self.present(picker, animated: false, completion: nil)
    }
    func openCamera() {
        picker.sourceType = .camera
        
        self.present(picker, animated: false, completion: nil)
    }

}
