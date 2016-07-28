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

class PopOverController: UIViewController {

    @IBOutlet weak var fName: UITextField!
    @IBOutlet weak var lName: UITextField!
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var age: UITextField!
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
}
