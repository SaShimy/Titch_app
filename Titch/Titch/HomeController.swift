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

class HomeController: UIViewController, UIPopoverPresentationControllerDelegate {
    @IBOutlet weak var emailText: UILabel!
    @IBOutlet weak var ageText: UILabel!
    @IBOutlet weak var genderText: UILabel!
    @IBOutlet weak var firstnameText: UILabel!
    @IBOutlet weak var lastnameText: UILabel!
    @IBAction func refresh(sender: AnyObject) {
        loadUser()
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "popUp" {
            let popoverViewController = segue.destinationViewController
            popoverViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
            popoverViewController.popoverPresentationController!.delegate = self
        }
    }
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUser()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func popoverPresentationControllerDidDismissPopover(popoverPresentationController: UIPopoverPresentationController) {
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
                    debugPrint(response.result.value)
                    let json = JSON(response.result.value!)
                    self.emailText.text = "Email : " + json["email"].stringValue
                    self.ageText.text = "Age : " + json["age"].stringValue
                    self.genderText.text = "Sexe : " + json["gender"].stringValue
                    self.firstnameText.text = "Prénom : " + json["firstname"].stringValue
                    self.lastnameText.text = "Sexe : " + json["lastname"].stringValue
                }
        }
    }
}
