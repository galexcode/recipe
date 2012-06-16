//
//  IngredientViewController.h
//  recipe
//
//  Created by Vu Tran Dao Vuong on 6/16/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IngredientViewController : UIViewController{
    NSString* _pageTitleText;
}

@property (weak, nonatomic) IBOutlet UILabel *pageTitle;
@property (nonatomic) NSString* pageTitleText;

@end
