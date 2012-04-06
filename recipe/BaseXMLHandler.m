//
//  BaseXMLHandler.m
//  recipe
//
//  Created by SaRy on 4/6/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import "BaseXMLHandler.h"

@implementation BaseXMLHandler

#pragma mark private

#pragma mark NSObject
- (id)init {
	if (self = [super init]) {
		_parseError = nil;
		_stop = NO;
	}
	return self;
}

-(id) initObjectAfterElementStarting:(NSString*)elementName
{
	// abstract
	return nil;
}

-(void) afterElementStarting:(NSString*)elementName withAttributes:(NSDictionary *)attributeDict
{
	// abstract
}

-(void) afterElementEnding:(NSString*)elementName
{
	// abstract
}

#pragma mark NSXMLParserDelegate
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
	attributes:(NSDictionary *)attributeDict {
	
	if (_stop) return;
	id object = [self initObjectAfterElementStarting:elementName];
	
	if (object != nil) {	
		//for (NSString* key in attributeDict) {
		//	[object setValue:key forKey:[attributeDict objectForKey:key]];
		//}
		[self afterElementStarting:elementName withAttributes:attributeDict];
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if (!_chars) {
		_chars = [string mutableCopy];
	} else {
		[_chars appendString:string];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if (_stop) return;
	if ([elementName isEqualToString:[self getWrappedRootNode]]) {
		_stop = YES;
		return;
	}
	[self afterElementEnding:elementName];
    _chars = nil;
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)error {
	//_parseError = [error retain];
    _parseError = error;
    NSLog(@"error: %@", _parseError);
}

- (void) parserDidEndDocument:(NSXMLParser *)parser
{
	if (_target != nil) {
		[_target performSelector:_action];
	}
}

-(void) setEndDocumentTarget:(id)target andAction: (SEL)action
{
	_target = target;
	_action = action;
}

-(NSString*) getWrappedRootNode
{
	return @"";
}


@end
