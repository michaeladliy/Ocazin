//
//  Parser_EditUser.m
//  LogInModule
//
//  Created by Michael Adliy on 11/5/14.
//  Copyright (c) 2014 Michael Adliy. All rights reserved.
//

#import "Parser_EditUser.h"
#import "Parser_Login.h"

@implementation Parser_EditUser
@synthesize user ;
@synthesize messageCode,messageText;

-(id)loadParserWithUser:(UserDS *)user
{
    currentNode = @"";
    
    // replace here with function
    NSString *fullURL = [NSString stringWithFormat:@"%@editUser?username=%@&password=%@&Phone=%@",BASEURL,user.username,user.mobileNo,user.email];
    
    fullURL = [fullURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",fullURL);
    NSURL * NSurl =[[NSURL alloc]initWithString:fullURL];
    parser =[[NSXMLParser alloc]initWithContentsOfURL:NSurl];
    [parser setDelegate:self];
    connection = [parser parse];
    return self;
}

-(BOOL) connectToURL
{
    return connection ;
}

- (void)parser :(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    if ([elementName isEqualToString:@"User"]) {
        user = [[UserDS alloc] init];
        user.userID = [attributeDict objectForKey:@"Id"];
        user.username = [attributeDict objectForKey:@"Name"];
        user.email = [attributeDict objectForKey:@"email"];
        user.mobileNo = [attributeDict objectForKey:@"mobileNo"];
        user.imageURL = [attributeDict objectForKey:@"imageURL"];
    }
    if ([elementName isEqualToString:@"Message"]) {
        messageCode = [attributeDict objectForKey:@"Code"];
        messageText = [attributeDict objectForKey:@"Text"];
    }
    currentNode = @"";
}

- (void)parser :(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if ([elementName isEqualToString:@"User"]) {
        // do what ever u want
    }
    currentNode = @"";
}

- (void)parser :(NSXMLParser *)parser foundCharacters:(NSString *)string {
    //    currentNode = [NSMutableString stringWithString:string];
    currentNode = [[NSString alloc]initWithFormat:@"%@%@",currentNode , string];
}
@end
