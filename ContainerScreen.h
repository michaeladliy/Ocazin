//
//  ContainerScreen.h
//  Ocazion
//
//  Created by Hazem Hamdy on 2/10/15.
//  Copyright (c) 2015 Hazem Hamdy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaperFoldView.h"
#import "TopScreen.h"
#import "HomeScreen.h"


@interface ContainerScreen : UIViewController <PaperFoldViewDelegate> {
    HomeScreen * homeScreen ;
    TopScreen * topScreen ;
}
@property (nonatomic, strong) PaperFoldView *paperFoldView ;
@end
