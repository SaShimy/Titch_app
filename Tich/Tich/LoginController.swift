//
//  ViewController.swift
//  Tich
//
//  Created by Antoine Gunzburger on 18/07/2016.
//  Copyright © 2016 etna. All rights reserved.
//

import UIKit
import SwiftyJSON

var token : String = String()

class LoginController: UIViewController {
    @IBOutlet weak var loginText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBAction func loginButton(sender: AnyObject) {
        let request = NSMutableURLRequest(URL: NSURL(string: "http://symfonyios.cloudapp.net/oauth/v2/token")!)
        request.HTTPMethod = "POST"
        let postString = "grant_type=password&client_id=1_3bcbxd9e24g0gk4swg0kwgcwg4o8k8g4g888kwc44gcc0gwwk4&client_secret=4ok2x70rlfokc8g0wws8c8kwcokw80k44sg48goc0ok4w0so0k&username=" + loginText.text! + "&password=" + passwordText.text!
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            let json = JSON(data:data!)
            token = json["access_token"].stringValue
            print("Le json \(json["access_token"].stringValue)")
//            print("responseString = \(token)")
        }
        task.resume()
        
    }
    
    @IBAction func signupButton(sender: AnyObject) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("SignUp")
        self.presentViewController(nextViewController, animated:true, completion:nil)
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

