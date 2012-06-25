//
//  Ingredient.h
//  recipe
//
//  Created by Vu Tran on 3/27/12.
//  Copyright 2012 Perselab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ingredient : NSObject{
    NSString* _ingredientId;
    NSString* _name;
    NSString* _desc;
    NSString* _quantity;
    NSString* _unit;
    NSString* _imagePath;
}

@property (nonatomic) NSString *ingredientId;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *desc;
@property (nonatomic) NSString *quantity;
@property (nonatomic) NSString *unit;
@property  NSString *imagePath;

@end
