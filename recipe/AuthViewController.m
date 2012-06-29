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
#import "MCSegmentedControl.h"

@implementation AuthViewController
@synthesize containerView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // Segment controll
        NSArray *items = [NSArray arrayWithObjects:
                          @"Login",
                          @"Register",
                          nil];
        MCSegmentedControl *segmentedControl = [[MCSegmentedControl alloc] initWithItems:items];
        
        // set frame, add to view, set target and action for value change as usual
        segmentedControl.frame = CGRectMake(20.0f, 20.0f, 280.0f, 30.0f);
        //[self.view addSubview:segmentedControl];
        [segmentedControl addTarget:self action:@selector(segmentControlChanged:) forControlEvents:UIControlEventValueChanged];
        
        segmentedControl.selectedSegmentIndex = 0;
        
        // Set a tint color
        //segmentedControl.tintColor = [UIColor colorWithRed:.0 green:.6 blue:.0 alpha:1.0];
        segmentedControl.tintColor = [UIColor brownColor];
        
        // Customize font and items color
        segmentedControl.selectedItemColor   = [UIColor whiteColor];
        segmentedControl.unselectedItemColor = [UIColor darkGrayColor];
        segmentedControl.unSelectedItemBackgroundGradientColors = [NSArray arrayWithObjects:[UIColor grayColor] , [UIColor brownColor], nil];
        
        //[self.view addSubview:segmentedControl];
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
