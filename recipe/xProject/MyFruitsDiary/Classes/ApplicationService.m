//
//  ApplicationService.m
//  MyFruitsDiary
//
//  Created by Khoi Pham on 3/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ApplicationService.h"
#import "MyFruitsDiaryGlobal.h"
#import "FruitsXMLHandler.h"
#import "EntriesXMLHandler.h"

@implementation ApplicationService

-(id) init
{
	if (self = [super init]) {
		_fruitList = [[NSMutableArray alloc] init];
		_entries = [[NSMutableArray alloc] init];
	} 
	return self;	
}

-(NSMutableArray*) fruitList
{
	return _fruitList;
}

-(NSMutableArray*) entries
{
	return _entries;
}
#pragma mark -
#pragma mark addEntry
-(void) addEntry: (Entry*)entry
{
	[[NSNotificationCenter defaultCenter] postNotificationName: HTTP_REQUEST_STARTING_NOTIFICATION 
														object:nil];
	
	HttpRequest* req = [[HttpRequest alloc] initWithFinishTarget:self 
													   andAction:@selector(finishAddingEntry: byRequest:)];
	req.transientObject = [entry retain];
	[req call:ADD_ENTRY_URL params:[NSDictionary dictionaryWithObject:[entry dateByStringWithFormat:@"yyyyMMdd"]
															   forKey:@"date"]];
	[req release];
}
-(void) finishAddingEntry:(NSData*)data byRequest:(HttpRequest*)req
{
	NSLog(@"DATA: %s", data.bytes);
	// Check if returned id existed
	NSString* entryId = [NSString stringWithCharacters:[data bytes] length:[data length]];
	BOOL notExisted = YES;
	for (Entry* e in _entries) {
		if ([entryId isEqualToString:e.entryId]) {
			notExisted = NO;
		}
	}
	
	if (notExisted) {
		Entry* entry = (Entry*)req.transientObject;
		entry.entryId = entryId;
		[_entries addObject:entry];
		[req.transientObject release];
		req.transientObject = nil;
	}	
	[[NSNotificationCenter defaultCenter] postNotificationName: HTTP_REQUEST_FINISHING_NOTIFICATION
														object:nil];
	[[NSNotificationCenter defaultCenter] postNotificationName: RELOAD_DATA_NOTIFICATION
														object:nil];
}
#pragma mark -
#pragma mark removeEntry
-(void) removeEntry: (Entry*)entry
{
	[[NSNotificationCenter defaultCenter] postNotificationName: HTTP_REQUEST_STARTING_NOTIFICATION 
														object:nil];
	
	HttpRequest* req = [[HttpRequest alloc] initWithFinishTarget:self 
													   andAction:@selector(finishRemovingEntry: byRequest:)];
	req.transientObject = entry;
	[req call:REMOVE_ENTRY_URL params:[NSDictionary dictionaryWithObject:[entry entryId]
																  forKey:@"id"]];
	[req release];
		
}
-(void) finishRemovingEntry:(NSData*)data byRequest:(HttpRequest*)req
{
	NSLog(@"DATA: %s", data.bytes);
	[_entries removeObject:req.transientObject];
	req.transientObject = nil;
	
	[[NSNotificationCenter defaultCenter] postNotificationName: HTTP_REQUEST_FINISHING_NOTIFICATION
														object:nil];
	[[NSNotificationCenter defaultCenter] postNotificationName: RELOAD_DATA_NOTIFICATION
														object:nil];
}
#pragma mark -
#pragma mark addFruitBag
-(void) addOrEditFruitBag:(FruitBag*)fruitbag toEntry:(Entry*)entry
{
	[[NSNotificationCenter defaultCenter] postNotificationName: HTTP_REQUEST_STARTING_NOTIFICATION 
														object:nil];
	if (![entry.fruitBags containsObject:fruitbag]) {
		[entry.fruitBags addObject:fruitbag];
	}
	
	HttpRequest* req = [[HttpRequest alloc] initWithFinishTarget:self 
													   andAction:@selector(finishAddingFruitBag: byRequest:)];
	//req.transientObject = [NSArray arrayWithObjects:fruitbag, entry];
	NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithObject:entry.entryId forKey:@"entryid"];
	[dict setValue:fruitbag.fruit.type forKey:@"type"];
	[dict setValue:[NSString stringWithFormat:@"%d",fruitbag.count] forKey:@"count"];
	[req call:SET_FRUIT_URL params:dict];
	
	[req release];
}
-(void) finishAddingFruitBag:(NSData*)data byRequest:(HttpRequest*)req
{
	NSLog(@"DATA: %s", data.bytes);
	[[NSNotificationCenter defaultCenter] postNotificationName: HTTP_REQUEST_FINISHING_NOTIFICATION
														object:nil];
	[[NSNotificationCenter defaultCenter] postNotificationName: RELOAD_DATA_NOTIFICATION
														object:nil];
}
#pragma mark -
#pragma mark removeFruitBag
-(void) removeFruitBag:(FruitBag*)fruitBag fromEntry:(Entry*)entry
{
	[entry.fruitBags removeObject:fruitBag];
	
	// No backend
	[self finishRemovingEntry:nil byRequest:nil];
}
-(void) finishRemovingFruitBag:(NSData*)data byRequest:(HttpRequest*)req
{
	[[NSNotificationCenter defaultCenter] postNotificationName: RELOAD_DATA_NOTIFICATION
														object:nil];

}
#pragma mark -
#pragma mark loadEntries
-(void) loadEntries
{
	HttpRequest* req = [[HttpRequest alloc] initWithFinishTarget:self 
													   andAction:@selector(gotEntries: byRequest:)];
	[req call:ENTRIES_URL params:[NSDictionary dictionary]];
	[req release];
}
-(void)gotEntries: (NSData*)data byRequest:(HttpRequest*)req
{
	NSLog(@"entries: %s", data.bytes);
	EntriesXMLHandler* handler = [[EntriesXMLHandler alloc] initWithEntriesList:_entries andFruitList:_fruitList];
	[handler setEndDocumentTarget:self andAction:@selector(didParsedEntries)];
	NSXMLParser* parser = [[[NSXMLParser alloc] initWithData:data] autorelease];
	parser.delegate = handler;
	[parser parse];
	[handler release];
}
-(void) didParsedEntries
{
	[[NSNotificationCenter defaultCenter] postNotificationName: HTTP_REQUEST_FINISHING_NOTIFICATION 
														object:nil];
}
#pragma mark -
#pragma mark loadAllData
-(void) loadAllData
{
	[[NSNotificationCenter defaultCenter] postNotificationName: HTTP_REQUEST_STARTING_NOTIFICATION 
														object:nil];
	
	HttpRequest* req = [[HttpRequest alloc] initWithFinishTarget:self 
													   andAction:@selector(gotFruits: byRequest:)];
	[req call:FRUITS_URL params:[NSDictionary dictionary]];
	[req release];
}

