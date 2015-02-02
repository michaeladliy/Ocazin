//
//  ChangePasswordViewController.h
//  LogInModule
//
//  Created by Michael Adliy on 11/2/14.
//  Copyright (c) 2014 Michael Adliy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePasswordViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *usernameTxtField;
@property (strong, nonatomic) IBOutlet UITextField *oldPasswordTxtField;
@property (strong, nonatomic) IBOutlet UITextField *confirmPasswordTxtField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTxtField;

@property (strong, nonatomic) IBOutlet UIButton *submitBtn;

@end
