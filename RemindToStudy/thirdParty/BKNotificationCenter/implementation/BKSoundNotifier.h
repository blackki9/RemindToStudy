//
//  BKSoundNotifier.h
//  BKNotificationCenter
//
//  Created by black9 on 01/05/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BKSoundNotifier : NSObject

- (void)initSound;
- (void)playNotificationSoundIfSharedAppIsActive;

@end
