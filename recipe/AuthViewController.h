//
//  AuthViewController.h
//  recipe
//
//  Created by Vu Tran on 3/26/12.
//  Copyright 2012 Perselab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthViewController : UIViewController{
    UIViewController *loginViewController;
    UIViewController *registerViewController;
    UIViewController *currentViewController;
}

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (void)switchToViewController: (UIViewController *)viewControllerToSwitch;
- (void)needToScroll:(CGFloat)y;
- (IBAction)segmentControlChanged:(id)sender;

@end
