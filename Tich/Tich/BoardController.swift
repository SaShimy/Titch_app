//
//  BoardController.swift
//  Titch
//
//  Created by Charlie Lim on 22/07/16.
//  Copyright © 2016 etna. All rights reserved.
//

import UIKit
import Material

class BoardController: UIViewController {
 
    @IBAction func Test(sender: UIButton!) {
        shouldPerformSegueWithIdentifier("test", sender: self)
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