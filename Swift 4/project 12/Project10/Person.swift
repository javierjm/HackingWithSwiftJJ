//
//  Person.swift
//  Project10
//
//  Created by TwoStraws on 18/08/2016.
//  Copyright © 2016 Paul Hudson. All rights reserved.
//

import UIKit

final class Person: NSObject, NSCoding {
	var name: String
	var image: String

	init(name: String, image: String) {
		self.name = name
		self.image = image
	}
    
    init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: Constants.StoredKeys.name) as! String
        image = aDecoder.decodeObject(forKey: Constants.StoredKeys.image) as? String ?? ""
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: Constants.StoredKeys.name)
        aCoder.encode(image, forKey: Constants.StoredKeys.image)
    }
}
