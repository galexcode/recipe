//
//  EntriesXMLHandler.m
//  MyFruitsDiary
//
//  Created by Khoi Pham on 3/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EntriesXMLHandler.h"


@implementation EntriesXMLHandler
-(id) initWithEntriesList:(NSMutableArray*)entriesList andFruitList:(NSMutableArray*)fruitList
{
	if (self = [super init]) {
		_entriesList = entriesList;
		_fruitList = fruitList;
	}
	return self;
}
-(void) dealloc
{
	
	[super dealloc];
}

-(Fruit*) searchForFruitByType:(NSString*) type
{
	for (Fruit* fr in _fruitList) {
		if ([fr.type isEqualToString:type]) {
			return fr;
		}
	}
	return nil;
}
-(id) initObjectAfterElementStarting:(NSString*)elementName
{
	if ([elementName isEqualToString:@"entry"]) {
		_currentEntry = [[Entry alloc] init];
		return _currentEntry;
	} else if ([elementName isEqualToString:@"fruit"]) {
		_currentFruitBag = [[FruitBag alloc] init];
		return _currentFruitBag;
	}
	return nil;
}
-(void) afterElementStarting:(NSString*)elementName withAttributes:(NSDictionary *)attributeDict
{
	if ([elementName isEqualToString:@"entry"]) {
		_currentEntry.entryId = [attributeDict objectForKey:@"id"];
		[_currentEntry setDateByString:[attributeDict objectForKey:@"date"] withFormat:@"yyyyMMdd"];
				
	} else if ([elementName isEqualToString:@"fruit"]) {
		Fruit* fr = [self searchForFruitByType:[attributeDict objectForKey:@"type"]];
		if (fr != nil) {
			_currentFruitBag.fruit = fr;
			_currentFruitBag.count = [[attributeDict objectForKey:@"count"] intValue];
		}		
	}
}
-(void) afterElementEnding:(NSString*)elementName
{
	if ([elementName isEqualToString:@"entry"]) {
		[_entriesList addObject:_currentEntry];
		[_currentEntry release];
		_currentEntry = nil;
		
	} else if ([elementName isEqualToString:@"fruit"]) {
		[_currentEntry.fruitBags addObject:_currentFruitBag];
		[_currentFruitBag release];
		_currentFruitBag = nil;
	}
}

-(NSString*) getWrappedRootNode
{
	return @"entries";
}
@end
