//
//  Recipe.m
//  recipe
//
//  Created by ongsoft on 3/27/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Recipe.h"

@implementation Recipe
@synthesize recipeId = _recipeId;
@synthesize name = _name;
@synthesize serving = _serving;
@synthesize createDate = _createDate;
@synthesize imageList = _imageList;
@synthesize ingredientList = _ingredientList;
@synthesize stepList = _stepList;

- (id)init
{
    self = [super init];
    if (self) {
        _recipeId = nil;
        _name = nil;
        _serving = 0;
        _createDate = nil;
        _imageList = nil;
        _ingredientList = nil;
        _stepList = nil;
    }
    
    return self;
}

- (void)dealloc
{
    [_recipeId release];
    [_name release];
    [_createDate release];
    [_imageList release];
    [_ingredientList release];
    [_stepList release];
    [super dealloc];
}

@end
