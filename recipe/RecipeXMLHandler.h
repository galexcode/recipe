//
//  RecipeXMLHandler.h
//  recipe
//
//  Created by SaRy on 4/6/12.
//  Copyright (c) 2012 Perselab. All rights reserved.
//

#import "recipeGlobal.h"

@interface RecipeXMLHandler : BaseXMLHandler{
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
