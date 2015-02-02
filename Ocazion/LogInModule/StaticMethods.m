//
//  StaticMethods.m
//  LogInModule
//
//  Created by Michael Adliy on 10/29/14.
//  Copyright (c) 2014 Michael Adliy. All rights reserved.
//

#import "StaticMethods.h"

@implementation StaticMethods
+(void)showAlertWithTitle :(NSString*)title message:(NSString*)message delegate:(id)delegate cancelButtonTitle:(NSString*)cancelTitle otherButtonTitle:(NSString *)otherTitle
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelTitle otherButtonTitles:otherTitle, nil];
    [alert show];
}

+(void)addLoadingView
{
    
}
+(void)removeLoadingView
{
    
}
@end
