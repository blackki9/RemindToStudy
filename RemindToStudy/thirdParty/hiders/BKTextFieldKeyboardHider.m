//
//  BKTextFieldKeyboardHider.m
//  RemindToStudy
//
//  Created by black9 on 01/05/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import "BKTextFieldKeyboardHider.h"

@implementation BKTextFieldKeyboardHider

- (UITextField*)addHidingKeyboardOnReturnAndSetDelegateForTextField:(UITextField *)textField
{
    [textField setKeyboardType:UIKeyboardTypeDefault];
    [textField setReturnKeyType:UIReturnKeyDone];
    
    textField.delegate = self;
    
    return textField;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
