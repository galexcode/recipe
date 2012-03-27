//
//  RegisterViewController.h
//  recipe
//
//  Created by ongsoft on 3/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController{
    UITextField *activeTextField;
    UIViewController *parent;
}

- (IBAction)dismissKeyboard;
- (IBAction)onRegisterTap;

- (id)initWithParentRef:(UIViewController*)parentViewController;

@end
