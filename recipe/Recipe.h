//
//  Recipe.h
//  recipe
//
//  Created by ongsoft on 3/27/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
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

@property (nonatomic, retain) NSString *recipeId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic) int serving;
@property (nonatomic, retain) NSData *createDate;
@property (nonatomic, retain) NSMutableArray *imageList;
@property (nonatomic, retain) NSMutableArray *ingredientList;
@property (nonatomic, retain) NSMutableArray *stepList;

@end
