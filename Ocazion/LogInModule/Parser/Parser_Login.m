//
//  Parser_Login.m
//  Kriss
//
//  Created by Mina Malak on 1/5/14.
//  Copyright (c) 2014 Mina Malak. All rights reserved.
//

#import "Parser_Login.h"

@implementation Parser_Login
@synthesize user ;
@synthesize messageCode,messageText;

-(id)loadParserWithUsername:(NSString *)userName password: (NSString *) password 
{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@users/login",BASEURL]];
    
    NSString *body =  [NSString stringWithFormat:@"email=%@&password=%@",userName,password];
    
    NSMutableURLRequest *rq = [NSMutableURLRequest requestWithURL:url];
    [rq setHTTPMethod:@"POST"];
    [rq setTimeoutInterval:30.0f];
    [rq setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:rq queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        // call delegate method here
        if (!connectionError) {
            NSLog(@"%@",response);
            NSError* error;
            NSDictionary* json = [NSJSONSerialization
                                  JSONObjectWithData:data
                                  
                                  options:kNilOptions
                                  error:&error];
            
            
            NSLog(@"done");
            NSLog(@"json rage3 %@",json);
            int statusCode = [(NSHTTPURLResponse *)response statusCode] ;
            [self parseJsonDic:json statusCode:statusCode];
        }
        else
        {
            if ([self.delegate respondsToSelector:@selector(loginParserDidFinishWithError:)]) {
                [self.delegate loginParserDidFinishWithError:connectionError];
            }
        }
        
    }];

    return self;
}


-(void)parseJsonDic :(NSDictionary *)json statusCode:(int)statusCode
{
    NSLog(@"%@",json);
    messageText = [json objectForKey:@"message"];
    
    if (statusCode == 200) {
        // done successfully
        user = [[UserDS alloc]init];
        user.token= [json objectForKey:@"token"];
        
        if ([self.delegate respondsToSelector:@selector(loginParserDidFinishSuccessfullyWithUser:andMessage:)])
        {
            [self.delegate loginParserDidFinishSuccessfullyWithUser:user andMessage:messageText];
        }
    }else if(statusCode == 422)
    {
        NSArray *erorrs = [json valueForKey:@"errors"];
        // validation erorr
        if ([self.delegate respondsToSelector:@selector(loginParserDidFinishWithValidationError:)])
        {
            [self.delegate loginParserDidFinishWithValidationError:erorrs];
        }
    }
    else
    {
        //erorr
        
        if ([self.delegate respondsToSelector:@selector(loginParserDidFinishSuccessfullyWithUser:andMessage:)])
        {
            [self.delegate loginParserDidFinishSuccessfullyWithUser:nil andMessage:messageText];
        }
    }

}


@end
