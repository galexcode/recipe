//
//  MyFruitsDiaryAppDelegate.h
//  MyFruitsDiary
//
//  Created by Khoi Pham on 3/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplicationService.h"

@class MyFruitsDiaryViewController;

@interface MyFruitsDiaryAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MyFruitsDiaryViewController *viewController;
	
	ApplicationService*			_appService;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MyFruitsDiaryViewController *viewController;

-(ApplicationService*) appService;

@end

