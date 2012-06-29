//
//  StepsTableViewController.h
//  recipe
//
//  Created by Vu Tran on 6/29/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StepsTableViewController : UITableViewController{
    NSInteger selectedIndex;
    NSArray* _steps;
}

@property (nonatomic) NSArray* steps;

@end
