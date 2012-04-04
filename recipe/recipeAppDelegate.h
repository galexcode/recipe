//
//  recipeAppDelegate.h
//  recipe
//
//  Created by ongsoft on 3/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface recipeAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate>{
    UIViewController *authViewController;
}

@property (nonatomic) IBOutlet UIWindow *window;

@property (nonatomic) IBOutlet UITabBarController *tabBarController;

@end
