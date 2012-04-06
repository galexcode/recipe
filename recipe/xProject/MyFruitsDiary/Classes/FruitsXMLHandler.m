//
//  FruitsXMLHandler.m
//  MyFruitsDiary
//
//  Created by Khoi Pham on 3/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FruitsXMLHandler.h"


@implementation FruitsXMLHandler

-(id) initWithFruitList:(NSMutableArray*)fruitList
{
	if (self = [super init]) {
		_fruitList = fruitList;
	}
	return self;
}
-(void) dealloc
{
	
	[super dealloc];
}

-(id) initObjectAfterElementStarting:(NSString*)elementName
{
	if ([elementName isEqualToString:@"fruit"]) {
		_currentObject = [[Fruit alloc] init];
		return _currentObject;
	}
	return nil;
}
-(void) afterElementStarting:(NSString*)elementName withAttributes:(NSDictionary *)attributeDict
{
	_currentObject.fruitId = [attributeDict objectForKey:@"id"];
	_currentObject.vitamins = [[attributeDict objectForKey:@"vitamins"] intValue];
	_currentObject.type = [attributeDict objectForKey:@"type"];
	_currentObject.name = [attributeDict objectForKey:@"name"];
	_currentObject.imageURL = [attributeDict objectForKey:@"image"];
}
-(void) afterElementEnding:(NSString*)elementName
{
	if ([elementName isEqualToString:@"fruit"]) {
		[_fruitList addObject:_currentObject];
		[_currentObject release];
		_currentObject = nil;
	}
}
-(NSString*) getWrappedRootNode
{
	return @"fruits";
}
@end
