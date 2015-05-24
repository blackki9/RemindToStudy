//
//  AppDelegate.m
//  RemindToStudy
//
//  Created by black9 on 19/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import "AppDelegate.h"
#import "DBManager.h"
#import "NotificationCenter.h"
#import "NotificationHandler.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [DBManager sharedManager];
    
    [[NotificationCenter sharedCenter] initializeWithApplication:application];
    [[NotificationCenter sharedCenter] setNotificationHandler:[self handlerForNotifications]];
    
    [self injectCardManagersToListController];
    
    return YES;
}
- (void)injectCardManagersToListController
{
    
}
- (NotificationHandler*)handlerForNotifications
{
    NotificationHandler* handler = [[NotificationHandler alloc] init];
    [handler setNavigationController:[self rootControllerFromStoryboard]];
    
    return handler;
}
- (UINavigationController*)rootControllerFromStoryboard
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UINavigationController* navController = [storyboard instantiateInitialViewController];
    
    return navController;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    [[NotificationCenter sharedCenter] didReceiveLocalNotification:notification];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [[DBManager sharedManager] saveContext];
}

@end
