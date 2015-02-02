//
//  StaticMethods.h
//  LogInModule
//
//  Created by Michael Adliy on 10/29/14.
//  Copyright (c) 2014 Michael Adliy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface StaticMethods : NSObject
+(void)showAlertWithTitle :(NSString*)title message:(NSString*)message delegate:(id)delegate cancelButtonTitle:(NSString*)cancelTitle otherButtonTitle:(NSString *)otherTitle;
+(void)addLoadingView;
+(void)removeLoadingView;
@end
