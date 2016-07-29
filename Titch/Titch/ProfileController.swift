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

class ProfileController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var PhotoBtt: FlatButton!
    @IBOutlet weak var fName: UILabel!
    @IBOutlet weak var imagePicked: UIImageView!
    @IBAction func imgPicker(sender: AnyObject) {
        let alertController = UIAlertController()
        let camera = UIAlertAction(title: "Take photo", style: .Default, handler: { (action) -> Void in
            self.openCamera();
        })
        let  library = UIAlertAction(title: "Choose from library", style: .Default) { (action) -> Void in
            self.openImageLibrary();
        }
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action) -> Void in
        })
        alertController.addAction(camera)
        alertController.addAction(library)
        alertController.addAction(cancel)
        presentViewController(alertController, animated: true, completion: nil)
    }
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
    
    func openImageLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            imagePicker.allowsEditing = true
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let uploadFileURL = info[UIImagePickerControllerReferenceURL] as! NSURL
        
        let imageName = uploadFileURL.lastPathComponent
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first! as String
        
        // getting local path
        let localPath = (documentDirectory as NSString).stringByAppendingPathComponent(imageName!)
        
        
        //getting actual image
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        let data = UIImagePNGRepresentation(image)
        data!.writeToFile(localPath, atomically: true)
        
        let imageData = NSData(contentsOfFile: localPath)!
        let imageURL = NSURL(fileURLWithPath: localPath)
        let headers = [
            "Authorization": "Bearer " + token
        ]
        Alamofire.upload(
            .POST,
            "http://symfonyios.cloudapp.net/api/user/profile/image/add",
            headers: headers,
            multipartFormData: { multipartFormData in
                multipartFormData.appendBodyPart(fileURL: imageURL, name: "file")
            },
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .Success(let upload, _, _):
                    upload.responseJSON { response in
                        self.loadUser()
                    }
                case .Failure(let encodingError):
                    print(encodingError)
                }
            }
        )
        picker.dismissViewControllerAnimated(true, completion: nil)
        
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
