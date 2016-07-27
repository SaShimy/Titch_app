//
//  HomeController.swift
//  Titch
//
//  Created by Antoine Gunzburger on 26/07/2016.
//  Copyright © 2016 etna. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class HomeController: UIViewController {
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUser()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func refreshUser(notification: NSNotification) {
        loadUser()
    }
    
    func loadImage(imageUrl: String) {
        let URL = NSURL(string: imageUrl)
        profilePicture.af_setImageWithURL(URL!)
    }
    
    func loadUser() {
        let headers = [
            "Authorization": "Bearer " + token
        ]
        Alamofire.request(.GET, "http://symfonyios.cloudapp.net/api/user/me", headers: headers)
            .validate()
            .responseJSON { response in
                if (response.result.value != nil) {
                    let json = JSON(response.result.value!)
                    self.nameText.text = json["firstname"].stringValue + " " + json["lastname"].stringValue
                    self.loadImage(json["image"]["path"].stringValue)
                }
        }
    }

}
