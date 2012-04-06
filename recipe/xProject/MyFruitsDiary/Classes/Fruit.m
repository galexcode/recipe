//
//  Fruit.m
//  MyFruitsDiary
//
//  Created by Khoi Pham on 3/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Fruit.h"


@implementation Fruit

@synthesize fruitId = _fruitId;
@synthesize vitamins = _vitamins;
@synthesize name = _name;
@synthesize imageURL = _imageURL;
@synthesize type = _type;
@synthesize image = _image;

-(id) init
{
	if (self = [super init]) {
		_fruitId = nil;
		_vitamins = 0;
		_name = nil;
		_imageURL = nil;
		_type = nil;
		_image = nil;
		
	}
	return self;
}

-(id) initWithId:(NSString*)frId vitamins:(int)v name:(NSString*)n 
			 img:(NSString*)imageName andType:(NSString*)t
{
	if (self = [super init]) {
		_fruitId = frId;
		_vitamins = v;
		_name = n;
		_imageURL = imageName;
		_type = t;
	}
	return self;
}

-(void) dealloc
{		
	[_name release];
	[_imageURL release];
	[_type release];
	[_fruitId release];
	[_image release];
	[super dealloc]; 
}
@end
