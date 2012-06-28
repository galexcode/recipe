//
//  AddStepViewController.h
//  recipe
//
//  Created by Trung on 28/06/2012.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

@interface AddStepViewController : UIViewController
{
    Recipe *_recipe;
}
@property (nonatomic) Recipe *recipe;

- (IBAction)selectImage:(id)sender;
@end
