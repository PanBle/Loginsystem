//
//  RegisterViewController.swift
//  SignUp
//
//  Created by KM_TM on 2018. 9. 15..
//  Copyright © 2018년 KM_TM. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var reIDField: UITextField!
    @IBOutlet weak var rePWField: UITextField!
    @IBOutlet weak var rePWretField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var profile: UIImageView!
    
    let url = "http://207.148.88.110:3000"
    let picker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func registerButton(_ sender: Any) {
        //URL setting
        let regURL:URL = URL(string: url + "/ios_register")!
        //HTTP header
        let header = ["Content-Type": "multipart/form-data","Accept":"multipart/form-data"]
        //data --> json
        let param = ["data":["id":reIDField.text,"pw":rePWField.text,"name":,"phone":,"email":]]
        
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
