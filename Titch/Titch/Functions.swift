//
//  Functions.swift
//  Titch
//
//  Created by lin_d on 7/20/16.
//  Copyright © 2016 etna. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import Toast_Swift

var ConnectionState : String = String()
let global:NSUserDefaults = NSUserDefaults.standardUserDefaults()


class Functions {
    
    func Connect(login: String, password: String) -> String {
        let parameters = [
            "grant_type": "password",
            "client_id": "1_3bcbxd9e24g0gk4swg0kwgcwg4o8k8g4g888kwc44gcc0gwwk4",
            "client_secret": "4ok2x70rlfokc8g0wws8c8kwcokw80k44sg48goc0ok4w0so0k",
            "username": login,
            "password": password
        ]
        
        Alamofire.request(.POST, "http://symfonyios.cloudapp.net/oauth/v2/token", parameters: parameters)
            .validate()
            .responseJSON { response in
                if (response.result.value != nil) {
                    debugPrint(response.result.value)
                    let json = JSON(response.result.value!)
                    token = json["access_token"].stringValue
                    print("Le token : \(token)")
                    /*self.performSegueWithIdentifier("OnConnect", sender: self)*/
                    ConnectionState = "ok"
                    global.setObject("ok", forKey:"ConnectionState")
                }
                else {
                    
                    ConnectionState = "ko"
                    print("3 \(ConnectionState)")
                    /*self.view.makeToast("Le mot de passe ou l'utilisateur ne sont pas corrects.")*/
                }
        }
        print("1 \(ConnectionState)")
        let ok = global.valueForKey("label2") as? String
        print("4 \(ok)")
        return ConnectionState
    }
    
}