//
//  inscription.swift
//  Titch
//
//  Created by Charlie Lim on 19/07/16.
//  Copyright © 2016 etna. All rights reserved.
//


import UIKit
import Material

class InscriptionController: UIViewController {
 
    @IBAction func InscriptionOk(sender: UIButton) {
          performSegueWithIdentifier("InscOkay", sender: self)
    }
    
    @IBOutlet weak var InputEmail: TextField!
    @IBOutlet weak var InputMdp1: TextField!
    @IBOutlet weak var Mdp2: TextField!
    @IBOutlet weak var Retour: RaisedButton!
    @IBOutlet weak var bttInscrip: RaisedButton!
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
