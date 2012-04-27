//
//  UserXMLHandler.m
//  recipe
//
//  Created by SaRy on 4/6/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import "UserXMLHandler.h"

@implementation UserXMLHandler

-(id) initWithUser:(__weak User*)user
{
    if (self = [super init]) {
        _currentUser = user;
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
    if ([elementName isEqualToString:@"images"]) {
        return self;
    }
    if ([elementName isEqualToString:@"name"]
        || [elementName isEqualToString:@"avatarId"]
        || [elementName isEqualToString:@"recipeCount"]
        || [elementName isEqualToString:@"followingCount"]
        || [elementName isEqualToString:@"followerCount"]
        || [elementName isEqualToString:@"serving"]
        || [elementName isEqualToString:@"createDate"]
        || [elementName isEqualToString:@"imageId"])
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
//    if ([elementName isEqualToString:@"recipe"]) {
//        if ([_currentObject isKindOfClass:[Recipe class]])
//            _currentRecipe = (Recipe *)_currentObject;
//    }
}

-(void) afterElementEnding:(NSString *)elementName
{
    if ([elementName isEqualToString:@"name"]){
        if ([_currentObject isKindOfClass:[User class]])
            [_currentUser setName:_chars];
        if ([_currentObject isKindOfClass:[Recipe class]])
            [_currentRecipe setName:_chars];
    }
    if ([elementName isEqualToString:@"avatarId"]) {
        [_currentUser setAvatarId:_chars];
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
    if ([elementName isEqualToString:@"serving"])
        [_currentRecipe setServing:[_chars intValue]];
    if ([elementName isEqualToString:@"imageId"])
        [[_currentRecipe imageList] addObject:_chars];
    if ([elementName isEqualToString:@"recipe"]) {
        [[_currentUser recipes] addObject:_currentRecipe];
        //_currentRecipe = nil;
        //_currentObject = nil;
    }
}

-(NSString*) getWrappedRootNode
{
    return @"user";
}

@end
