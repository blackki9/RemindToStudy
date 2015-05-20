//
//  CardViewController.m
//  RemindToStudy
//
//  Created by black9 on 19/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import "CardViewController.h"
#import <MZFormSheetController.h>
#import "ModelConstants.h"

@interface CardViewController ()

@property (nonatomic, strong) CardView* currentCardView;

@end

@implementation CardViewController

+ (void)showCardPopupWithCardView:(CardView*)cardView
{
    //TODO refactor
    //TODO make sizes rely on sizes of screen
    CardViewController * viewController = (CardViewController*)[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"CardViewController"];
    
    [viewController setupUIWithCardView:cardView];
    
    MZFormSheetController *formSheet = [[MZFormSheetController alloc] initWithSize:[self popupSize]
                                                                    viewController:viewController];
    
    formSheet.portraitTopInset = [self portraitInset];
    
    formSheet.willPresentCompletionHandler = ^(UIViewController *presentedFSViewController) {
        // Passing data
    };
    
    formSheet.transitionStyle = MZFormSheetTransitionStyleFade;
    [formSheet presentAnimated:YES completionHandler:nil];
}
+ (CGSize)popupSize
{
    return CGSizeMake(360,
                      600);
}
+ (CGFloat)portraitInset
{
    return 20.0f;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUpSwipeRecognizer];
}
- (void)setupUpSwipeRecognizer
{
    UISwipeGestureRecognizer* swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeToUpRecognized:)];
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeRecognizer];
}
- (void)swipeToUpRecognized:(UISwipeGestureRecognizer*)swipeRecognizer
{
    if(swipeRecognizer.direction == UISwipeGestureRecognizerDirectionUp)
    {
        [self hidePopup];
    }
}
- (void)hidePopup
{
    [self mz_dismissFormSheetControllerAnimated:YES completionHandler:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self registerToNotifications];
}
- (void)registerToNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cardWasRemoved:) name:CARD_WAS_REMOVED_NOTIFICATION object:nil];
}
- (void)cardWasRemoved:(NSNotification*)notification
{
    [self hidePopup];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self deregisterToNotifications];
}
- (void)deregisterToNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupUIWithCardView:(CardView*)cardView
{
    self.currentCardView = cardView;
    self.currentCardView.frame = self.view.bounds;
    [self.view addSubview:cardView];
}

@end
