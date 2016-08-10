//
//  SearchableRecord.swift
//  Galleree
//
//  Created by Natalie Lim on 7/28/16.
//  Copyright © 2016 Dianatalie. All rights reserved.
//

import Foundation

@objc protocol SearchableRecord: class {
    
    func matchesSearchTerm(searchTerm: String) -> Bool
}