//
//  CategoriesXMLHandler.h
//  recipe
//
//  Created by Vu Tran Dao Vuong on 5/31/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseXMLHandler.h"
#import "Recipe.h"
#import "Category.h"
#import "Ingredient.h"
#import "Step.h"

@interface CategoriesXMLHandler : BaseXMLHandler
{
    NSObject* _currentObject;
    Category* _currentCategory;
    Recipe* _currentRecipe;
    User* _currentUser;
    Ingredient* _currentIngredient;
    Step* _currentStep;
    NSNumber* _total;
//    NSMutableArray* _categoryArray;
    NSMutableDictionary* _categoryDictionary;
}

//-(id) initWithCategoryArray:(NSMutableArray*)categoryArray;
-(id) initWithCategoryDictionary:(NSMutableDictionary*)categoryDictionary;
-(void) afterElementStarting:(NSString *)elementName withAttributes:(NSDictionary *)attributeDict;
-(void) afterElementEnding:(NSString *)elementName;
-(NSString*) getWrappedRootNode;

@end
