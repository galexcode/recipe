//
//  User.h
//  recipe
//
//  Created by Vu Tran on 3/27/12.
//  Copyright 2012 Perselab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject{
    NSString* _userId;
    NSString* _name;
    NSString* _email;
    NSString* _password;
    NSString* _avatarId;
    NSInteger _recipeCount;
    NSInteger _followingCount;
    NSInteger _followerCount;
    NSMutableArray* _recipes;
}

@property (nonatomic) NSString *userId;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *email;
@property (nonatomic) NSString *password;
@property (nonatomic) NSString *avatarId;
@property (nonatomic, assign) NSInteger recipeCount;
@property (nonatomic, assign) NSInteger followingCount;
@property (nonatomic, assign) NSInteger followerCount;
@property (nonatomic) NSMutableArray *recipes;

@end
