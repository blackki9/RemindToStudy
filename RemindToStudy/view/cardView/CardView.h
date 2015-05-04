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

@interface CardView : UIView

@property (strong, nonatomic) IBOutlet UILabel *cardNameLabel;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *typeLabel;

- (void)setupViewWithCardViewer:(id<CardViewer>)viewer;
- (void)setupViewWithEditor:(id<CardEditor>)editor;

@end
