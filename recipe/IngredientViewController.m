//
//  IngredientViewController.m
//  recipe
//
//  Created by Vu Tran on 3/28/12.
//  Copyright 2012 Perselab. All rights reserved.
//

#import "IngredientViewController.h"

@implementation IngredientViewController
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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    detailsViewController = [[LoginViewController alloc] initWithParentRef:self];
//    storeListViewController = [[RegisterViewController alloc] initWithParentRef:self];
//    currentViewController = loginViewController;
//    [containerView addSubview:loginViewController.view];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
            //[self switchToViewController:loginViewController];
            break;
        case 1:
            //[self switchToViewController:registerViewController];
            break;
    }
}

#pragma mark - Table Delegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell.textLabel setText:@"simple store"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
