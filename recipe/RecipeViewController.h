//
//  RecipeViewController.h
//  recipe
//
//  Created by Vu Tran on 3/28/12.
//  Copyright 2012 Perselab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

@interface RecipeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
{
    Recipe* _recipe;
    NSString* ingredientTitleText;
    NSString* stepTitleText;
    Boolean editable;
    UIBarButtonItem *barButton;
    Boolean pageControlUsed;
}

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UITableView *recipeDetailsTable;
@property (nonatomic) Recipe *recipe;
@property (strong, nonatomic) IBOutlet UITableViewCell *slideShowCell;
@property (strong, nonatomic) IBOutlet UIView *recipeHeaderView;
@property (strong, nonatomic) IBOutlet UIView *recipeInfoView;
@property (weak, nonatomic) IBOutlet UILabel *recipeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *recipeLikeCount;
@property (strong, nonatomic) IBOutlet UITableViewCell *userInfoCell;
@property (weak, nonatomic) IBOutlet UIImageView *userThumb;
@property (weak, nonatomic) IBOutlet UIView *borderThumb;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *timeSpanSinceCreated;
@property (weak, nonatomic) IBOutlet UIScrollView *imageSlider;
@property (weak, nonatomic) IBOutlet UIImageView *defaultRecipeView;

- (id)initWithEditableRecipe;
- (IBAction)changePage:(id)sender;

@end
