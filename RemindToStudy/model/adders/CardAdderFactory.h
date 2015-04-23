//
//  CardAdderFactory.h
//  RemindToStudy
//
//  Created by black9 on 23/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CardAdder;

typedef enum {
    kTextAdder = 0
} AdderType;

@interface CardAdderFactory : NSObject

+ (id<CardAdder>)adderForType:(AdderType)adderType;

@end
