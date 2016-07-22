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
import Material

class SignUpController: UIViewController {
    @IBAction func InscriptionOk(sender: UIButton) {
        var email:String!;
        var pswd:String!;
        var pswd2:String!;
        
        email = self.InputEmail.text
        pswd = self.InputMdp1.text
        pswd2 = self.Mdp2.text
        
        if (pswd == pswd2) {
        
        if ( email != "" && pswd != "") {
            let parameters = [
                "mail": self.InputEmail.text!,
                "password": self.InputMdp1.text!
            ]
            
            Alamofire.request(.POST, "http://symfonyios.cloudapp.net/signup", parameters: parameters)
                .validate()
                .responseJSON { response in
                    if (response.result.value != nil) {
                        debugPrint(response.result.value)
                        self.global.setObject(self.InputEmail.text!, forKey:"SignedUpEmail")
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
        else {
            self.view.makeToast("Les mots de passes doivent être identiques.")
        }

    }
    
    @IBOutlet weak var Retour: RaisedButton!
    @IBOutlet weak var InputEmail: TextField!
    @IBOutlet weak var InputMdp1: TextField!
    @IBOutlet weak var Mdp2: TextField!
    @IBOutlet weak var bttInscrip: RaisedButton!
    let global:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    // @IBOutlet weak var back7: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        prepareStyle()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    private func prepareStyle() {
        // style input email
        InputEmail.placeholder = "Email"
        InputEmail.placeholderColor = MaterialColor.white
        InputEmail.placeholderActiveColor = MaterialColor.green.base
        
        // style input mdp
        InputMdp1.placeholder = "Mot de Passe"
        InputMdp1.placeholderColor = MaterialColor.white
        InputMdp1.placeholderActiveColor = MaterialColor.green.base
        
        // style input2
        
        Mdp2.placeholder = "Confirme votre mot de passe"
        Mdp2.placeholderColor = MaterialColor.white
        Mdp2.placeholderActiveColor = MaterialColor.green.base
        
        // style btt inscription
        
        bttInscrip.setTitle("Valider", forState: .Normal)
        bttInscrip.setTitleColor(MaterialColor.blue.base, forState: .Normal)
        bttInscrip.pulseColor = MaterialColor.blue.base
        
        
        let img: UIImage? = MaterialIcon.cm.arrowBack
        Retour.setImage(img, forState: .Normal)
        Retour.setImage(img, forState: .Highlighted)
        
    }

}

    
