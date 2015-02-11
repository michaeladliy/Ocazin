//
//  Parser_Register.h
//  LogInModule
//
//  Created by Michael Adliy on 11/3/14.
//  Copyright (c) 2014 Michael Adliy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserDS.h"

@protocol ParserRegisterDelegate <NSObject>

-(void)registerParserDidFinishSuccessfullyWithUser:(UserDS *)user andMessage:(NSString *)messageCode;
-(void)registerParserDidFinishWithValidationError:(NSArray*)validationErorrs;
-(void)registerParserDidFinishWithError:(NSError *)connectionError;

@end

@interface Parser_Register : NSObject
@property (weak) id delegate;
@property (nonatomic,retain) NSString *messageCode;
@property (nonatomic,retain) NSString *messageText;
@property (nonatomic,retain) UserDS *user;

-(id)loadParserWithFirstName:(NSString *)firstName lastName:(NSString*)lastName password:(NSString *)password email:(NSString*)email phoneNo:(NSString *)phoneNo imageString :(NSString *)imageString;

@end
