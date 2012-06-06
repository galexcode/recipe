//
//  recipeAppDelegate.h
//  recipe
//
//  Created by Vu Tran on 3/26/12.
//  Copyright 2012 Perselab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "ApplicationService.h"
//#import "recipeGlobal.h"

@interface recipeAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate>{
    UIViewController *authViewController;
    User* _user;
    ApplicationService *_appService;
}

@property (nonatomic) IBOutlet UIWindow *window;

@property (nonatomic, weak) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, weak) IBOutlet UITabBarItem *tabBarItem1;
@property (nonatomic, weak) IBOutlet UITabBarItem *tabBarItem2;
@property (nonatomic, weak) IBOutlet UITabBarItem *tabBarItem3;
@property (nonatomic, weak) IBOutlet UITabBarItem *tabBarItem4;

-(ApplicationService*) appService;

//+(ApplicationService*) sharedApplicationService;

-(User*) user;

@end
