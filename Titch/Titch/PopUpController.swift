//
//  PopUpController.swift
//  Titch
//
//  Created by Antoine Gunzburger on 21/07/2016.
//  Copyright © 2016 etna. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PopUpController: UIViewController {

    @IBOutlet weak var fName: UITextField!
    @IBOutlet weak var lName: UITextField!
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var age: UITextField!
    @IBAction func sendProfile(sender: AnyObject) {
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
        print(headers)
        print(parameters)
        Alamofire.request(.PUT, "http://symfonyios.cloudapp.net/api/user/update", headers: headers,parameters: parameters)
        .validate()
        dismissViewControllerAnimated(true, completion: nil)
    }
}
