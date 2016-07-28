//
//  Meal.swift
//  Titch
//
//  Created by lin_d on 7/21/16.
//  Copyright © 2016 etna. All rights reserved.
//

import Foundation

class Question {
    // MARK: Properties
    
    var text: String
    var id: String
    var answers: [Answer]
    
    
    init?(text: String, id: String, answers: [Answer]) {
        // Initialize stored properties.
        self.text = text
        self.answers = answers
        self.id = id
        
        // Initialization should fail if there is no name or if the rating is negative.
        if text.isEmpty || answers.isEmpty || id.isEmpty{
            return nil
        }
    }
    
}