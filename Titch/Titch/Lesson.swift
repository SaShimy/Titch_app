//
//  Meal.swift
//  Titch
//
//  Created by lin_d on 7/21/16.
//  Copyright © 2016 etna. All rights reserved.
//

import Foundation

class Lesson {
    // MARK: Properties
    
    var title: String
    var desc: String

    
    init?(title: String, desc: String) {
        // Initialize stored properties.
        self.title = title
        self.desc = desc
        
        // Initialization should fail if there is no name or if the rating is negative.
        if title.isEmpty || desc.isEmpty {
            return nil
        }
    }

}