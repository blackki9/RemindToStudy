//
//  Blocks.h
//  BKNotificationCenter
//
//  Created by black9 on 01/05/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#ifndef BKNotificationCenter_Blocks_h
#define BKNotificationCenter_Blocks_h

typedef void (^CompletionAlertBlock) (NSInteger buttonIndex, NSString *notificationId);
typedef void (^CompletionAfterOpenAppFromNotification) (NSString* notificationId);


#endif
