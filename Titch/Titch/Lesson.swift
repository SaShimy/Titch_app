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
    var id: String
    var status: Int
    
    
    init?(title: String, desc: String, id: String, status: Int) {
        // Initialize stored properties.
        self.title = title
        self.desc = desc
        self.id = id
        self.status = status
        
        // Initialization should fail if there is no name or if the rating is negative.
        if title.isEmpty || desc.isEmpty {
            return nil
        }
    }
    
}