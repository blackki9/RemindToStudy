//
//  CardView.h
//  RemindToStudy
//
//  Created by black9 on 23/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardViewer.h"
#import "CardEditor.h"

typedef void (^EditButtonAction) (NSInteger cardIndex);
typedef void (^CloseButtonAction) ();
@interface CardView : UIView

@property (strong, nonatomic) IBOutlet UILabel *cardNameLabel;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *typeLabel;
@property (nonatomic, assign) NSInteger cardIndex;

- (void)setupViewAndClearWithCardViewer:(id<CardViewer>)viewer;
- (void)setEditButtonAction:(EditButtonAction)action;
- (void)setCloseButtonAction:(CloseButtonAction)buttonAction;

- (void)showCloseButton;

@end
