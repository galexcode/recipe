//
//  Recipe.h
//  recipe
//
//  Created by Vu Tran on 3/27/12.
//  Copyright 2012 Perselab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Recipe : NSObject

@property (nonatomic) User *owner;
@property (nonatomic) NSString *recipeId;
@property (nonatomic) NSString *name;
@property (nonatomic) int serving;
@property (nonatomic) int likeCount;
@property (nonatomic) NSDate *createDate;
@property (nonatomic) NSMutableArray *imageList;
@property (nonatomic) NSMutableArray *ingredientList;
@property (nonatomic) NSMutableArray *stepList;
@property (nonatomic) NSMutableArray *categoryList;

@end
