//
//  LogInViewController.m
//  LogInModule
//
//  Created by Michael Adliy on 10/29/14.
//  Copyright (c) 2014 Michael Adliy. All rights reserved.
//

#import "LogInViewController.h"
#import "String.h"

#import "UserProfileViewController.h"
#import "UITextField+PaddingTextFiled.h"

#import "StaticMethods.h"

#import "validation.h"

#import "Parser_Login.h"
#import "Parser_Generic.h"
#import "RegisterViewController.h"

#import "UserDS.h"

@interface LogInViewController ()

@end

@implementation LogInViewController
@synthesize passwordTxtField,usernameTxtField,registerBtn,logInBtn,faceBookBtn,forgetPasswordBtn;
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
    
    // add padding to textfileds
    passwordTxtField =[passwordTxtField addPaddingToTextField:passwordTxtField];
    usernameTxtField =[usernameTxtField addPaddingToTextField:usernameTxtField];
}
// handle dismiss keyboard
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


// IBActions

- (IBAction)loginAction:(id)sender {
    if ([self validateInputsForLogin]) {
        [StaticMethods addLoadingView];
        [self loadLogInParser];
    }
}

- (IBAction)forgetPasswordAction:(id)sender {
    
    if ([self validateInputsForForgetPassword]) {
        [StaticMethods addLoadingView];
        [self loadForgetPasswordParser];
    }
    
}

// validate username and password are required
-(BOOL)validateInputsForLogin
{
    validation *validate=[[validation alloc] init];
    [validate Required:usernameTxtField.text FieldName:@"Username"];
    [validate Required:passwordTxtField.text FieldName:@"Password"];
    
    if([validate isValid] == TRUE){
        return YES;
    }else{
        
        [StaticMethods showAlertWithTitle:@"Validation error" message:validate.errorMsg[0] delegate:nil cancelButtonTitle:@"OK" otherButtonTitle:nil];
        return NO;
    }
    
    return YES;
}
// validate username is required
-(BOOL)validateInputsForForgetPassword
{
    // validate user named
    
    
    validation *validate=[[validation alloc] init];
    
    
    [validate Required:usernameTxtField.text FieldName:@"Username"];
    
    if([validate isValid] == TRUE){
        return YES;
    }else{
        
        [StaticMethods showAlertWithTitle:@"Validation error" message:validate.errorMsg[0] delegate:nil cancelButtonTitle:@"OK" otherButtonTitle:nil];
        return NO;
    }
    
    return YES;
}

-(void)loadLogInParser
{
    Parser_Login  *loginParser = [[Parser_Login alloc]init];
    [loginParser loadParserWithUsername:usernameTxtField.text password:passwordTxtField.text];
    if ([loginParser connectToURL]) {
        // Done
        if ([loginParser.messageCode isEqualToString:@"200"]) {
            [self loginParserDidFinishWithSuccessWithUser:loginParser.user];
            // Move to Home Screen
            //            [[MyPList alloc]write:@"UserID" value:[[objectLogin.arrLogin objectAtIndex:0] stLoginID]];
            //            [[MyPList alloc]write:@"UserName" value:txtUsername.text];
            //            [[MyPList alloc]write:@"firstTime" value:@"NO"];
            //            HomeScreenView *home = [[HomeScreenView alloc]initWithNibName:@"HomeScreenView" bundle:nil];
            //            [self.navigationController pushViewController:home animated:YES];
        }
        else {
            // Not Right Result
            [StaticMethods showAlertWithTitle:@"" message:loginParser.messageText delegate:nil cancelButtonTitle:@"OK" otherButtonTitle:nil ];
        }
    }
    else {
        // Error in connection
        [StaticMethods showAlertWithTitle:@"" message:@"Connection error" delegate:nil cancelButtonTitle:@"OK" otherButtonTitle:nil ];
    }
    [StaticMethods removeLoadingView];
    
}

-(void)loadForgetPasswordParser
{
    
    Parser_Generic * forgetPasswordParser = [[Parser_Generic alloc]init];
    [forgetPasswordParser loadParserWithURL:[NSString stringWithFormat:@"%@ForgetPassword?userName=%@",BASEURL,usernameTxtField.text]];
    if ([forgetPasswordParser connectToURL]) {
        // Done
        if ([forgetPasswordParser.messageCode isEqualToString:@"200"]) {
            // Move to Home Screen
            [self forgetPasswordParserDidFinishWithSuccess];
        }
        else {
            // Not Right Result
             [StaticMethods showAlertWithTitle:@"" message:forgetPasswordParser.messageText delegate:nil cancelButtonTitle:@"OK" otherButtonTitle:nil];
        }
    }
    else {
        // Error in connection
         [StaticMethods showAlertWithTitle:@"" message:@"Connection error" delegate:nil cancelButtonTitle:@"OK" otherButtonTitle:nil];
    }
    [StaticMethods removeLoadingView];
 
}



-(void)loginParserDidFinishWithSuccessWithUser:(UserDS *)user
{
    // write here your code to be implemented after login
    
}

-(void)forgetPasswordParserDidFinishWithSuccess
{
    // write here your code to be implemented after changepassword
    [StaticMethods showAlertWithTitle:@"" message:@"Password will be sent to your email" delegate:nil cancelButtonTitle:@"OK" otherButtonTitle:nil];
    
}

 #pragma mark - Navigation
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     if ([segue.identifier isEqualToString:@"RegisterWithFacebook"])
     {
     RegisterViewController *registerVC= segue.destinationViewController;
     registerVC.isFacebookRegister=YES;
     }
 }


@end
