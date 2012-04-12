//
//  recipeAppDelegate.h
//  recipe
//
//  Created by Vu Tran on 3/26/12.
//  Copyright 2012 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplicationService.h"

@interface recipeAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate>{
    UIViewController *authViewController;
    ApplicationService* _appService;
}

@property (nonatomic) IBOutlet UIWindow *window;

@property (nonatomic) IBOutlet UITabBarController *tabBarController;

-(ApplicationService*) appService;

@end
