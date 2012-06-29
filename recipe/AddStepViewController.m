//
//  AddStepViewController.m
//  recipe
//
//  Created by Trung on 28/06/2012.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import "AddStepViewController.h"
#import "RecipeNavigationLabel.h"


@interface AddStepViewController ()

@end

@implementation AddStepViewController
@synthesize recipe=_recipe;
@synthesize stepForm;
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
    RecipeNavigationLabel *label = [[RecipeNavigationLabel alloc] initWithTitle:[[self navigationItem] title]];
    [[self navigationItem] setTitleView:label];
    barButton = [[UIBarButtonItem alloc] 
                 initWithTitle:@"Add"                                            
                 style:UIBarButtonItemStyleBordered 
                 target:self 
                 action:@selector(addStep:)];
    self.navigationItem.rightBarButtonItem = barButton;
    
    stepsTable = [[StepsTableViewController alloc] initWithNibName:@"StepsTableViewController" bundle:nil];
    [stepsTable setSteps:[[self recipe] stepList]];
    
    [self.view addSubview:stepsTable.view];
    [self.view addSubview:stepForm];
    [stepForm setHidden:YES];
}

- (void)addStep:(id)sender
{
    [barButton setTitle:@"Cancel"];
    [barButton setAction:@selector(cancelAddStep:)];
    [stepForm setHidden:NO];
}

- (void)cancelAddStep:(id)sender
{
    [barButton setTitle:@"Add"];
    [barButton setAction:@selector(addStep:)];
    [stepForm setHidden:YES];
}

- (void)viewDidUnload
{
    [self setStepForm:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)selectImage:(id)sender
{
    
}
@end
