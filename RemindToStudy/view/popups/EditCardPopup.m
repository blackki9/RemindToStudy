//
//  EditCardPopup.m
//  RemindToStudy
//
//  Created by black9 on 19/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import "EditCardPopup.h"

@interface EditCardPopup ()
@property (strong, nonatomic) IBOutlet UITextField *cardName;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIButton *dateButton;

@end

@implementation EditCardPopup

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)cancel:(id)sender {
}

- (IBAction)save:(id)sender {
}

@end
