//
//  LoginViewController.h
//  recipe
//
//  Created by Vu Tran on 3/26/12.
//  Copyright 2012 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "recipeGlobal.h"

@interface LoginViewController : UIViewController<ApplicationServiceDelegate>{
    UITextField *activeTextField;
    __weak UIViewController* _parentController;
}

- (IBAction)dismissKeyboard;
- (IBAction)onLoginTap;

- (id)initWithParentRef:(UIViewController*)parentViewController;

@end
