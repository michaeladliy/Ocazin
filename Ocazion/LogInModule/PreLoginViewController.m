//
//  PreLoginViewController.m
//  Ocazion
//
//  Created by Hazem Hamdy on 2/9/15.
//  Copyright (c) 2015 Hazem Hamdy. All rights reserved.
//

#import "PreLoginViewController.h"
#import "RegisterViewController.h"
#import "StaticMethods.h"


@interface PreLoginViewController ()

@end

@implementation PreLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)skipToHome:(id)sender {
    [StaticMethods skipLoginToHomeFromNavigation:self.navigationController];
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
