	//
//  ViewController.swift
//  Tich
//
//  Created by Antoine Gunzburger on 18/07/2016.
//  Copyright © 2016 etna. All rights reserved.
//

import UIKit
import Material

class ViewController: UIViewController {

    @IBOutlet weak var Identifiant: TextField!
    @IBOutlet weak var MotDePasse: TextField!
    @IBOutlet weak var BttConnexion: FlatButton!
    @IBOutlet weak var BttInscription: RaisedButton!
    
    
    
    @IBAction func Connexion(sender: UIButton) {
        performSegueWithIdentifier("nextview", sender: self)
    }
    
    @IBAction func Inscript(sender: AnyObject) {
        shouldPerformSegueWithIdentifier("inscription", sender: self)
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

