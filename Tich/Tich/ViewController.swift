	//
//  ViewController.swift
//  Tich
//
//  Created by Antoine Gunzburger on 18/07/2016.
//  Copyright © 2016 etna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func Connexion(sender: UIButton) {
        performSegueWithIdentifier("nextview", sender: self)
    }
    
    @IBAction func Inscript(sender: AnyObject) {
        shouldPerformSegueWithIdentifier("inscription", sender: self)
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

