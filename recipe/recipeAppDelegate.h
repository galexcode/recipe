//
//  recipeAppDelegate.h
//  recipe
//
//  Created by Vu Tran on 3/26/12.
//  Copyright 2012 Perselab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "RecipeNavigationLabel.h"
//#import "recipeGlobal.h"

@interface recipeAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate>{
    UIViewController *authViewController;
    User* _user;
}

@property (nonatomic) IBOutlet UIWindow *window;

@property (nonatomic, weak) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, weak) IBOutlet UITabBarItem *tabBarItem1;
@property (nonatomic, weak) IBOutlet UITabBarItem *tabBarItem2;
@property (nonatomic, weak) IBOutlet UITabBarItem *tabBarItem3;
@property (nonatomic, weak) IBOutlet UITabBarItem *tabBarItem4;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem1;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem2;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem3;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem4;
@property (weak, nonatomic) IBOutlet UINavigationBar *homeBar;
@property (weak, nonatomic) IBOutlet UINavigationBar *myRecipeBar;
@property (weak, nonatomic) IBOutlet UINavigationBar *todoBar;
@property (weak, nonatomic) IBOutlet UINavigationBar *feedBar;

-(User*) user;

@end
