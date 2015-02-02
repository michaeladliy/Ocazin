//
//  RegisterViewController.h
//  LogInModule
//
//  Created by Michael Adliy on 10/29/14.
//  Copyright (c) 2014 Michael Adliy. All rights reserved.
//

#import "ViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import <FacebookSDK/FacebookSDK.h>

@interface RegisterViewController : ViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate>
// TextField
@property (strong, nonatomic) IBOutlet UITextField *usernameTxtField;
@property (strong, nonatomic) IBOutlet UITextField *phoneNoTxtField;
@property (strong, nonatomic) IBOutlet UITextField *emailTxtField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTxtField;
@property (strong, nonatomic) IBOutlet UITextField *confirmPasswordTxtField;
// Buttons
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
@property (strong, nonatomic) IBOutlet UIButton *addPhotoBtn;
// ScrollView
@property (strong, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *mainScroll;


@property (nonatomic) BOOL isFacebookRegister;

@end
