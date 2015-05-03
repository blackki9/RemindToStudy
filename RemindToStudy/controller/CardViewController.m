//
//  CardViewController.m
//  RemindToStudy
//
//  Created by black9 on 19/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import "CardViewController.h"
#import <MZFormSheetController.h>

@interface CardViewController ()

@property (nonatomic, strong) CardView* currentCardView;

@end

@implementation CardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (void)setupUIWithCardView:(CardView*)cardView
{
    self.currentCardView = cardView;
    self.currentCardView.frame = self.view.bounds;
    [self.view addSubview:cardView];
}



@end
