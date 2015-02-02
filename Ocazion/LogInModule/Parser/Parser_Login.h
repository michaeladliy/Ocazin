//
//  Parser_Login.h
//  Kriss
//
//  Created by Mina Malak on 1/5/14.
//  Copyright (c) 2014 Mina Malak. All rights reserved.
//
#define BASEURL @"asdasdasdasdasdasdasdasdasdasdasdasda"

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "UserDS.h"

@interface Parser_Login : NSObject <NSXMLParserDelegate>
{
    NSString *currentNode ;
    NSXMLParser *parser ;
    BOOL connection ;
}
@property (nonatomic,retain) NSString *messageCode;
@property (nonatomic,retain) NSString *messageText;
@property (nonatomic,retain) UserDS *user;

-(BOOL) connectToURL;
-(id)loadParserWithUsername:(NSString *)userName password: (NSString *) password ;
-(void)parser :(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict ;
-(void)parser :(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName ;
-(void)parser :(NSXMLParser *)parser foundCharacters:(NSString *)string ;
@end
