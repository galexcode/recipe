//
//  AuthViewController.h
//  recipe
//
//  Created by Vu Tran on 3/26/12.
//  Copyright 2012 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthViewController : UIViewController{
    UIViewController *loginViewController;
    UIViewController *registerViewController;
    UIViewController *currentViewController;
}

@property (weak, nonatomic) IBOutlet UIView *containerView;

- (void)switchToViewController: (UIViewController *)viewControllerToSwitch;
- (IBAction)segmentControlChanged:(id)sender;

@end
