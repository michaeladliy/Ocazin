//
//  SplashViewController.m
//  Ocazion
//
//  Created by Hazem Hamdy on 1/29/15.
//  Copyright (c) 2015 Hazem Hamdy. All rights reserved.
//

#import "SplashViewController.h"
#import "LogInViewController.h"

@interface SplashViewController ()
{
    int percentageValue;
}
@property (weak, nonatomic) IBOutlet UILabel *valueLbl;

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    percentageValue=0;
    // Do any additional setup after loading the view.
    [self performSelector:@selector(moveToLogin) withObject:nil afterDelay:5];
    [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(incrementPercentageValue) userInfo:nil repeats:YES];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)moveToLogin
{
    UIStoryboard *loginStoryboard=[UIStoryboard storyboardWithName:@"LogInModule" bundle:nil];
    UINavigationController *loginNav = [loginStoryboard instantiateViewControllerWithIdentifier:@"LoginNavigationController"];
    //LogInViewController *loginVC = [loginStoryboard instantiateViewControllerWithIdentifier:@"LogInViewController"];
    [self presentViewController:loginNav animated:YES completion:nil];
    
}
-(void)incrementPercentageValue
{
    if (percentageValue<=100) {
        self.valueLbl.text=[NSString stringWithFormat:@"%d",percentageValue];
        percentageValue++;
    }
   
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
