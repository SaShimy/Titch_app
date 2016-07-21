//
//  SignUpController.swift
//  Titch
//
//  Created by Antoine Gunzburger on 19/07/2016.
//  Copyright © 2016 etna. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import Toast_Swift

class SignUpController: UIViewController {
    @IBOutlet var loginInput: UITextField!
    @IBOutlet var emailInput: UITextField!
    @IBOutlet var passwordInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginInput.text = nil
        self.emailInput.text = nil
        self.passwordInput.text = nil
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionSignUp(sender: UIButton) {
        var login:String!;
        var email:String!;
        var pswd:String!;
        
        login = self.loginInput.text
        email = self.emailInput.text
        pswd = self.passwordInput.text
        
        if ( login != "" && email != "" && pswd != "") {
            let parameters = [
                "login" : self.loginInput.text!,
                "mail": self.emailInput.text!,
                "password": self.passwordInput.text!
            ]
            
            /*let PostSignUpRequest = Alamofire.request(.POST, "http://symfonyios.cloudapp.net/signup", parameters: parameters)
                .validate()
            
            PostSignUpRequest.responseJSON(PostSignUpRequest,
            )*/
            /*Alamofire.request(.POST, "http://symfonyios.cloudapp.net/signup", parameters: parameters)
                .validate()
                .responseJSON { response in
                    
                    print(response.request)  // original URL request
                    print(response.response) // URL response
                    print(response.data)     // server data
                    print(response.result)   // result of response serialization

                    if (response.result.value != nil) {
                        debugPrint(response.result.value)
                        let json = JSON(response.result.value!)
                        let login = json["login"].stringValue
                        print("Le login : \(login)")
                    }
                    else {
                        self.view.makeToast("L'utilisateur ou l'email est déjà utilisé.")
                    }
            }*/
        }
        else {
            self.view.makeToast("Veuillez remplir tous les champs.")
        }
    }
}

    
