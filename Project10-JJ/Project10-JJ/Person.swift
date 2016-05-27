//
//  Person.swift
//  Project10-JJ
//
//  Created by Javier Jara on 2/16/16.
//  Copyright © 2016 Roco Soft. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, photo image:String) {
        self.name = name
        self.image = image
    }
}
