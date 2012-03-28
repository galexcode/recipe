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

@property (nonatomic, retain) NSString *ingredientId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *desc;
@property (retain) NSString *imagePath;

@end
