//
//  Lessons.swift
//  Titch
//
//  Created by lin_d on 7/21/16.
//  Copyright © 2016 etna. All rights reserved.
//
import UIKit
import SwiftyJSON
import Alamofire
import Toast_Swift

class VideoViewController: UIViewController {
    
    var id = String()
    var vidUrl = String()
    var questionsArray = [Question]()
    var answers = [Answer]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        let headers = ["Authorization" : "Bearer " + token]

        Alamofire.request(.GET, "http://symfonyios.cloudapp.net/api/lesson/\(id)", headers: headers)
            .validate()
            .responseJSON { response in
                if (response.result.value != nil) {
                    debugPrint(response.result.value!)
                    let json = JSON(response.result.value!)
            
                    self.vidUrl = json["file"]["path"].stringValue
                    let questions = json["questions"]
                    
                    for (_,question) in questions {
                        //Do something you want
                        for (_,answers) in question["options"] {
                            //Do something you want
                            let answertmp = Answer(text: answers["text"].stringValue, is_valid: answers["is_valid"].stringValue, id: answers["id"].stringValue)!
                            self.answers.append(answertmp)
                        }
                        let questiontmp = Question(text: question["text"].stringValue,id: question["id"].stringValue, answers:self.answers)!
                        self.questionsArray.append(questiontmp)
                        self.answers.removeAll()
                    }

                }
                else {
                    self.view.makeToast("Error Call BDD")
                }
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
       // tableV.reloadData()
        print(vidUrl)
        
        for test in questionsArray {
            print(test.text)
            for a in test.answers {
                print(a.text)
                print(a.id)
                print(a.is_valid)
            }
            print(test.id)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if  segue.identifier == "QuizPop",
            let destination = segue.destinationViewController as? QuizController
        {
            destination.questionsArray = questionsArray
            destination.idLesson = id
        }
    }
}
