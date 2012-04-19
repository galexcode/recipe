//
//  RecipeXMLHandler.h
//  recipe
//
//  Created by SaRy on 4/6/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import "recipeGlobal.h"

@interface RecipeXMLHandler : BaseXMLHandler{
    NSObject* _currentObject;
    Recipe* _currentRecipe;
    Ingredient* _currentIngredient;
    Step* _currentStep;
    NSNumber* _total;
    NSMutableArray* _recipeArray;
}

-(id) initWithRecipeArray:(NSMutableArray*)recipeArray;
-(void) afterElementStarting:(NSString *)elementName withAttributes:(NSDictionary *)attributeDict;
-(void) afterElementEnding:(NSString *)elementName;
-(NSString*) getWrappedRootNode;

@end
