//
//  Comment+CoreDataProperties.swift
//  Galleree
//
//  Created by Natalie Lim on 7/28/16.
//  Copyright © 2016 Dianatalie. All rights reserved.
//

import Foundation
import CoreData

extension Comment {

    @NSManaged var text: String?
    @NSManaged var post: Post?

}
