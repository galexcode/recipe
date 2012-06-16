//
//  RecipeViewController.h
//  recipe
//
//  Created by Vu Tran on 3/28/12.
//  Copyright 2012 Perselab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

@interface RecipeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    Recipe* _recipe;
    NSString* ingredientTitleText;
    NSString* stepTitleText;
}

@property (weak, nonatomic) IBOutlet UITableView *recipeDetailsTable;
@property (nonatomic) Recipe *recipe;
@property (strong, nonatomic) IBOutlet UITableViewCell *slideShowCell;
@property (strong, nonatomic) IBOutlet UIView *recipeHeaderView;
@property (strong, nonatomic) IBOutlet UIView *recipeInfoView;
@property (weak, nonatomic) IBOutlet UILabel *recipeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *recipeLikeCount;
@property (strong, nonatomic) IBOutlet UITableViewCell *userInfoCell;
@property (weak, nonatomic) IBOutlet UIImageView *userThumb;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *timeSpanSinceCreated;
@property (weak, nonatomic) IBOutlet UIScrollView *imageSlider;

@end
