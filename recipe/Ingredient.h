//
//  Ingredient.h
//  recipe
//
//  Created by ongsoft on 3/27/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ingredient : NSObject{
    NSString* _ingredientId;
    NSString* _name;
    NSString* _desc;
    NSString* _imagePath;
}

@property (nonatomic) NSString *ingredientId;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *desc;
@property  NSString *imagePath;

@end
