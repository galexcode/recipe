//
//  RecipesXMLHandler.m
//  recipe
//
//  Created by Vu Tran Dao Vuong on 6/16/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import "RecipesXMLHandler.h"

@implementation RecipesXMLHandler

-(id) initWithRecipeArray:(NSMutableArray*)recipeArray{
    if (self = [super init]) {
        _currentObject = nil;
        _currentRecipe = nil;
        _currentUser = nil;
        _currentIngredient = nil;
        _currentStep = nil;
        _recipeArray = recipeArray;
        _total = nil;
    }
    return self;
}

-(id) initObjectAfterElementStarting:(NSString *)elementName{
    if ([elementName isEqualToString:@"recipes"]){
        return self;
    }
    if ([elementName isEqualToString:@"recipe"]){
        _currentObject = [[Recipe alloc] init];
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
    if ([elementName isEqualToString:@"recipes"] || [elementName isEqualToString:@"ingredients"] || [elementName isEqualToString:@"steps"])
        _total = [[NSNumber alloc] initWithInteger:[[attributeDict objectForKey:@"total"] intValue]];
    if ([elementName isEqualToString:@"recipe"]) {
        if ([_currentObject isKindOfClass:[Recipe class]])
            _currentRecipe = (Recipe *)_currentObject;
    }
    if ([elementName isEqualToString:@"owner"]) {
        if ([_currentObject isKindOfClass:[User class]]){
            _currentUser = (User *)_currentObject;
            [_currentUser setUserId:[[NSString alloc] initWithString:[attributeDict objectForKey:@"id"]]];
        }
    }
    if ([elementName isEqualToString:@"ingredient"]) {
        if ([_currentObject isKindOfClass:[Ingredient class]])
            _currentIngredient = (Ingredient *)_currentObject;
    }
    if ([elementName isEqualToString:@"step"]) {
        if ([_currentObject isKindOfClass:[Step class]])
            _currentStep = (Step *)_currentObject;
    }
}

-(void) afterElementEnding:(NSString *)elementName{
    
    if ([elementName isEqualToString:@"name"]){
        if ([_currentObject isKindOfClass:[Recipe class]])
            [_currentRecipe setName:_chars];
        if ([_currentObject isKindOfClass:[User class]])
            [_currentUser setName:_chars];
        if ([_currentObject isKindOfClass:[Ingredient class]])
            [_currentIngredient setName:_chars];
        if ([_currentObject isKindOfClass:[Step class]])
            [_currentStep setName:_chars];
    }
    if ([elementName isEqualToString:@"serving"])
        [_currentRecipe setServing:[_chars intValue]];
    if ([elementName isEqualToString:@"likeCount"])
        [_currentRecipe setLikeCount:[_chars intValue]];
    if ([elementName isEqualToString:@"createDate"]) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [_currentRecipe setCreateDate:[dateFormat dateFromString:_chars]]; 
    }
    if ([elementName isEqualToString:@"avatarId"])
        [_currentUser setAvatarId:_chars];
    if ([elementName isEqualToString:@"desc"]){
        //        if ([_currentObject isKindOfClass:[Recipe class]])
        //            [[_currentRecipe imageList] addObject:_chars];
        if ([_currentObject isKindOfClass:[Ingredient class]])
            [_currentIngredient setDesc:_chars];
        if ([_currentObject isKindOfClass:[Step class]])
            [_currentStep setDesc:_chars];
    }
    if ([elementName isEqualToString:@"note"])
        [_currentStep setNote:_chars];
    if ([elementName isEqualToString:@"imageId"]){
        if ([_currentObject isKindOfClass:[Recipe class]])
            [[_currentRecipe imageList] addObject:_chars];
        if ([_currentObject isKindOfClass:[Ingredient class]])
            [_currentIngredient setImagePath:_chars];
        if ([_currentObject isKindOfClass:[Step class]])
            [_currentStep setImagePath:_chars];
    }
    if ([elementName isEqualToString:@"ingredient"]) {
        [[_currentRecipe ingredientList] addObject:_currentIngredient];
        _currentIngredient = nil;
        _currentObject = nil;
    }
    if ([elementName isEqualToString:@"step"]) {
        [[_currentRecipe stepList] addObject:_currentStep];
        _currentStep = nil;
        _currentObject = nil;
    }
    if ([elementName isEqualToString:@"owner"]) {
        [_currentRecipe setOwner:_currentUser];
        _currentUser = nil;
        _currentObject = nil;
    }
    if ([elementName isEqualToString:@"recipe"]) {
        [_recipeArray addObject:_currentRecipe];
        _currentRecipe = nil;
        _currentObject = nil;
    }
}

-(NSString*) getWrappedRootNode
{
	return @"recipes";
}

@end
