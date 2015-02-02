//
//  Parser_Generic.m
//  Kriss
//
//  Created by Mina Malak on 1/6/14.
//  Copyright (c) 2014 Mina Malak. All rights reserved.
//

#import "Parser_Generic.h"

@implementation Parser_Generic
@synthesize messageCode,messageText;

-(id)loadParserWithURL:(NSString *)fullURL
{
    currentNode = @"";
    fullURL = [fullURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@">>>>> %@",fullURL);
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
    if ([elementName isEqualToString:@"Message"]) {
        messageCode = [attributeDict objectForKey:@"Code"];
        messageText = [attributeDict objectForKey:@"Text"];
    }
    currentNode = @"";
}

- (void)parser :(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    currentNode = @"";
}

- (void)parser :(NSXMLParser *)parser foundCharacters:(NSString *)string {
    //    currentNode = [NSMutableString stringWithString:string];
    currentNode = [[NSString alloc]initWithFormat:@"%@%@",currentNode , string];
}


@end
