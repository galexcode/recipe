//
//  UserXMLHandler.h
//  recipe
//
//  Created by SaRy on 4/6/12.
//  Copyright (c) 2012 Perselab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseXMLHandler.h"
#import "User.h"
#import "Recipe.h"
#import "Ingredient.h"
#import "Step.h"

@interface UserXMLHandler : BaseXMLHandler{
    NSObject* _currentObject;
    __weak User* _currentUser;
    Recipe* _currentRecipe;
    User* _currentRecipeOwner;
    Ingredient* _currentIngredient;
    Step* _currentStep;
}

-(id) initWithUser:(__weak User*)user;
-(void) afterElementStarting:(NSString *)elementName withAttributes:(NSDictionary *)attributeDict;
-(void) afterElementEnding:(NSString *)elementName;
-(NSString*) getWrappedRootNode;

@end
