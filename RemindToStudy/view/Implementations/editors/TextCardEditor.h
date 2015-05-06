//
//  TextCardEditor.h
//  RemindToStudy
//
//  Created by black9 on 19/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CardEditor.h"

@interface TextCardEditor : NSObject <CardEditor>

- (instancetype)initWithCard:(Card*)card;

@end
