//
//  RecipesXMLHandler.h
//  recipe
//
//  Created by Vu Tran Dao Vuong on 6/16/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import "recipeGlobal.h"

@interface RecipesXMLHandler : BaseXMLHandler{
    NSObject* _currentObject;
    Recipe* _currentRecipe;
    Ingredient* _currentIngredient;
    Step* _currentStep;
    User* _currentUser;
    NSNumber* _total;
    NSMutableArray* _recipeArray;
}

-(id) initWithRecipeArray:(NSMutableArray*)recipeArray;
-(void) afterElementStarting:(NSString *)elementName withAttributes:(NSDictionary *)attributeDict;
-(void) afterElementEnding:(NSString *)elementName;
-(NSString*) getWrappedRootNode;

@end
