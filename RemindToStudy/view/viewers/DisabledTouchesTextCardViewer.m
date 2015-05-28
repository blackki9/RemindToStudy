//
//  DisabledTouchesTextCardViewer.m
//  RemindToStudy
//
//  Created by black9 on 02/05/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import "DisabledTouchesTextCardViewer.h"

@implementation DisabledTouchesTextCardViewer

- (void)addUIToContentView:(UIView *)contentView{
    [super addUIToContentView:contentView];
    [super disableTouches];
}


@end
