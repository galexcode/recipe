//
//  RecipeXMLHandler.m
//  recipe
//
//  Created by SaRy on 4/6/12.
//  Copyright (c) 2012 Perselab. All rights reserved.
//

#import "RecipeXMLHandler.h"

@implementation RecipeXMLHandler

-(id) initWithRecipe:(Recipe *)recipe{
    if (self = [super init]) {
        _currentObject = nil;
        _currentRecipe = nil;
        _currentUser = nil;
        _currentIngredient = nil;
        _currentStep = nil;
        _recipe = recipe;
        if (_recipe != nil) {
            [self resetList];
        }
        _total = nil;
    }
    return self;
}

-(void)resetList
{
    [_recipe setImageList:nil];
    [_recipe setImageList:[NSMutableArray array]];
    [_recipe setIngredientList:nil];
    [_recipe setIngredientList:[NSMutableArray array]];
    [_recipe setStepList:nil];
    [_recipe setStepList:[NSMutableArray array]];
    [_recipe setCategoryList:nil];
    [_recipe setCategoryList:[NSMutableArray array]];
}

-(id) initObjectAfterElementStarting:(NSString *)elementName{
    if ([elementName isEqualToString:@"recipe"]){
        if (_recipe == nil) {
            _recipe = [[Recipe alloc] init];
        }
        _currentObject = _recipe;
        return self;
    }
    if ([elementName isEqualToString:@"recat"]) {
        return self;
    }
    if ([elementName isEqualToString:@"cat"]) {
        return self;
    }
    if ([elementName isEqualToString:@"owner"]){
        _currentObject = [[User alloc] init];
        return self;
    }
    if ([elementName isEqualToString:@"images"]) {
        return self;
    }
    if ([elementName isEqualToString:@"ingredients"]){
        return self;
    }
    if ([elementName isEqualToString:@"ingredient"]){
        _currentObject = [[Ingredient alloc] init];
        return self;
    }
    if ([elementName isEqualToString:@"steps"]){
        return self;
    }
    if ([elementName isEqualToString:@"step"]){
        _currentObject = [[Step alloc] init];
        return self;
    }
    if ([elementName isEqualToString:@"name"]
        || [elementName isEqualToString:@"serving"]
        || [elementName isEqualToString:@"likeCount"]
        || [elementName isEqualToString:@"createDate"]
        || [elementName isEqualToString:@"desc"]
        || [elementName isEqualToString:@"quantity"]
        || [elementName isEqualToString:@"unit"]
        || [elementName isEqualToString:@"note"]
        || [elementName isEqualToString:@"imageId"]
        || [elementName isEqualToString:@"images"]
        || [elementName isEqualToString:@"image"])
    {
        return self;
    }
	return nil;
}

-(void) afterElementStarting:(NSString *)elementName withAttributes:(NSDictionary *)attributeDict{
    if ([elementName isEqualToString:@"ingredients"] || [elementName isEqualToString:@"steps"])
        _total = [[NSNumber alloc] initWithInteger:[[attributeDict objectForKey:@"total"] intValue]];
    if ([elementName isEqualToString:@"recipe"]) {
        if ([_currentObject isKindOfClass:[Recipe class]]){
            [_recipe setRecipeId:[NSString stringWithString:[attributeDict objectForKey:@"id"]]];
        }
    }
    if ([elementName isEqualToString:@"owner"]) {
        if ([_currentObject isKindOfClass:[User class]]){
            _currentUser = (User *)_currentObject;
            [_currentUser setUserId:[[NSString alloc] initWithString:[attributeDict objectForKey:@"id"]]];
        }
    }
    if ([elementName isEqualToString:@"ingredient"]) {
        if ([_currentObject isKindOfClass:[Ingredient class]]){
            _currentIngredient = (Ingredient *)_currentObject;
            [_currentIngredient setIngredientId:[[NSString alloc] initWithString:[attributeDict objectForKey:@"id"]]];
        }
    }
    if ([elementName isEqualToString:@"step"]) {
        if ([_currentObject isKindOfClass:[Step class]]){
            _currentStep = (Step *)_currentObject;
            [_currentStep setStepId:[[NSString alloc] initWithString:[attributeDict objectForKey:@"id"]]];
        }
    }
}

-(void) afterElementEnding:(NSString *)elementName{
    
    if ([elementName isEqualToString:@"name"]){
        if ([_currentObject isKindOfClass:[Recipe class]])
            [_recipe setName:_chars];
        if ([_currentObject isKindOfClass:[User class]])
            [_currentUser setName:_chars];
        if ([_currentObject isKindOfClass:[Ingredient class]])
            [_currentIngredient setName:_chars];
        if ([_currentObject isKindOfClass:[Step class]])
            [_currentStep setName:_chars];
    }
    if ([elementName isEqualToString:@"serving"])
        [_recipe setServing:[_chars intValue]];
    if ([elementName isEqualToString:@"likeCount"])
        [_recipe setLikeCount:[_chars intValue]];
    if ([elementName isEqualToString:@"createDate"]) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [_recipe setCreateDate:[dateFormat dateFromString:_chars]]; 
    }
    if ([elementName isEqualToString:@"avatarId"])
        [_currentUser setAvatarId:_chars];
    if ([elementName isEqualToString:@"desc"]){
        if ([_currentObject isKindOfClass:[Ingredient class]])
            [_currentIngredient setDesc:_chars];
        if ([_currentObject isKindOfClass:[Step class]])
            [_currentStep setDesc:_chars];
    }
    if ([elementName isEqualToString:@"quantity"])
        [_currentIngredient setQuantity:_chars];
    if ([elementName isEqualToString:@"unit"])
        [_currentIngredient setUnit:_chars];
    if ([elementName isEqualToString:@"note"])
        [_currentStep setNote:_chars];
    if ([elementName isEqualToString:@"imageId"]){
        if ([_currentObject isKindOfClass:[Recipe class]])
            [[_recipe imageList] addObject:_chars];
        if ([_currentObject isKindOfClass:[Ingredient class]])
            [_currentIngredient setImagePath:_chars];
        if ([_currentObject isKindOfClass:[Step class]])
            [_currentStep setImagePath:_chars];
    }
    if ([elementName isEqualToString:@"owner"]) {
        [_recipe setOwner:_currentUser];
        _currentUser = nil;
        _currentObject = nil;
    }
    if ([elementName isEqualToString:@"ingredient"]) {
        [[_recipe ingredientList] addObject:_currentIngredient];
        _currentIngredient = nil;
        _currentObject = nil;
    }
    if ([elementName isEqualToString:@"step"]) {
        [[_recipe stepList] addObject:_currentStep];
        _currentStep = nil;
        _currentObject = nil;
    }
    if ([elementName isEqualToString:@"cat"]) {
        [[_recipe categoryList] addObject:_chars];
    }
}

-(NSString*) getWrappedRootNode
{
	return @"recipe";
}

@end
