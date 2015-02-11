//
//  Parser_Register.m
//  LogInModule
//
//  Created by Michael Adliy on 11/3/14.
//  Copyright (c) 2014 Michael Adliy. All rights reserved.
//

#import "Parser_Register.h"
#import "Parser_Login.h"

@implementation Parser_Register
@synthesize user;
@synthesize messageCode,messageText;

-(id)loadParserWithFirstName:(NSString *)firstName userName:(NSString*)userName password:(NSString *)password email:(NSString*)email phoneNo:(NSString *)phoneNo imageString :(NSString *)imageString
{
    NSURL *url = [NSURL URLWithString:@"http://mahmoudnaguib.com/clients/ocazion/api/users/register"];
    NSString *body =  [NSString stringWithFormat:@"first_name=%@&last_name=%@&email=%@&password=%@&phone=%@&main_image=%@",userName,userName,email,password,phoneNo,imageString];
    
    NSLog(@"striung body %@",body);
    
    NSMutableURLRequest *rq = [NSMutableURLRequest requestWithURL:url];
    [rq setHTTPMethod:@"POST"];
    [rq setTimeoutInterval:30.0f];
    [rq setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];

    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:rq queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        // call delegate method here
        if (!connectionError) {
            
        
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
            if ([self.delegate respondsToSelector:@selector(registerParserDidFinishWithError:)]) {
                [self.delegate registerParserDidFinishWithError:connectionError];
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
        
        if ([self.delegate respondsToSelector:@selector(registerParserDidFinishSuccessfullyWithUser:andMessage:)])
        {
            [self.delegate registerParserDidFinishSuccessfullyWithUser:user andMessage:messageText];
        }
    }else if(statusCode == 422)
    {
        NSArray *erorrs = [json valueForKey:@"errors"];
        // validation erorr
        if ([self.delegate respondsToSelector:@selector(registerParserDidFinishWithValidationError:)])
        {
            [self.delegate registerParserDidFinishWithValidationError:erorrs];
        }
    }
    else
    {
        //erorr
        
        if ([self.delegate respondsToSelector:@selector(registerParserDidFinishSuccessfullyWithUser:andMessage:)])
        {
            [self.delegate registerParserDidFinishSuccessfullyWithUser:nil andMessage:messageText];
        }
    }

}


@end
