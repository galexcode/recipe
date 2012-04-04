//
//  Category.h
//  recipe
//
//  Created by Vu Tran on 3/27/12.
//  Copyright 2012 OngSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Category : NSObject{
    NSString* _categoryId;
    NSString* _name;
    NSMutableArray* _latestRecipes;
}

@property (nonatomic) NSString *categoryId;
@property (nonatomic) NSString *name;
@property (nonatomic) NSMutableArray *latestRecipes;

@end
