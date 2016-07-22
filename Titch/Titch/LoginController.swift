//
//  ViewController.swift
//  Titch
//
//  Created by Antoine Gunzburger on 22/07/2016.
//  Copyright © 2016 etna. All rights reserved.
//

import UIKit
import Material
import Alamofire
import SwiftyJSON
import Toast_Swift

var token : String = String()

class LoginController: UIViewController {

    @IBOutlet weak var Identifiant: TextField!
    @IBOutlet weak var MotDePasse: TextField!
    @IBOutlet weak var BttConnexion: FlatButton!
    @IBOutlet weak var BttInscription: RaisedButton!
    
    @IBAction func Connexion(sender: UIButton) {
        let parameters = [
            "grant_type": "password",
            "client_id": "1_3bcbxd9e24g0gk4swg0kwgcwg4o8k8g4g888kwc44gcc0gwwk4",
            "client_secret": "4ok2x70rlfokc8g0wws8c8kwcokw80k44sg48goc0ok4w0so0k",
            "username": Identifiant.text!,
            "password": MotDePasse.text!
        ]
        
        
        Alamofire.request(.POST, "http://symfonyios.cloudapp.net/oauth/v2/token", parameters: parameters)
            .validate()
            .responseJSON { response in
                if (response.result.value != nil) {
                    let json = JSON(response.result.value!)
                    token = json["access_token"].stringValue
                    print(token)
                    self.performSegueWithIdentifier("OnConnect", sender: self)
                }
                else {
                    self.view.makeToast("Le mot de passe ou l'utilisateur ne sont pas corrects.")
                }
        }

    }
    
    @IBAction func Inscript(sender: AnyObject) {
        self.performSegueWithIdentifier("OnSignUp", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        prepareStyle()
    }
    
    
    
    private func prepareStyle() {
        // style input connexion
        Identifiant.placeholder = "Identifiant"
        Identifiant.placeholderColor = MaterialColor.white
        Identifiant.placeholderActiveColor = MaterialColor.green.base
        
        //style du button connexion
        BttConnexion.setTitle("Connexion", forState: .Normal)
        BttConnexion.setTitleColor(MaterialColor.blue.base, forState: .Normal)
        BttConnexion.pulseColor = MaterialColor.blue.base
        
        //style button inscription
        BttInscription.setTitle("Inscription", forState: .Normal)
        BttInscription.setTitleColor(MaterialColor.blue.base, forState: .Normal)
        BttInscription.pulseColor = MaterialColor.blue.base
        
        //style input mdp
        MotDePasse.placeholder = "Mot de passe"
        MotDePasse.placeholderColor = MaterialColor.white
        MotDePasse.placeholderActiveColor = MaterialColor.green.base
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

