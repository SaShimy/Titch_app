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

class HomeController: UIViewController, UIPopoverPresentationControllerDelegate {
    @IBOutlet weak var badgeImg1: UIImageView!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var badgeImg2: UIImageView!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var badgeImg3: UIImageView!
    
    @IBOutlet weak var nbBadges: UILabel!
    @IBOutlet weak var classProg: UILabel!
    @IBOutlet weak var classDone: UILabel!
    @IBOutlet weak var rankText: UILabel!
    @IBOutlet weak var coursText3: UILabel!
    @IBOutlet weak var coursText2: UILabel!
    @IBOutlet weak var coursText1: UILabel!
    
    
    
    let recognizer = UITapGestureRecognizer()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUser()
        loadClass()
        profilePicture.userInteractionEnabled = true
        recognizer.addTarget(self, action: #selector(HomeController.profileImageHasBeenTapped))
        profilePicture.addGestureRecognizer(recognizer)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "popOver" {
            let popoverViewController = segue.destinationViewController
            popoverViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
            popoverViewController.popoverPresentationController!.delegate = self
        }
    }
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    func profileImageHasBeenTapped(){
        performSegueWithIdentifier("OnProfile", sender: self)
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
                    self.rankText.text = json["rank"]["name"].stringValue
                    self.nbBadges.text = String(json["badges"].count)
                    if (json["badges"] != []) {
                        let img1Url = NSURL(string: json["badges"][0]["badge"]["file"]["path"].stringValue)
                        self.badgeImg1.af_setImageWithURL(img1Url!)
                        let img2Url = NSURL(string: json["badges"][1]["badge"]["file"]["path"].stringValue)
                        self.badgeImg2.af_setImageWithURL(img2Url!)
                    }
                    self.loadImage(json["image"]["path"].stringValue)
                }
        }
    }
    
    func loadClass() {
        let headers = [
            "Authorization": "Bearer " + token
        ]
        Alamofire.request(.GET, "http://symfonyios.cloudapp.net/api/lesson/type/all", headers: headers)
            .validate()
            .responseJSON { response in
                if (response.result.value != nil) {
                    let json = JSON(response.result.value!)
                    self.coursText1.text = json[0]["name"].stringValue
                    self.coursText2.text = json[1]["name"].stringValue
                    self.coursText3.text = json[2]["name"].stringValue
                }
                else {
                    self.view.makeToast("Error Call BDD")
                }
        }
    }
}
