//
//  UserProfileViewController.h
//  LogInModule
//
//  Created by Michael Adliy on 10/29/14.
//  Copyright (c) 2014 Michael Adliy. All rights reserved.
//

#import "ViewController.h"

@interface UserProfileViewController : ViewController
@property (strong, nonatomic) IBOutlet UITextField *emailTxtField;
@property (strong, nonatomic) IBOutlet UITextField *phoneNoTxtField;
@property (strong, nonatomic) IBOutlet UITextField *usernameTxtField;

@property (strong, nonatomic) IBOutlet UIButton *changePasswordBtn;
@property (strong, nonatomic) IBOutlet UIButton *saveBtn;
@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;

@property (strong, nonatomic) IBOutlet UIButton *profilePictureBtn;

@end
