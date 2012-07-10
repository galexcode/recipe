//
//  RecipeCell.h
//  recipe
//
//  Created by Vu Tran Dao Vuong on 5/28/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"
#import "RecipeTitleLabel.h"
#import "ControlVariables.h"
#import "HJManagedImageV.h"

@interface RecipeCell : UITableViewCell
{
    HJManagedImageV *_thumbnail;
    RecipeTitleLabel *_titleLabel;
    UIImageView *_defaultRecipe;
    UIView *_shadowView;
}

@property (nonatomic) UIImageView *defaultRecipe;
@property (nonatomic) UIView *shadowView;
@property (nonatomic, retain) HJManagedImageV *thumbnail;
@property (nonatomic, retain) RecipeTitleLabel *titleLabel;
@end
