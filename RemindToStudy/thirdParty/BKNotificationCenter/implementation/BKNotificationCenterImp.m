//
//  BKNotificationCenterImp.m
//  RemindToStudy
//
//  Created by black9 on 30/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import "BKNotificationCenterImp.h"
#import "BKNotificationCanceler.h"
#import "BKNotificationRefresher.h"
#import "BKNotificationUtilities.h"
#import "BKNotificationScheduler.h"
#import "BKSoundNotifier.h"
#import "BKAlertNotifier.h"


@interface BKNotificationCenterImp ()

@property (nonatomic, strong) BKNotificationCanceler* canceler;
@property (nonatomic, strong) BKNotificationRefresher* refresher;
@property (nonatomic, strong) BKNotificationUtilities* utilities;
@property (nonatomic, strong) BKNotificationScheduler* scheduler;
@property (nonatomic, strong) BKSoundNotifier* soundNotifier;
@property (nonatomic, strong) BKAlertNotifier* alertNotifier;

@property (nonatomic,strong) CompletionAfterOpenAppFromNotification afterOpenFinishBlock;
@property (nonatomic, strong) UILocalNotification* currentNotification;

@end


@implementation BKNotificationCenterImp

+ (instancetype)sharedCenter
{
    static dispatch_once_t onceToken;
    static id sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _utilities = [[BKNotificationUtilities alloc] init];
        _canceler = [[BKNotificationCanceler alloc] initWithNotificationKey:[_utilities notificationIdKey]];
        _refresher = [[BKNotificationRefresher alloc] init];
        _scheduler = [[BKNotificationScheduler alloc] initWithNotificationUtilities:_utilities];
        _soundNotifier = [[BKSoundNotifier alloc] init];
        _alertNotifier = [[BKAlertNotifier alloc] initWithUtilities:_utilities];
    }
    
    return self;
}

- (void)initializeCenterWithApplication:(UIApplication*)application
{
    [self askUserToConfirmSendNotificationsWithApplication:application];
    [self cleanIfFirstLaunch];
    [self.refresher checkForOverdueNotifications];
    [self.soundNotifier initSound];
}

- (void)askUserToConfirmSendNotificationsWithApplication:(UIApplication*)application
{
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]){
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }
}

- (void)cleanIfFirstLaunch
{
    if([self isFirstLaunch])
    {
        [self setFirstLaunch];
        [self cancelAllNotifications];
    }
    else
    {
        [self.refresher refreshNotifications];
    }
}

- (BOOL)isFirstLaunch
{
    return ![[NSUserDefaults standardUserDefaults] boolForKey:[self.utilities firstLaunchKey]];
}

- (void)setFirstLaunch
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:[self.utilities firstLaunchKey]];
}

#pragma mark - receive local notification

- (void)didReceiveLocalNotification:(UILocalNotification*)localNotification
{
    self.currentNotification = localNotification;
    
    [self.soundNotifier playNotificationSoundIfSharedAppIsActive];
    [self.alertNotifier showAlertIfSharedAppIsActiveForLocalNotification:localNotification];
    [self triggerActionAfterOpenAppFromIfSharedAppInactive];
    
    self.currentNotification = nil;
}

- (void)triggerActionAfterOpenAppFromIfSharedAppInactive
{
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateInactive) {
        if(self.afterOpenFinishBlock) {
            self.afterOpenFinishBlock([self notificationIdFromLocalNotification:self.currentNotification]);
        }
    }
}
                                      
- (NSString*)notificationIdFromLocalNotification:(UILocalNotification*)localNotification
{
    return localNotification.userInfo[[self.utilities notificationIdKey]];
}

#pragma mark - schedule

- (void)scheduleSingleNotificationOnDate:(NSDate*)fireDate message:(NSString*)message key:(NSString*)key
{
    [self scheduleSingleNotificationOnDate:fireDate message:message key:key userInfo:[NSDictionary dictionary]];
}

- (void)scheduleSingleNotificationOnDate:(NSDate*)fireDate message:(NSString*)message key:(NSString*)key userInfo:(NSDictionary*)userInfo
{
    [self.scheduler scheduleSingleNotificationOnDate:fireDate message:message key:key userInfo:userInfo];
}

#pragma mark - cancel
- (void)cancelNotificationByKey:(NSString*)key
{
    [self.canceler cancelNotificationByKey:key];
}

- (void)cancelAllNotifications
{
    [self.canceler cancelAllNotifications];
}

#pragma mark - set blocks

- (void)setCompletitionHandler:(CompletionAlertBlock)finishBlock
{
    [self.alertNotifier setCompletitionHandler:finishBlock];
}


- (void)setActionAfterOpenApp:(CompletionAfterOpenAppFromNotification)afterOpenFinishBlock
{
    self.afterOpenFinishBlock = afterOpenFinishBlock;
}


- (void)setButtonTitles:(NSArray*)titles
{
    [self.alertNotifier setButtonTitles:titles];
}

@end
