//
//  Parser_Register.h
//  LogInModule
//
//  Created by Michael Adliy on 11/3/14.
//  Copyright (c) 2014 Michael Adliy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserDS.h"
@interface Parser_Register : NSObject<NSXMLParserDelegate>
{
    NSString *currentNode ;
    NSXMLParser *parser ;
    BOOL connection ;
}
@property (nonatomic,retain) NSString *messageCode;
@property (nonatomic,retain) NSString *messageText;
@property (nonatomic,retain) UserDS *user;

-(BOOL) connectToURL;
-(id)loadParserWithUsername:(NSString *)userName password:(NSString *)password email:(NSString*)email phoneNo:(NSString *)phoneNo imageString :(NSString *)imageString;
-(void)parser :(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict ;
-(void)parser :(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName ;
-(void)parser :(NSXMLParser *)parser foundCharacters:(NSString *)string ;
@end
