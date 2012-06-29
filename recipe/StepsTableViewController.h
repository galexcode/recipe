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

@interface StepsTableViewController : UITableViewController{
    NSInteger selectedIndex;
    Recipe* _recipe;
    NSArray* _steps;
    Boolean ediable;
    UIBarButtonItem* barButton;
}

@property (nonatomic) Recipe *recipe;
@property (nonatomic) NSArray* steps;
@property (strong, nonatomic) IBOutlet UIView *stepForm;

- (id)initWithEditableTable;

@end
