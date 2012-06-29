//
//  AddStepViewController.h
//  recipe
//
//  Created by Trung on 28/06/2012.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StepsTableViewController.h"
#import "Recipe.h"

@interface AddStepViewController : UIViewController
{
    Recipe *_recipe;
    StepsTableViewController *stepsTable;
    UIBarButtonItem *barButton;
}
@property (nonatomic) Recipe *recipe;
@property (strong, nonatomic) IBOutlet UIView *stepForm;

- (IBAction)selectImage:(id)sender;
@end
