//
//  BKSoundNotifier.m
//  BKNotificationCenter
//
//  Created by black9 on 01/05/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import "BKSoundNotifier.h"
@import AVFoundation;
@import UIKit;

@interface BKSoundNotifier ()

@property (nonatomic, strong) AVAudioPlayer* notificationPlayer;

@end

@implementation BKSoundNotifier

- (void)initSound
{
    NSError *error;
    NSURL *audioURL = [[NSBundle mainBundle ]URLForResource:@"notification_sound.caf" withExtension:nil];
    
    self.notificationPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:audioURL error:&error];
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSError *errorSession = nil;
    [audioSession setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionDuckOthers error:nil];
    [audioSession setActive:NO error:&errorSession];
    
    [self.notificationPlayer prepareToPlay];
    [self.notificationPlayer setVolume:1.0];
}

- (void)playNotificationSoundIfSharedAppIsActive
{
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive ) {
        [self.notificationPlayer play];
    }
}

@end
