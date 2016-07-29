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
import DLRadioButton

class QuizController: UIViewController {
    
    var idLesson = String()
    var questionsArray = [Question]()
    var questionIndex = 0
    var msgErr = String()
    var indexValid = 0
    var goNext = 0
    
    @IBOutlet var btn1: DLRadioButton!
    
    @IBOutlet var btn2: DLRadioButton!
    
    @IBOutlet var btn3: DLRadioButton!
    
    @IBOutlet var questionNum: UILabel!
    
    @IBOutlet var question: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for (index, test) in questionsArray.enumerate() {
            
            if( index == questionIndex) {
                questionNum.text = "Question \(index + 1 )/\(questionsArray.count)"
                question.text = test.text
                if(test.answers.count == 2){
                    btn3.hidden = true
                }
                else {
                    btn3.hidden = false
                }
                for (index2, answ) in test.answers.enumerate() {
                    if(answ.is_valid == "true") {
                        indexValid = (index2 + 1)
                    }
                    if(index2 == 0)
                    {
                        btn1.setTitle(answ.text, forState: .Normal)
                    }
                    else if (index2 == 1)
                    {
                        btn2.setTitle(answ.text, forState: .Normal)
                    }
                    else
                    {
                        btn3.setTitle(answ.text, forState: .Normal)
                    }
                }
                
            }
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        /* print("indexvalid")
         print(indexValid)*/
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func act(sender: AnyObject) {
        btn2.selected = false
        btn3.selected = false
        btn3.hidden = true
    }
    
    @IBAction func act2(sender: AnyObject){
        btn1.selected = false
        btn3.selected = false
    }
    
    @IBAction func act3(sender: AnyObject){
        btn2.selected = false
        btn1.selected = false
    }
    
    @IBAction func valider(sender: UIButton) {
        if (indexValid == 1 && btn1.selected == true) {
            questionIndex += 1
            goNext = 1
        }
        else if (indexValid == 2 && btn2.selected == true) {
            questionIndex += 1
            goNext = 1
        }
        else if (indexValid == 3 && btn3.selected == true) {
            questionIndex += 1
            goNext = 1
        }
        else {
            self.view.makeToast("Mauvaise réponse, car blblblb")
        }
        
        if (questionIndex == questionsArray.count && goNext == 1) {
            self.view.makeToast("Lesson validée")
            LessonValidate()
        }
        else {
            updateQuestion()
            goNext = 0
        }
    }
    
    func updateQuestion() {
        for (index, test) in questionsArray.enumerate() {
            
            if( index == questionIndex) {
                questionNum.text = "Question \(index + 1)/\(questionsArray.count)"
                question.text = test.text
                if(test.answers.count == 2){
                    btn3.hidden = true
                }
                else {
                    btn3.hidden = false
                }
                for (index2, answ) in test.answers.enumerate() {
                    if(answ.is_valid == "true") {
                        indexValid = (index2 + 1)
                    }
                    if(index2 == 0)
                    {
                        btn1.setTitle(answ.text, forState: .Normal)
                    }
                    else if (index2 == 1)
                    {
                        btn2.setTitle(answ.text, forState: .Normal)
                    }
                    else
                    {
                        btn3.setTitle(answ.text, forState: .Normal)
                    }
                }
                
            }
        }
    }
    
    func LessonValidate() {
        
        let headers = ["Authorization" : "Bearer " + token]
        
        Alamofire.request(.POST, "http://symfonyios.cloudapp.net/api/survey/answer/\(idLesson)", headers: headers)
            .validate()
            .responseJSON { response in
                if (response.result.value != nil) {
                    print("validée")
                }
                
        }
        
    }
    
}