-(void)gotFruits: (NSData*)data byRequest:(HttpRequest*)req
{
	NSLog(@"fruits: %s", data.bytes);
	FruitsXMLHandler* handler = [[FruitsXMLHandler alloc] initWithFruitList:_fruitList];
	NSXMLParser* parser = [[[NSXMLParser alloc] initWithData:data] autorelease];
	[handler setEndDocumentTarget:self andAction:@selector(didParsedFruits)];
	parser.delegate = handler;
	[parser parse];
	[handler release];
}	

-(void) didParsedFruits
{
	[self loadEntries];
	for (Fruit* fr in _fruitList) {
		[self loadFruitImage:fr];
	}
}
#pragma mark -
#pragma mark loadFruitImage
-(void) loadFruitImage: (Fruit*) fruit
{
	// TODO Cache, store & load file 
	HttpRequest* req = [[HttpRequest alloc] initWithFinishTarget:self 
													   andAction:@selector(finishLoadingFruiImage: byRequest:)];
	req.transientObject = fruit;
	NSString* fullUrl = [NSString stringWithFormat:@"%@%@", BASE_URL, fruit.imageURL];
	[req call:fullUrl params:[NSDictionary dictionary]];
	[req release];
}
-(void) finishLoadingFruiImage:(NSData*)data byRequest:(HttpRequest*)req
{
	Fruit* fr = (Fruit*)req.transientObject;
	fr.image = data;
	
	req.transientObject = nil;
	[[NSNotificationCenter defaultCenter] postNotificationName: RELOAD_DATA_NOTIFICATION 
														object:nil];
}
@end
