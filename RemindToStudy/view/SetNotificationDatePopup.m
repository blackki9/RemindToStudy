//
//  SetNotificationDatePopup.m
//  RemindToStudy
//
//  Created by black9 on 19/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import "SetNotificationDatePopup.h"
#import <MZFormSheetController.h>

@interface SetNotificationDatePopup ()

@property (nonatomic,strong) NotificationSetCompletion finishBlock;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation SetNotificationDatePopup

+ (SetNotificationDatePopup*)showPopupWithCompletion:(NotificationSetCompletion)finishBlock
{
    SetNotificationDatePopup * viewController = (SetNotificationDatePopup*) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"SetNotificationDatePopup"];
    
    
    MZFormSheetController *formSheet = [[MZFormSheetController alloc] initWithSize:CGSizeMake(300,
                                                                                              300)
                                                                    viewController:viewController];
    formSheet.portraitTopInset = 100;
    formSheet.willPresentCompletionHandler = ^(UIViewController *presentedFSViewController) {
        [viewController setCompletionBlock:finishBlock];
    };
    
    formSheet.transitionStyle = MZFormSheetTransitionStyleSlideAndBounceFromLeft;
    [formSheet presentAnimated:YES completionHandler:nil];
    
    return viewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setCompletionBlock:(NotificationSetCompletion)finishBlock
{
    self.finishBlock = finishBlock;
}

- (IBAction)saveAction:(id)sender {
    self.finishBlock(self.datePicker.date);
    [self hidePopup];
}

- (IBAction)cancel:(id)sender {
    [self hidePopup];
}

- (void)hidePopup
{
    [self mz_dismissFormSheetControllerAnimated:YES completionHandler:nil];
}

@end
