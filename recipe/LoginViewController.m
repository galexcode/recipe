//
//  LoginViewController.m
//  recipe
//
//  Created by Vu Tran on 3/26/12.
//  Copyright 2012 Perselab. All rights reserved.
//

#import "LoginViewController.h"

@implementation LoginViewController
@synthesize userName;
@synthesize password;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithParentRef:(UIViewController*)parentViewController{
    self = [super init];
    if (self) {
        _parentController = parentViewController;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setUserName:nil];
    [self setPassword:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark - Login feature
- (IBAction)onLoginTap{
    if (activeTextField != nil) {
        [activeTextField resignFirstResponder];
    }
    if ([trimSpaces([userName text]) length] != 0 && [[password text] length] != 0) {
        _user = [[User alloc] init];
        APP_SERVICE(appSrv);
        [appSrv setDelegate:self];
        [appSrv verifyUser:_user];
    }else {
        if ([trimSpaces([userName text]) length] == 0)
            [userName setText:@""];
        [userName setText:trimSpaces([userName text])];
        [userName setPlaceholder:@"User name is blank"];
        if ([[password text] length] == 0)
            [password setPlaceholder:@"Password is blank"];
    }
}

- (IBAction)dismissKeyboard{
    if (activeTextField != nil) {
        [activeTextField resignFirstResponder];
    }
}

#pragma mark - Text Fields Delegate Methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    activeTextField = textField;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark Application Service Delegate Methods
-(void) didFinishVerifyUser:(__weak User *)loggedUser{
    if (loggedUser != nil) {
        USER(currentUser);
        currentUser = _user;
        NSLog(@"username on weak: %@", [loggedUser name]);
        NSLog(@"username on strong: %@", [currentUser name]);
        NSLog(@"username on nil: %@", [_user name]);
        UIAlertView *successAlertView = [[UIAlertView alloc] initWithTitle:@"Successful Login"
                                                                   message:[NSString stringWithFormat:@"Welcome back %@",[currentUser name]]
                                                                  delegate:nil
                                                         cancelButtonTitle:@"OK"
                                                         otherButtonTitles:nil];
        [successAlertView show];
        [_parentController.view setHidden:YES];
    }
}

@end
