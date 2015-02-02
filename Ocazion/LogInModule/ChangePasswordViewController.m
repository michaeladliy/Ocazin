//
//  ChangePasswordViewController.m
//  LogInModule
//
//  Created by Michael Adliy on 11/2/14.
//  Copyright (c) 2014 Michael Adliy. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "UITextField+PaddingTextFiled.h"
#import "LogInViewController.h"

#import "StaticMethods.h"

#import "validation.h"
#import "Parser_Generic.h"
#import "Parser_Login.h"


@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController
@synthesize usernameTxtField,oldPasswordTxtField,confirmPasswordTxtField,passwordTxtField;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)setupUI
{
    // add padding to TextField
    passwordTxtField =[passwordTxtField addPaddingToTextField:passwordTxtField];
    usernameTxtField =[usernameTxtField addPaddingToTextField:usernameTxtField];
    passwordTxtField =[passwordTxtField addPaddingToTextField:passwordTxtField];
    confirmPasswordTxtField =[confirmPasswordTxtField addPaddingToTextField:confirmPasswordTxtField];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)changeNewPasswordAction:(id)sender {
    if ([self validateChangepassword]) {
        [StaticMethods addLoadingView];
        [self loadChangePasswordParser];
    }
}


-(BOOL)validateChangepassword
{
    
    validation *validate=[[validation alloc] init];
    
    [validate Required:usernameTxtField.text FieldName:@"Username"];
    [validate Required:oldPasswordTxtField.text FieldName:@"OLd Password"];
    [validate Required:passwordTxtField.text FieldName:@"New Password"];
    [validate Required:confirmPasswordTxtField.text FieldName:@"Confirm Password"];
    
    
    
    if([validate isValid] == TRUE&&[passwordTxtField.text isEqualToString:confirmPasswordTxtField.text]){
        return YES;
    }else if([validate isValid] == FALSE){
        
        [StaticMethods showAlertWithTitle:@"Validation error" message:validate.errorMsg[0] delegate:nil cancelButtonTitle:@"OK" otherButtonTitle:nil];
        return NO;
    }else
    {
        [StaticMethods showAlertWithTitle:@"Validation error" message:@"passwords don't match" delegate:nil cancelButtonTitle:@"OK" otherButtonTitle:nil];
        return NO;
    }
    
    return YES;
    
}
-(void)loadChangePasswordParser
{
    Parser_Generic * changePasswordParser = [[Parser_Generic alloc]init];
    [changePasswordParser loadParserWithURL:[NSString stringWithFormat:@"%@ChangePassword?userName=%@&oldPassword=%@&newPassword=%@",BASEURL , usernameTxtField.text, oldPasswordTxtField.text, passwordTxtField.text]];
    if ([changePasswordParser connectToURL]) {
        // Done
        if ([changePasswordParser.messageCode isEqualToString:@"200"]) {
            // logout and go to login
            [self parserDidFinishWithSuccess];
        }
        else {
            // Not Right Result
            [StaticMethods showAlertWithTitle:@"" message:changePasswordParser.messageText delegate:nil cancelButtonTitle:@"OK" otherButtonTitle:nil];
        }
    }
    else {
        // Error in connection
        [StaticMethods showAlertWithTitle:@"" message:@"Connection error" delegate:nil cancelButtonTitle:@"OK" otherButtonTitle:nil];
    }
    [StaticMethods removeLoadingView];
}



-(void)parserDidFinishWithSuccess
{
    // write here your code to be implemented after change password
    [StaticMethods showAlertWithTitle:@"" message:@"Password will be sent to your email" delegate:nil cancelButtonTitle:@"OK" otherButtonTitle:nil];
    
    //            UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"LogInModule" bundle:nil];
    //            LogInViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"LogInViewController"];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
