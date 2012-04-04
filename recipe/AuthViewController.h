//
//  AuthViewController.h
//  recipe
//
//  Created by ongsoft on 3/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthViewController : UIViewController{
    UIViewController *loginViewController;
    UIViewController *registerViewController;
    UIViewController *currentViewController;
}

@property (nonatomic, assign) IBOutlet UIView *containerView;

- (void)switchToViewController: (UIViewController *)viewControllerToSwitch;
- (IBAction)segmentControlChanged:(id)sender;

@end
