//
//  ContainerScreen.m
//  Ocazion
//
//  Created by Hazem Hamdy on 2/10/15.
//  Copyright (c) 2015 Hazem Hamdy. All rights reserved.
//

#import "ContainerScreen.h"


@interface ContainerScreen ()

@end

@implementation ContainerScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _paperFoldView = [[PaperFoldView alloc] initWithFrame:CGRectMake(0,0,[self.view bounds].size.width,[self.view bounds].size.height)];
    [_paperFoldView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    [self.view addSubview:_paperFoldView];
    
     UIStoryboard *mainSB=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    homeScreen = [mainSB instantiateViewControllerWithIdentifier:@"HomeScreen"];
    [_paperFoldView setCenterContentView:homeScreen.view];
    
    
    topScreen = [mainSB instantiateViewControllerWithIdentifier:@"TopScreen"];
    
     [_paperFoldView setTopFoldContentView:topScreen.view topViewFoldCount:2 topViewPullFactor:0.9];
    
    [_paperFoldView setDelegate:self];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)paperFoldView:(id)paperFoldView didFoldAutomatically:(BOOL)automated toState:(PaperFoldState)paperFoldState
{
    NSLog(@"did transition to state %i automated %i", paperFoldState, automated);
}


@end
