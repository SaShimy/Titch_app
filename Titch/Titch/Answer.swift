//
//  Meal.swift
//  Titch
//
//  Created by lin_d on 7/21/16.
//  Copyright © 2016 etna. All rights reserved.
//

import Foundation

class Answer {
    // MARK: Properties
    
    var text: String
    var is_valid: String
    var id: String
    
    
    init?(text: String, is_valid: String, id: String) {
        // Initialize stored properties.
        self.text = text
        self.is_valid = is_valid
        self.id = id
        
        // Initialization should fail if there is no name or if the rating is negative.
        if text.isEmpty || is_valid.isEmpty || id.isEmpty{
            return nil
        }
    }
    
}