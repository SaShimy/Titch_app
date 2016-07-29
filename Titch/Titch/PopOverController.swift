//
//  popOverController.swift
//  Titch
//
//  Created by Antoine Gunzburger on 28/07/2016.
//  Copyright © 2016 etna. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Material

class PopOverController: UIViewController {

 
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var fName: TextField!
    @IBOutlet weak var lName: TextField!
    @IBOutlet weak var age: TextField!
    @IBOutlet weak var Retour: FlatButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareStyle()
    }
    
    private func prepareStyle() {
        fName.placeholder = "Prenom"
        fName.placeholderColor = MaterialColor.white
        fName.placeholderActiveColor = MaterialColor.green.base
        
        lName.placeholder = "Nom"
        lName.placeholderColor = MaterialColor.white
        lName.placeholderActiveColor = MaterialColor.green.base
        
        age.placeholder = "Age"
        age.placeholderColor = MaterialColor.white
        age.placeholderActiveColor = MaterialColor.green.base
        
        let icon: UIImage? = MaterialIcon.cm.arrowBack
        Retour.setImage(icon, forState: .Normal)
        Retour.setImage(icon, forState: .Highlighted)
    }
    
    
    @IBAction func sendProfile(sender: AnyObject) {
        if (fName.text != "" && lName.text != "" && age.text != "") {
            let genderV: String = gender.titleForSegmentAtIndex(gender.selectedSegmentIndex)!
            let ageV = Int(age.text!)
            let headers = [
                "Authorization": "Bearer " + token
            ]
            let parameters : [String : AnyObject] = [
                "firstname": fName.text!,
                "lastname": lName.text!,
                "age": ageV!,
                "gender": genderV
            ]
            Alamofire.request(.PUT, "http://symfonyios.cloudapp.net/api/user/update", headers: headers,parameters: parameters)
                .validate()
                .response { response in
                NSNotificationCenter.defaultCenter().postNotificationName("refresh", object: nil, userInfo: nil)
                self.dismissViewControllerAnimated(true, completion: nil)
        }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
