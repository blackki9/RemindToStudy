//
//  DBManager.m
//  RemindToStudy
//
//  Created by black9 on 22/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager

+ (instancetype)sharedManager
{
    static dispatch_once_t once;
    static DBManager* sharedInstance = nil;
    
    dispatch_once(&once,^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initDB];
    }
    return self;
}

- (void)initDB
{
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"RemindToStudy"];
}

- (void)saveContext {
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"You successfully saved your context.");
        } else if (error) {
            NSLog(@"Error saving context: %@", error.description);
        }
    }];
}




@end
