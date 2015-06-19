//
//  KeyboardHider.m
//  RemindToStudy
//
//  Created by black9 on 01/05/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import "BKTextViewKeyboardHider.h"

@interface BKTextViewKeyboardHider ()

@end

@implementation BKTextViewKeyboardHider

- (UITextView*)addToolbarToTextView:(UITextView*)textView
{
    UIToolbar* keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneClicked:)];
    
    UIBarButtonItem* flexSpace = [[UIBarButtonItem alloc]  initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *fake = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil] ;
    
    [keyboardDoneButtonView setItems:@[flexSpace,fake,doneButton] animated:YES];
    
    [textView setInputAccessoryView:keyboardDoneButtonView];
    
    return textView;
}

- (void)doneClicked:(UIBarButtonItem*)sender
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

@end
