//
//  HomeController.swift
//  Titch
//
//  Created by Antoine Gunzburger on 20/07/2016.
//  Copyright © 2016 etna. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeController: UIViewController {
    @IBOutlet weak var emailText: UILabel!
    @IBOutlet weak var ageText: UILabel!
    @IBOutlet weak var genderText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(token)
        let headers = [
            "Authorization": "Bearer " + token
        ]
        Alamofire.request(.GET, "http://symfonyios.cloudapp.net/user/api/me", headers: headers)
        .validate()
        .responseJSON { response in
            if (response.result.value != nil) {
                debugPrint(response.result.value)
                let json = JSON(response.result.value!)
                self.emailText.text = "Email : " + json["email"].stringValue
                self.ageText.text = "Age : " + json["age"].stringValue
                self.genderText.text = "Sexe : " + json["gender"].stringValue
            }
        }

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
