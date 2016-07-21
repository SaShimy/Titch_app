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
    @IBOutlet var emailInput: UITextField!
    @IBOutlet var passwordInput: UITextField!
    let global:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailInput.text = nil
        self.passwordInput.text = nil
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionSignUp(sender: UIButton) {
        var email:String!;
        var pswd:String!;
        
        email = self.emailInput.text
        pswd = self.passwordInput.text
    
        if ( email != "" && pswd != "") {
            let parameters = [
                "mail": self.emailInput.text!,
                "password": self.passwordInput.text!
            ]

            Alamofire.request(.POST, "http://symfonyios.cloudapp.net/signup", parameters: parameters)
                .validate()
                .responseJSON { response in
                    if (response.result.value != nil) {
                        debugPrint(response.result.value)
                        self.global.setObject(self.emailInput.text!, forKey:"SignedUpEmail")
                        self.performSegueWithIdentifier("OnSignedUp", sender: self)
                    }
                    else {
                        self.view.makeToast("L''email est déjà utilisé.")
                    }
            }
        }
        else {
            self.view.makeToast("Veuillez remplir tous les champs.")
        }
    }
}

    
