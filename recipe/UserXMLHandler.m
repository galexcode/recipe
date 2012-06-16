//
//  UserXMLHandler.m
//  recipe
//
//  Created by SaRy on 4/6/12.
//  Copyright (c) 2012 Perselab. All rights reserved.
//

#import "UserXMLHandler.h"

@implementation UserXMLHandler

-(id) initWithUser:(__weak User*)user
{
    if (self = [super init]) {
        _currentUser = user;
        _currentRecipe = nil;
        _currentRecipeOwner = nil;
        _currentIngredient = nil;
        _currentStep = nil;
    }
    return self;
}

-(id) initObjectAfterElementStarting:(NSString *)elementName{
    if ([elementName isEqualToString:@"user"]){
        _currentObject = _currentUser;
        return self;
    }
    if ([elementName isEqualToString:@"recipes"]){
        return self;
    }
    if ([elementName isEqualToString:@"recipe"]){
        _currentRecipe = [[Recipe alloc] init];
        _currentObject = _currentRecipe;
        return self;
    }
    if ([elementName isEqualToString:@"owner"]){
        _currentObject = [[User alloc] init];
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
        || [elementName isEqualToString:@"avatarId"]
        || [elementName isEqualToString:@"recipeCount"]
        || [elementName isEqualToString:@"followingCount"]
        || [elementName isEqualToString:@"followerCount"]
        || [elementName isEqualToString:@"likeCount"]
        || [elementName isEqualToString:@"serving"]
        || [elementName isEqualToString:@"desc"]
        || [elementName isEqualToString:@"note"]
        || [elementName isEqualToString:@"createDate"]
        || [elementName isEqualToString:@"images"]
        || [elementName isEqualToString:@"imageId"]
        || [elementName isEqualToString:@"avatarId"])
    {
        return self;
    }
	return nil;
}

-(void) afterElementStarting:(NSString *)elementName withAttributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"user"]){
        [_currentUser setUserId:[[NSString alloc] initWithString:[attributeDict objectForKey:@"id"]]];
    }
    if ([elementName isEqualToString:@"recipe"]) {
        if ([_currentObject isKindOfClass:[Recipe class]])
            _currentRecipe = (Recipe *)_currentObject;
    }
    if ([elementName isEqualToString:@"owner"]) {
        if ([_currentObject isKindOfClass:[User class]]){
            _currentRecipeOwner = (User *)_currentObject;
            [_currentRecipeOwner setUserId:[[NSString alloc] initWithString:[attributeDict objectForKey:@"id"]]];
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

-(void) afterElementEnding:(NSString *)elementName
{
    if ([elementName isEqualToString:@"name"]){
        if ([_currentObject isKindOfClass:[User class]]){
            if (_currentRecipeOwner == nil) {
                [_currentUser setName:_chars];
            } else {
                [_currentRecipeOwner setName:_chars];
            }
        }
        if ([_currentObject isKindOfClass:[Recipe class]])
            [_currentRecipe setName:_chars];
        if ([_currentObject isKindOfClass:[Ingredient class]])
            [_currentIngredient setName:_chars];
        if ([_currentObject isKindOfClass:[Step class]])
            [_currentStep setName:_chars];
    }
    if ([elementName isEqualToString:@"avatarId"]) {
        if (_currentRecipeOwner == nil) {
            [_currentUser setAvatarId:_chars];
        } else {
            [_currentRecipeOwner setAvatarId:_chars];
        }
    }
    if ([elementName isEqualToString:@"recipeCount"]) {
        [_currentUser setRecipeCount:[_chars intValue]];
    }
    if ([elementName isEqualToString:@"followingCount"]) {
        [_currentUser setFollowingCount:[_chars intValue]];
    }
    if ([elementName isEqualToString:@"followerCount"]) {
        [_currentUser setFollowerCount:[_chars intValue]];
    }
    if ([elementName isEqualToString:@"desc"]){
        //        if ([_currentObject isKindOfClass:[Recipe class]])
        //            [[_currentRecipe imageList] addObject:_chars];
        if ([_currentObject isKindOfClass:[Ingredient class]])
            [_currentIngredient setDesc:_chars];
        if ([_currentObject isKindOfClass:[Step class]])
            [_currentStep setDesc:_chars];
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
    if ([elementName isEqualToString:@"imageId"])
        [[_currentRecipe imageList] addObject:_chars];
    if ([elementName isEqualToString:@"recipe"]) {
        [[_currentUser recipes] addObject:_currentRecipe];
        _currentRecipe = nil;
        _currentObject = nil;
    }
}

-(NSString*) getWrappedRootNode
{
    return @"user";
}

@end
