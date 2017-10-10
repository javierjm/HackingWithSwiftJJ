//
//  Constants.swift
//  Project 7
//
//  Created by Javier Jara on 10/6/17.
//  Copyright © 2017 Roco Soft. All rights reserved.
//

import UIKit

enum Constants{
    enum CellIdentifiers{
        static let mainCellIdentifier = "Cell"
    }
    
    enum API{
        static let witheHousePetitionURL = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        static let witheHousePopularPetitionURL = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        static let metaDataKey = "metadata"
        static let responseKey = "responseInfo"
        static let statusKey = "status"
        static let responseOk = 200
        static let resultKey = "results"
    }
}
