//
//  recipeGlobal.h
//  recipe
//
//  Created by Vu Tran on 3/27/12.
//  Copyright 2012 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplicationService.h"
#import "recipeAppDelegate.h"

#import "BaseXMLHandler.h"
#import "User.h"
#import "Ingredient.h"
#import "Step.h"
#import "Recipe.h"
#import "Category.h"


//Application Service
#define USER(currentUser) User* currentUser = [(recipeAppDelegate*)[[UIApplication sharedApplication] delegate] user]
#define APP_SERVICE(appSrv) ApplicationService* appSrv = [(recipeAppDelegate*)[[UIApplication sharedApplication] delegate] appService]