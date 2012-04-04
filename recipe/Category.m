//
//  Category.m
//  recipe
//
//  Created by Vu Tran on 3/27/12.
//  Copyright 2012 OngSoft. All rights reserved.
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


@end
