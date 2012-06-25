//
//  HomeViewController.m
//  recipe
//
//  Created by Vu Tran Dao Vuong on 6/25/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import "HomeViewController.h"
#import "CategoryListViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize searchBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[[self searchBar] setTintColor:[UIColor colorWithRed:0.76f green:0.54f blue:0.29f alpha:1.00f]];
    [[self searchBar] setTintColor:[UIColor clearColor]];
    
    CategoryListViewController *tableViewController = [[CategoryListViewController alloc] initWithNibName:@"CategoryListViewController" bundle:nil];
    CGRect frame = CGRectMake(0, 44, 320, 446);
    [tableViewController.view setFrame:frame];
    tableViewController.navController = self.navigationController;
    [self.view addSubview:tableViewController.view];
}

- (void)viewDidUnload
{
    [self setSearchBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
