//
//  profileprofile+CoreDataProperties.h
//  Galleree
//
//  Created by Diana Lim on 8/10/16.
//  Copyright © 2016 Dianatalie. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "profileprofile.h"

NS_ASSUME_NONNULL_BEGIN

@interface profileprofile (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *about;
@property (nullable, nonatomic, retain) NSData *image;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *occupation;

@end

NS_ASSUME_NONNULL_END
