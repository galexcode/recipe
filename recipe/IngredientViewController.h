//
//  IngredientViewController.h
//  recipe
//
//  Created by Vu Tran on 3/28/12.
//  Copyright 2012 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IngredientViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    UIViewController *detailsViewController;
    UIViewController *storeListViewController;
    UIViewController *currentViewController;
}

@property (weak, nonatomic) IBOutlet UIView *containerView;

- (void)switchToViewController: (UIViewController *)viewControllerToSwitch;
- (IBAction)segmentControlChanged:(id)sender;

@end
