//
//  Person.swift
//  Project 10
//
//  Created by Javier Jara on 10/11/17.
//  Copyright © 2017 Test. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
