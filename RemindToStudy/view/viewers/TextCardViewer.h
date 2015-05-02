//
//  TextCardViewer.h
//  RemindToStudy
//
//  Created by black9 on 02/05/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CardViewer.h"

@class Card;

@interface TextCardViewer : NSObject <CardViewer>

- (instancetype)initWithCard:(Card*)card;

@end
