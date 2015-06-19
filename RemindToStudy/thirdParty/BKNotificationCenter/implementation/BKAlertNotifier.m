//
//  BKAlertNotifier.m
//  BKNotificationCenter
//
//  Created by black9 on 01/05/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import "BKAlertNotifier.h"
#import "BKNotificationUtilities.h"
@import UIKit;

@interface BKAlertNotifier ()

@property (nonatomic, strong) NSArray* currentButtonTitles;
@property (nonatomic,strong) CompletionAlertBlock finishBlock;
@property (nonatomic, copy) NSString* currentNotificationId;
@property (nonatomic, strong) BKNotificationUtilities* utils;
@end

@implementation BKAlertNotifier

- (instancetype)initWithUtilities:(BKNotificationUtilities*)utilities
{
    if(self = [super init]) {
        _utils = utilities;
    }
    
    return self;
}

#pragma mark - alert

- (void)showAlertIfSharedAppIsActiveForLocalNotification:(UILocalNotification*)localNotification
{
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive ) {
        
        self.currentNotificationId = localNotification.userInfo[[self.utils notificationIdKey]];
        
        [self showAlertForLocalNotification:localNotification];
    }
}

- (void)showAlertForLocalNotification:(UILocalNotification*)localNotification
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:localNotification.alertTitle message:localNotification.alertBody delegate:self cancelButtonTitle:[self cancelButtonTitle] otherButtonTitles:nil];
    
    alert = [self setupAlertButtons:alert];
    
    [alert show];
}

- (NSString*)cancelButtonTitle
{
    if(self.currentButtonTitles && self.currentButtonTitles.count) {
        return @"Cancel";
    }
    
    return @"OK";
}

- (UIAlertView*)setupAlertButtons:(UIAlertView*)alert
{
    if(self.currentButtonTitles) {
        for(NSString* buttonTitle in self.currentButtonTitles) {
            [alert addButtonWithTitle:buttonTitle];
        }
    }
    
    return alert;
}

#pragma mark - UIAlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(self.finishBlock) {
        self.finishBlock(buttonIndex,self.currentNotificationId);
    }
}

#pragma mark - setters

- (void)setCompletitionHandler:(CompletionAlertBlock)finishBlock
{
    self.finishBlock = finishBlock;
}

- (void)setButtonTitles:(NSArray*)titles
{
    self.currentButtonTitles = titles;
}



@end
