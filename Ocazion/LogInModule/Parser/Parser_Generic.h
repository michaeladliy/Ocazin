//
//  Parser_Generic.h
//  Kriss
//
//  Created by Mina Malak on 1/6/14.
//  Copyright (c) 2014 Mina Malak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Parser_Generic : NSObject <NSXMLParserDelegate>
{
    NSString *currentNode ;
    NSXMLParser *parser ;
    BOOL connection ;
}
@property (nonatomic,retain) NSString *messageCode;
@property (nonatomic,retain) NSString *messageText;

-(BOOL) connectToURL;
-(id)loadParserWithURL:(NSString *)fullURL;
-(void)parser :(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict ;
-(void)parser :(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName ;
-(void)parser :(NSXMLParser *)parser foundCharacters:(NSString *)string ;
@end
