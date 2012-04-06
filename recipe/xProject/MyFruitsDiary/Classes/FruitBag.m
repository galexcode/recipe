//
//  FruitBag.m
//  MyFruitsDiary
//
//  Created by Khoi Pham on 3/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FruitBag.h"


@implementation FruitBag

@synthesize count = _count;
@synthesize fruit = _fruit;

-(id) init
{
	if (self = [super init]) {
		_count = 0;
		_fruit = nil;
		
	}
	return self;
}

-(id) initWithCount:(int)c andFruit:(Fruit*)fr
{
	if (self = [super init]) {
		_count = c;
		_fruit = fr;
		
	}
	return self;
}

-(int) totalVitamins
{
	return _count*_fruit.vitamins;
}

-(void) dealloc
{		
	[_fruit release];
		
	[super dealloc]; 
}
@end
