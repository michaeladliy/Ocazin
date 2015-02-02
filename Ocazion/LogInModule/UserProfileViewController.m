//
//  UserProfileViewController.m
//  LogInModule
//
//  Created by Michael Adliy on 10/29/14.
//  Copyright (c) 2014 Michael Adliy. All rights reserved.
//

#import "UserProfileViewController.h"
#import "validation.h"
#import "StaticMethods.h"
#import "UITextField+PaddingTextFiled.h"
#import "UserDS.h"
#import "Parser_EditUser.h"

@interface UserProfileViewController ()
@property (nonatomic,strong) UserDS *user;
@end

@implementation UserProfileViewController
@synthesize emailTxtField,usernameTxtField,phoneNoTxtField;
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
    [self setupUI];
    [self loadUserData];
}

-(void)setupUI
{
    usernameTxtField =[usernameTxtField addPaddingToTextField:usernameTxtField];
    emailTxtField =[emailTxtField addPaddingToTextField:emailTxtField];
    phoneNoTxtField =[phoneNoTxtField addPaddingToTextField:phoneNoTxtField];
}
-(void)loadUserData
{
     // reade data from local storage and set outlets with it
    
}

- (IBAction)doneWithCancel:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)doneWithSave:(id)sender {
    // validate input data and then call user edit parser
    if ([self validateInputData]) {
        UserDS *user = [[UserDS alloc]init];
        [self loadEditUserPasswordWithUser:user];
    }
}

-(BOOL)validateInputData
{
    if ([self validateInputData])
    {
        // reminde validation for image
        validation *validate=[[validation alloc] init];
        
        [validate Required:usernameTxtField.text FieldName:@"Username"];
        [validate Required:phoneNoTxtField.text FieldName:@"phone no"];
        [validate Required:emailTxtField.text FieldName:@"email"];
        
        [validate Email:emailTxtField.text FieldName:@"email"];
        
        if([validate isValid] == TRUE){
            return YES;
        }else{
            
            [StaticMethods showAlertWithTitle:@"Validation error" message:validate.errorMsg[0] delegate:nil cancelButtonTitle:@"OK" otherButtonTitle:nil];
            return NO;
        }
        
    }

    return YES;
}

-(void)loadEditUserPasswordWithUser:(UserDS*)user
{
    Parser_EditUser *editUserParser = [[Parser_EditUser alloc]init];
    [editUserParser loadParserWithUser:user];
    
    if ([editUserParser connectToURL]) {
        // Done
        if ([editUserParser.messageCode isEqualToString:@"200"]) {
            [self editUserParserDidFinishWithSuccessWithUser:editUserParser.user];
        }
        else {
            // Not Right Result
            [StaticMethods showAlertWithTitle:@"" message:editUserParser.messageText delegate:nil cancelButtonTitle:@"OK" otherButtonTitle:nil ];
        }
    }
    else {
        // Error in connection
        [StaticMethods showAlertWithTitle:@"" message:@"Connection error" delegate:nil cancelButtonTitle:@"OK" otherButtonTitle:nil ];
    }
    [StaticMethods removeLoadingView];
    
}
-(void)editUserParserDidFinishWithSuccessWithUser:(UserDS*)user
{
    // type your code here
    
    // add user data to SQLite 
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
