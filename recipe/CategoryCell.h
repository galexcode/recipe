//
//  CategoryCell.h
//  recipe
//
//  Created by Vu Tran on 3/28/12.
//  Copyright 2012 Perselab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"

@interface CategoryCell : UITableViewCell{
    UIButton* _button1;
    UIButton* _button2;
    UIButton* _button3;
    __weak UIViewController* _refController;
}

@property (nonatomic) NSMutableArray *imageList;

- (id)initWithImageList:(NSMutableArray *)list reuseIdentifier:(NSString *)reuseIdentifier refController:(UIViewController *)refController;

@end
