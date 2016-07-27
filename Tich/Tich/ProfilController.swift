//
//  ProfilController.swift
//  Titch
//
//  Created by Charlie Lim on 27/07/16.
//  Copyright © 2016 etna. All rights reserved.
//

import UIKit
import Material

class ProfilController: UIViewController {
    
    @IBOutlet weak var PhotoBtt: FlatButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        prepareStyle()
    }
    
    private func prepareStyle() {
        let icon: UIImage? = MaterialIcon.cm.photoCamera
        PhotoBtt.setImage(icon, forState: .Normal)
        PhotoBtt.setImage(icon, forState: .Highlighted)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}