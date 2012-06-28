//
//  AddStepViewController.m
//  recipe
//
//  Created by Trung on 28/06/2012.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import "AddStepViewController.h"

@interface AddStepViewController ()

@end

@implementation AddStepViewController
@synthesize recipe=_recipe;
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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
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
