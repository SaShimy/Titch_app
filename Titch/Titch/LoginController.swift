//
//  LoginController.swift
//  Titch
//
//  Created by Antoine Gunzburger on 19/07/2016.
//  Copyright © 2016 etna. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import Toast_Swift

var token : String = String()

class LoginController: UIViewController {
    @IBOutlet weak var loginText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBAction func loginButton(sender: AnyObject) {
        /*let parameters = [
         "grant_type": "password",
         "client_id": "1_3bcbxd9e24g0gk4swg0kwgcwg4o8k8g4g888kwc44gcc0gwwk4",
         "client_secret": "4ok2x70rlfokc8g0wws8c8kwcokw80k44sg48goc0ok4w0so0k",
         "username": loginText.text!,
         "password": passwordText.text!
         ]*/
        
        
        /*Alamofire.request(.POST, "http://symfonyios.cloudapp.net/oauth/v2/token", parameters: parameters)
         .validate()
         .responseJSON { response in
         if (response.result.value != nil) {
         debugPrint(response.result.value)
         let json = JSON(response.result.value!)
         token = json["access_token"].stringValue
         print("Le token : \(token)")
         self.performSegueWithIdentifier("OnConnect", sender: self)
         }
         else {
         self.view.makeToast("Le mot de passe ou l'utilisateur ne sont pas corrects.")
         }
         }*/
        let Connect = Functions().Connect(loginText.text!, password: passwordText.text!)
        print("Connect : \(Connect)")
        print("2 \(ConnectionState)")
        if Connect == "ok" {self.performSegueWithIdentifier("OnConnect", sender: self)}
        else {self.view.makeToast("Le mot de passe ou l'utilisateur ne sont pas corrects.")}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func toastThis(String: msg) {
//        self.view.makeToast(msg)
//    }
    
    
}