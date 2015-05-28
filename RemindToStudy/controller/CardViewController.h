//
//  CardViewController.h
//  RemindToStudy
//
//  Created by black9 on 19/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardView.h"

@interface CardViewController : UIViewController

+ (void)showCardPopupWithCardView:(CardView*)cardView;
- (void)setupUIWithCardView:(CardView*)cardView;

@end
