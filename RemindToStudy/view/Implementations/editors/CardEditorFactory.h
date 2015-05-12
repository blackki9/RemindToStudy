//
//  CardEditorFactory.h
//  RemindToStudy
//
//  Created by black9 on 10/05/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CardEditor.h"
@class Card;

@interface CardEditorFactory : NSObject

+ (id<CardEditor>)cardEditorForCard:(Card*)card;

@end
