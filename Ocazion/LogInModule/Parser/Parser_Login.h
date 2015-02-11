//
//  Parser_Login.h
//  Kriss
//
//  Created by Mina Malak on 1/5/14.
//  Copyright (c) 2014 Mina Malak. All rights reserved.
//
#define BASEURL @"http://mahmoudnaguib.com/clients/ocazion/api/"

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "UserDS.h"

@protocol ParserLoginDelegate <NSObject>

-(void)loginParserDidFinishSuccessfullyWithUser:(UserDS *)user andMessage:(NSString *)messageCode;
-(void)loginParserDidFinishWithValidationError:(NSArray*)validationErorrs;
-(void)loginParserDidFinishWithError:(NSError *)connectionError;

@end
@interface Parser_Login : NSObject
@property (weak) id delegate;
@property (nonatomic,retain) NSString *messageCode;
@property (nonatomic,retain) NSString *messageText;
@property (nonatomic,retain) UserDS *user;


-(id)loadParserWithUsername:(NSString *)userName password: (NSString *) password ;

@end
