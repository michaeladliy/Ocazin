//
//  UserDS.h
//  LogInModule
//
//  Created by Michael Adliy on 11/2/14.
//  Copyright (c) 2014 Michael Adliy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDS : NSObject
@property (strong,nonatomic) NSString *username;
@property (strong,nonatomic) NSString *userID;
@property (strong,nonatomic) NSString *email;
@property (strong,nonatomic) NSString *mobileNo;
@property (strong,nonatomic) NSString *imageURL;
@end
