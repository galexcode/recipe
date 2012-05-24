//
//  AuthViewController.m
//  recipe
//
//  Created by Vu Tran on 3/26/12.
//  Copyright 2012 Perselab. All rights reserved.
//

#import "AuthViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"

@implementation AuthViewController
@synthesize containerView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - Change View Methods
-(void)switchToViewController: (UIViewController *)viewControllerToSwitch{
    if (viewControllerToSwitch == currentViewController) {
        return;
    }
    if ([currentViewController isViewLoaded]) {
        [currentViewController.view removeFromSuperview];
    }
    if (viewControllerToSwitch != nil) {
        [containerView addSubview:viewControllerToSwitch.view];
    }
    currentViewController = viewControllerToSwitch;
}

- (IBAction)segmentControlChanged:(id)sender {
    UISegmentedControl *segmentControl = sender;
    switch (segmentControl.selectedSegmentIndex) {
        case 0:
            [self switchToViewController:loginViewController];
            break;
        case 1:
            [self switchToViewController:registerViewController];
            break;
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    loginViewController = [[LoginViewController alloc] initWithParentRef:self];
    registerViewController = [[RegisterViewController alloc] initWithParentRef:self];
    currentViewController = loginViewController;
    [containerView addSubview:loginViewController.view];
}

- (void)viewDidUnload
{
    [self setContainerView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
