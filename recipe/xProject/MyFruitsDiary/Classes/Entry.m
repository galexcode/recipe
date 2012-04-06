//
//  Entry.m
//  MyFruitsDiary
//
//  Created by Khoi Pham on 3/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Entry.h"
#import "FruitBag.h"

@implementation Entry

@synthesize entryId = _entryId;
@synthesize date = _date;
@synthesize fruitBags = _fruitBags;

-(id) init
{
	if (self = [super init]) {
		_entryId = nil;
		_date = nil;
		_fruitBags = [[NSMutableArray alloc] init];
	}
	return self;
}
-(id) initWithDate:(NSDate*)d
{
	if (self = [super init]) {
		_date = [d copy];
		_fruitBags = [[NSMutableArray alloc] init];
	}
	return self;
}

-(NSString*) dateByStringWithFormat:(NSString*)format
{
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateFormat:format];
	NSString *formattedDateString = [dateFormatter stringFromDate:_date];

	return formattedDateString;
}

-(void) setDateByString: (NSString*)strDate withFormat:(NSString*)format
{
	if (_date != nil) {
		[_date release];
		_date = nil;
	}
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateFormat:format];
	_date = [[dateFormatter dateFromString:strDate] retain];
}
-(NSString*) detailByString
{
	return [NSString stringWithFormat:@"Total fruits: %d - Vitamins: %d",[_fruitBags count],[self totalVitamins]];
}

-(int) totalVitamins
{
	int total = 0;
	for (FruitBag* fb in _fruitBags) {
		total += fb.count*fb.fruit.vitamins;
	}
	return total;
}

-(void) dealloc
{		
	[_date release];
	[_fruitBags release];
	[super dealloc]; 
}
@end
