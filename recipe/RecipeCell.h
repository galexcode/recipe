//
//  RecipeCell.h
//  recipe
//
//  Created by Vu Tran Dao Vuong on 5/28/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipeTitleLabel.h"
#import "ControlVariables.h"

@interface RecipeCell : UITableViewCell
{
    UIImageView *_thumbnail;
    RecipeTitleLabel *_titleLabel;
}

@property (nonatomic, retain) UIImageView *thumbnail;
@property (nonatomic, retain) RecipeTitleLabel *titleLabel;
@end
