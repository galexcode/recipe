//
//  StepViewController.h
//  recipe
//
//  Created by Vu Tran on 3/28/12.
//  Copyright 2012 Perselab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StepViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    NSArray* _steps;
}

@property (nonatomic) NSArray* steps;

@end
