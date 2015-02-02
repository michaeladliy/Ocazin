//
//  UITextField+PaddingTextFiled.m
//  InShop
//
//  Created by Hazem Hamdy on 6/16/14.
//  Copyright (c) 2014 InnovationWaves. All rights reserved.
//

#import "UITextField+PaddingTextFiled.h"

@implementation UITextField (PaddingTextFiled)

-(UITextField*)addPaddingToTextField:(UITextField*)myTextField;
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 9, 20)];
    myTextField.leftView = paddingView;
    myTextField.leftViewMode = UITextFieldViewModeAlways;
    return myTextField;
}

@end
