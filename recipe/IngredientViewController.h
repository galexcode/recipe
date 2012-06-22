//
//  IngredientViewController.h
//  recipe
//
//  Created by Vu Tran Dao Vuong on 6/16/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ingredient.h"

@interface IngredientViewController : UIViewController{
    NSString* _pageTitleText;
    Ingredient *_ingredient;
}
@property (nonatomic) Ingredient *ingredient;
@property (weak, nonatomic) IBOutlet UILabel *pageTitle;
@property (nonatomic) NSString* pageTitleText;
@property (weak, nonatomic) IBOutlet UIImageView *imageIngredient;
@property (weak, nonatomic) IBOutlet UITextView *ingredientDesc;

@end
