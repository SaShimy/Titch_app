//
//  inscription.swift
//  Titch
//
//  Created by Charlie Lim on 19/07/16.
//  Copyright © 2016 etna. All rights reserved.
//


import UIKit

class InscriptionController: UIViewController {
 
    @IBAction func InscriptionOk(sender: UIButton) {
          performSegueWithIdentifier("InscOkay", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

