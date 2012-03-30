//
//  Category.m
//  recipe
//
//  Created by ongsoft on 3/27/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Category.h"

@implementation Category
@synthesize categoryId = _categoryId;
@synthesize name = _name;
@synthesize latestRecipes = _latestRecipes;

- (id)init
{
    self = [super init];
    if (self) {
        _categoryId = nil;
        _name = nil;
        _latestRecipes = nil;
    }

    return self;
}

- (void)dealloc
{
    [_categoryId release];
    [_name release];
    [_latestRecipes release];
    [super dealloc];
}

@end
