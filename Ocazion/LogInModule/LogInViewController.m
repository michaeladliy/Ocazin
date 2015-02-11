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
#import "ContainerScreen.h"

@interface LogInViewController ()<ParserLoginDelegate>
{
    Parser_Login  *loginParser;
}
@end

@implementation LogInViewController
@synthesize passwordTxtField,usernameTxtField,logInBtn,forgetPasswordBtn;
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
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [self.view endEditing:YES];
//}


// IBActions
- (IBAction)skipToHome:(id)sender {
    [StaticMethods skipLoginToHomeFromNavigation:self.navigationController];
}
- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

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
    [validate Required:usernameTxtField.text FieldName:@"Email"];
    [validate Email:usernameTxtField.text FieldName:@"Email"];
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
    
    
    [validate Required:usernameTxtField.text FieldName:@"Email"];
    [validate Email:usernameTxtField.text FieldName:@"Email"];
    
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
    loginParser = [[Parser_Login alloc]init];
    [loginParser loadParserWithUsername:usernameTxtField.text password:passwordTxtField.text];
    loginParser.delegate=self;
}

// delegate methods for login
-(void)loginParserDidFinishSuccessfullyWithUser:(UserDS *)user andMessage:(NSString *)messageCode
{
    if (user)
    {
        //succes with user
        UIStoryboard *mainSB =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ContainerScreen *containerScreen = [mainSB instantiateViewControllerWithIdentifier:@"ContainerScreen"];
//        [self presentViewController:containerScreen animated:YES completion:nil];
        [self.navigationController pushViewController:containerScreen animated:YES];
        
    }else
    {
        // SHOW ERROR MESSAGE
    [StaticMethods showAlertWithTitle:@"" message:messageCode delegate:nil cancelButtonTitle:@"OK" otherButtonTitle:nil];
        
    }
    [StaticMethods removeLoadingView];
}
-(void)loginParserDidFinishWithValidationError:(NSArray *)validationErorrs
{
    NSString *allErrors = @"";
    for (NSString *erorr in validationErorrs) {
        allErrors= [allErrors stringByAppendingString:erorr];
        allErrors= [allErrors stringByAppendingString:@"\n"];
    }
    NSLog(@"%@",allErrors);
    [StaticMethods showAlertWithTitle:@"" message:allErrors delegate:nil cancelButtonTitle:@"OK" otherButtonTitle:nil];
     [StaticMethods removeLoadingView];
}

-(void)loginParserDidFinishWithError:(NSError *)connectionError
{
    [StaticMethods showAlertWithTitle:@"" message:@"Connection Erorr" delegate:nil cancelButtonTitle:@"OK" otherButtonTitle:nil];
    [StaticMethods removeLoadingView];
}


// forget password handle
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


-(void)forgetPasswordParserDidFinishWithSuccess
{
    // write here your code to be implemented after changepassword
    [StaticMethods showAlertWithTitle:@"" message:@"Password will be sent to your email" delegate:nil cancelButtonTitle:@"OK" otherButtonTitle:nil];
    
}


@end
