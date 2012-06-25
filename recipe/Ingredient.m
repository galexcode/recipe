//
//  Ingredient.m
//  recipe
//
//  Created by Vu Tran on 3/27/12.
//  Copyright 2012 Perselab. All rights reserved.
//

#import "Ingredient.h"

@implementation Ingredient
@synthesize ingredientId = _ingredientId;
@synthesize name = _name;
@synthesize desc = _desc;
@synthesize quantity = _quantity;
@synthesize unit = _unit;
@synthesize imagePath = _imagePath;

- (id)init
{
    self = [super init];
    if (self) {
        _ingredientId = nil;
        _name = nil;
        _desc = nil;
        _quantity = nil;
        _unit = nil;
        _imagePath = [NSString stringWithString:@"-1"];
    }
    
    return self;
}


@end
