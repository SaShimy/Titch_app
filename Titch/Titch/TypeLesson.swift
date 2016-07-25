//
//  TypeLesson.swift
//  Titch
//
//  Created by lin_d on 7/22/16.
//  Copyright © 2016 etna. All rights reserved.
//

import Foundation

class TypeLesson {
    // MARK: Properties
    
    var name: String
    var desc: String
    var id: String
    
    
    init?(name: String, desc: String, id: String) {
        // Initialize stored properties.
        self.name = name
        self.desc = desc
        self.id = id
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || desc.isEmpty || id.isEmpty{
            return nil
        }
    }
    
}