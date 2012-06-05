//
//  LoginViewController.m
//  recipe
//
//  Created by Vu Tran on 3/26/12.
//  Copyright 2012 Perselab. All rights reserved.
//

#import "LoginViewController.h"
#import "MBProgressHUD.h"
#import "ASIForm2DataRequest.h"

@implementation LoginViewController
@synthesize userName;
@synthesize password;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        UIButton * login = [UIButton buttonWithType:UIButtonTypeCustom];
//        login.frame = CGRectMake(20, 98, 280, 35);
//        [login setBackgroundImage:[[UIImage imageNamed:@"btn-red.png"] stretchableImageWithLeftCapWidth:20.0 topCapHeight:0.0] forState:UIControlStateNormal];
//        [login addTarget:self action:@selector(onLoginTap:) forControlEvents:UIControlEventTouchUpInside];
//        [login setTitle:@"Login" forState:UIControlStateNormal];
//        //[buy.titleLabel setFont:[UIFont fontWithName: @"Helvetica" size: 24]];
//        //[buy.titleLabel setFont:[UIFont boldSystemFontOfSize:24]];
//        [self.view addSubview:login];
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
- (IBAction)onLoginTap:(id)sender{
    if (activeTextField != nil) {
        [activeTextField resignFirstResponder];
    }
    if ([trimSpaces([userName text]) length] != 0 && [[password text] length] != 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [hud setLabelText:@"Checking..."];
        _user = [[User alloc] init];
        
        NSURL *url = [NSURL URLWithString:@"http://www.perselab.com/recipe/xml/login.xml"];
        
        __block ASIForm2DataRequest *request = [ASIForm2DataRequest requestWithURL:url];
        //    [request setPostValue:[loggingUser name] forKey:@"u"];
        //    [request setPostValue:[loggingUser password] forKey:@"p"];
        
        [request setCompletionBlock:^{
            NSLog(@"Login xml loaded.");
            if (request.responseStatusCode == 200) {
                UserXMLHandler* handler = [[UserXMLHandler alloc] initWithUser:_user];
                [handler setEndDocumentTarget:self andAction:@selector(didParsedLoggingUser)];
                NSXMLParser* parser = [[NSXMLParser alloc] initWithData:request.responseData];
                parser.delegate = handler;
                [parser parse];
//            }else if(request.responseStatusCode == 404){
            } else {
                _user = nil;
                [self didParsedLoggingUser];
            }
        }];
        [request setFailedBlock:^{
            [self handleError:request.error];
        }];
        
        [request startAsynchronous];
        
    }else {
        if ([trimSpaces([userName text]) length] == 0)
            [userName setText:@""];
        [userName setText:trimSpaces([userName text])];
        [userName setPlaceholder:@"User name is blank"];
        if ([[password text] length] == 0)
            [password setPlaceholder:@"Password is blank"];
    }
}

- (void)handleError:(NSError*)error
{
    NSLog(@"Error receiving respone for login request: %@", error.localizedDescription);
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSString *errorTitle;
    NSString *errorMessage;
    if ([error code] == 1) {
        errorTitle = [[NSString alloc] initWithString:@"Internet Access Problem"];
        errorMessage = [[NSString alloc] initWithString:@"Please check your internet access!"];
    } else {
        errorTitle = [[NSString alloc] initWithString:@"Error Ocurring"];
        errorMessage = [[NSString alloc] initWithString:@"Unknown error"];
    }
    UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:errorTitle
                                                                    message:errorMessage
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
    [errorAlertView show];
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
-(void) didParsedLoggingUser
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (_user != nil) {
        UIAlertView *successAlertView = [[UIAlertView alloc] initWithTitle:@"Successful Login"
                                                                   message:[NSString stringWithFormat:@"Welcome back %@",[_user name]]
                                                                  delegate:nil
                                                         cancelButtonTitle:@"OK"
                                                         otherButtonTitles:nil];
        [successAlertView show];
        [_parentController.view setHidden:YES];
    } else {
        UIAlertView *failsAlertView = [[UIAlertView alloc] initWithTitle:@"Login Failed"
                                                                   message:[NSString stringWithFormat:@"Username or Password is not correct"]
                                                                  delegate:nil
                                                         cancelButtonTitle:@"OK"
                                                         otherButtonTitles:nil];
        [failsAlertView show];
    }
}
    
//-(void) didFinishVerifyUser:(__weak User *)loggedUser{
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
//    if (loggedUser != nil) {
//        USER(currentUser);
//        currentUser = _user;
////        [currentUser copy:_user];
////        APP_SERVICE(appSrv);
//        NSLog(@"%@", currentUser);
////        [appSrv setDelegate:nil];
//        NSLog(@"username on weak: %@", [loggedUser name]);
//        NSLog(@"username on strong: %@", [currentUser name]);
//        NSLog(@"username on nil: %@", [_user name]);
//        NSLog(@"username on shared: %@", [currentUser name]);
//        UIAlertView *successAlertView = [[UIAlertView alloc] initWithTitle:@"Successful Login"
//                                                                   message:[NSString stringWithFormat:@"Welcome back %@",[currentUser name]]
//                                                                  delegate:nil
//                                                         cancelButtonTitle:@"OK"
//                                                         otherButtonTitles:nil];
//        [successAlertView show];
//        [_parentController.view setHidden:YES];
//    }
//}

@end
