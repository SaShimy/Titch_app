//
//  ProfileController.swift
//  Titch
//
//  Created by Antoine Gunzburger on 27/07/2016.
//  Copyright © 2016 etna. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import Material

class ProfileController: UIViewController {
    @IBOutlet weak var PhotoBtt: FlatButton!
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var fName: UILabel!
    @IBOutlet weak var lName: UILabel!
    @IBOutlet weak var Age: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var modifyButton: FabButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUser()
        // Do any additional setup after loading the view, typically from a nib.
        prepareStyle()
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(refreshUser),
            name: "refresh",
            object: nil)        // Do any additional setup after loading the view, typically from a nib.

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
    
    func loadImage(imageUrl: String) {
        let URL = NSURL(string: imageUrl)
        profilePicture.af_setImageWithURL(URL!)
    }
    
    @objc func refreshUser(notification: NSNotification) {
        loadUser()
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
                    self.fName.text = json["firstname"].stringValue
                    self.lName.text = json["lastname"].stringValue
                    self.Age.text = json["age"].stringValue
                    self.gender.text = json["gender"].stringValue
                    self.loadImage(json["image"]["path"].stringValue)
                }
        }
    }
}
