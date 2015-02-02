//
//  RegisterViewController.m
//  LogInModule
//
//  Created by Michael Adliy on 10/29/14.
//  Copyright (c) 2014 Michael Adliy. All rights reserved.
//

#import "RegisterViewController.h"
#import "UITextField+PaddingTextFiled.h"

#import "StaticMethods.h"
#import "validation.h"

#import "Parser_Register.h"
#import "UserDS.h"


@interface RegisterViewController ()<FBLoginViewDelegate>
{
    BOOL hasSelectImage;
}
@end

@implementation RegisterViewController
@synthesize usernameTxtField,passwordTxtField,confirmPasswordTxtField,phoneNoTxtField,emailTxtField,submitBtn,isFacebookRegister,addPhotoBtn,mainScroll;
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
    hasSelectImage=NO;
    
    if (isFacebookRegister) {
        // load data from facebook and fill data
        [self loadDataFromFaceBook];
        
    }else
    {
        //setup ui without facebook
        [addPhotoBtn setImage:[UIImage imageNamed:@"addPhotoBtnImage.png"] forState:UIControlStateNormal];
        [addPhotoBtn setImage:[UIImage imageNamed:@"addPhotoBtnImage.png"] forState:UIControlStateHighlighted];
    }
    [self setupUI];
    
}
- (void)setupUI
{
    // add padding to textfields
    passwordTxtField =[passwordTxtField addPaddingToTextField:passwordTxtField];
    usernameTxtField =[usernameTxtField addPaddingToTextField:usernameTxtField];
    emailTxtField =[emailTxtField addPaddingToTextField:emailTxtField];
    phoneNoTxtField =[phoneNoTxtField addPaddingToTextField:phoneNoTxtField];
    confirmPasswordTxtField =[confirmPasswordTxtField addPaddingToTextField:confirmPasswordTxtField];
    
    // set content size for scroll View
    mainScroll.contentSize=CGSizeMake(320, 520);
}
//IBActions
- (IBAction)registerAction:(id)sender {
    if ([self validateInputData]) {
        [StaticMethods addLoadingView];
        [self LoadRegiesterParser];
    }
}

-(IBAction)addPhotoAction
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

-(BOOL)validateInputData
{
    // reminde validation for image
    validation *validate=[[validation alloc] init];
    
    [validate Required:usernameTxtField.text FieldName:@"Username"];
    [validate Required:passwordTxtField.text FieldName:@"Password"];
    [validate Required:phoneNoTxtField.text FieldName:@"phone no"];
    [validate Required:emailTxtField.text FieldName:@"email"];
    [validate Required:confirmPasswordTxtField.text FieldName:@"confirm password"];
    
    [validate Email:emailTxtField.text FieldName:@"email"];
    
    if([validate isValid] == TRUE&&[passwordTxtField.text isEqualToString:confirmPasswordTxtField.text]&&hasSelectImage){
        return YES;
    }else if([validate isValid] == FALSE){
        [StaticMethods showAlertWithTitle:@"Validation error" message:validate.errorMsg[0] delegate:nil cancelButtonTitle:@"OK" otherButtonTitle:nil];
        return NO;
    }else if (!hasSelectImage)
    {
        [StaticMethods showAlertWithTitle:@"Validation error" message:@"You didn't select your image" delegate:nil cancelButtonTitle:@"OK" otherButtonTitle:nil];
        return NO;
    }else
    {
        [StaticMethods showAlertWithTitle:@"Validation error" message:@"passwords don't match" delegate:nil cancelButtonTitle:@"OK" otherButtonTitle:nil];
    return NO;
    }
    
    return YES;
}

-(void)LoadRegiesterParser
{
    UIImage *selectedImage= [addPhotoBtn currentImage];
    NSData *imageData = UIImageJPEGRepresentation(selectedImage, 1.0);
    NSString *encodedString =[imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *imageString =[encodedString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    Parser_Register *registerParser = [[Parser_Register alloc]init];
    [registerParser loadParserWithUsername:usernameTxtField.text password:passwordTxtField.text email:emailTxtField.text phoneNo:phoneNoTxtField.text imageString:imageString];
    
    if ([registerParser connectToURL]) {
        // Done
        if ([registerParser.messageCode isEqualToString:@"200"]) {
            [self parserDidFinishWithSuccessWithUser:registerParser.user];
            // Move to Home Screen
            //            [[MyPList alloc]write:@"UserID" value:[[objectLogin.arrLogin objectAtIndex:0] stLoginID]];
            //            [[MyPList alloc]write:@"UserName" value:txtUsername.text];
            //            [[MyPList alloc]write:@"firstTime" value:@"NO"];
            //            HomeScreenView *home = [[HomeScreenView alloc]initWithNibName:@"HomeScreenView" bundle:nil];
            //            [self.navigationController pushViewController:home animated:YES];
        }
        else {
            // Not Right Result
            [StaticMethods showAlertWithTitle:@"" message:registerParser.messageText delegate:nil cancelButtonTitle:@"OK" otherButtonTitle:nil ];
        }
    }
    else {
        // Error in connection
        [StaticMethods showAlertWithTitle:@"" message:@"Connection error" delegate:nil cancelButtonTitle:@"OK" otherButtonTitle:nil ];
    }
    [StaticMethods removeLoadingView];
    
}

// image picker delegate methods
- (void) imagePickerControllerDidCancel:(UIImagePickerController *) picker {
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

- (void)imagePickerController : (UIImagePickerController *) picker didFinishPickingImage:(UIImage *)imageProfile editingInfo:(NSDictionary *) editingInfo
{
    hasSelectImage=YES;
    [picker dismissViewControllerAnimated:YES completion:^{}];
    [addPhotoBtn setImage:imageProfile forState:UIControlStateNormal];
    [addPhotoBtn setImage:imageProfile forState:UIControlStateHighlighted];
    
    
}

/// load data from facebook
- (void)loadDataFromFaceBook {
    
    FBLoginView *loginview = [[FBLoginView alloc] init];
    loginview.frame = CGRectOffset(loginview.frame, 5, 5);
    loginview.delegate = self;
    [loginview sizeToFit];
    // FBSample logic
    // if the session is open, then load the data for our view controller
    if (!FBSession.activeSession.isOpen) {
        // if the session is closed, then we open it here, and establish a handler for state changes
        
        NSArray *permissions = [NSArray arrayWithObjects:@"user_photos",@"email",nil];
        [FBSession openActiveSessionWithReadPermissions:permissions allowLoginUI:YES completionHandler:
         ^(FBSession *session, FBSessionState state, NSError *error) {
             if (error) {
                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:error. localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                 [alertView show];
             }
         }];
    }
    
    [[FBRequest requestForMe] startWithCompletionHandler: ^(FBRequestConnection *connection,
                                                            NSDictionary<FBGraphUser> *user,
                                                            NSError *error) { if (!error) {
        
        hasSelectImage=YES;
        usernameTxtField.text = user.name;
        emailTxtField.text=[user objectForKey:@"email"];
        [addPhotoBtn setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large",user.objectID]]]] forState:UIControlStateNormal];
        [addPhotoBtn setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large",user.objectID]]]] forState:UIControlStateHighlighted];
        
        
    }
    }];
}

-(void)parserDidFinishWithSuccessWithUser:(UserDS *)user
{
    // write here your code to be implemented after login
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
