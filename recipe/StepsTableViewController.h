//
//  StepsTableViewController.h
//  recipe
//
//  Created by Vu Tran on 6/29/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"
//#import "Step.m"

@interface StepsTableViewController : UITableViewController <UITextFieldDelegate, UITextViewDelegate, UIAlertViewDelegate>{
    NSInteger selectedIndex;
    Recipe* _recipe;
    NSArray* _steps;
    Boolean ediable;
    UIBarButtonItem* barButton;
    
    UIAlertView *deleteConfirmAlert;
    NSIndexPath *indexToDelete;
    
    __weak UITextView *activeTextView;
    __weak UITextField *activeTextField;
}

@property (nonatomic) Recipe *recipe;
@property (nonatomic) NSArray* steps;
@property (strong, nonatomic) IBOutlet UIView *stepForm;
@property (weak, nonatomic) IBOutlet UITextField *txtStepName;
@property (weak, nonatomic) IBOutlet UITextView *txtStepDescription;

- (id)initWithEditableTable;
- (IBAction)dismissKeyboard:(id)sender;
- (IBAction)insertStep:(id)sender;

@end
