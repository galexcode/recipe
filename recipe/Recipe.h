//
//  Recipe.h
//  recipe
//
//  Created by Vu Tran on 3/27/12.
//  Copyright 2012 OngSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recipe : NSObject{
    NSString* _recipeId;
    NSString* _name;
    int _serving;
    NSData* _createDate;
    NSMutableArray* _imageList;
    NSMutableArray* _ingredientList;
    NSMutableArray* _stepList;
}

@property (nonatomic) NSString *recipeId;
@property (nonatomic) NSString *name;
@property (nonatomic) int serving;
@property (nonatomic) NSData *createDate;
@property (nonatomic) NSMutableArray *imageList;
@property (nonatomic) NSMutableArray *ingredientList;
@property (nonatomic) NSMutableArray *stepList;

@end
