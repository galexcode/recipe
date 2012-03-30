//
//  Ingredient.m
//  recipe
//
//  Created by ongsoft on 3/27/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Ingredient.h"

@implementation Ingredient
@synthesize ingredientId = _ingredientId;
@synthesize name = _name;
@synthesize desc = _desc;
@synthesize imagePath = _imagePath;

- (id)init
{
    self = [super init];
    if (self) {
        _ingredientId = nil;
        _name = nil;
        _desc = nil;
        _imagePath = nil;
    }
    
    return self;
}

- (void)dealloc
{
    [_ingredientId release];
    [_name release];
    [_desc release];
    [_imagePath release];
    [super dealloc];
}

@end
