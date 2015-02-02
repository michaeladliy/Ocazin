//
//  LogInViewController.h
//  LogInModule
//
//  Created by Michael Adliy on 10/29/14.
//  Copyright (c) 2014 Michael Adliy. All rights reserved.
//

#import "ViewController.h"

@interface LogInViewController : ViewController
// TextFields
@property (strong, nonatomic) IBOutlet UITextField *passwordTxtField;
@property (strong, nonatomic) IBOutlet UITextField *usernameTxtField;
// Buttons
@property (strong, nonatomic) IBOutlet UIButton *forgetPasswordBtn;
@property (strong, nonatomic) IBOutlet UIButton *logInBtn;
@property (strong, nonatomic) IBOutlet UIButton *registerBtn;
@property (strong, nonatomic) IBOutlet UIButton *faceBookBtn;


@end
