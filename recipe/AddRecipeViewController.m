//
//  AddRecipeViewController.m
//  recipe
//
//  Created by Vu Tran Dao Vuong on 6/16/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import "AddRecipeViewController.h"
#import "SelectCategoresViewController.h"
#import "ASIForm2DataRequest.h"
#import "GlobalStore.h"

@interface AddRecipeViewController ()

@end

@implementation AddRecipeViewController
@synthesize recipeName;
@synthesize serving;
@synthesize inputCell;
@synthesize itemCell;
@synthesize actionCell;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *headerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_header"]];
    
    [[self navigationItem] setTitleView:headerView];
    
    selectedCategories = [[NSMutableArray alloc] init];
}

- (void)viewDidUnload
{
    [self setInputCell:nil];
    [self setItemCell:nil];
    [self setActionCell:nil];
    [self setRecipeName:nil];
    [self setServing:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark Add Recipe Logic
- (IBAction)selectCategories:(id)sender
{
    SelectCategoresViewController *viewControllerToPush = [[SelectCategoresViewController alloc] initWithNibName:@"SelectCategoresViewController" bundle:nil];
    [[self navigationController] pushViewController:viewControllerToPush animated:YES];
}

- (IBAction)cancelAction:(id)sender
{
    [[self navigationController] popViewControllerAnimated:YES];
}

- (IBAction)saveAction:(id)sender
{
    if ([self validateInputInformation]) {
        NSURL *url = [NSURL URLWithString:@"http://www.perselab.com/recipe/recipe/add"];
        
        __block ASIForm2DataRequest *request = [ASIForm2DataRequest requestWithURL:url];
        [request setPostValue:[[[GlobalStore sharedStore] loggedUser] userId] forKey:@"uid"];
        [request setPostValue:[recipeName text] forKey:@"name"];
        [request setPostValue:[serving text] forKey:@"serving"];
        //[request setPostValue:[password text] forKey:@"pw"];
        
        [request setCompletionBlock:^{
//            NSLog(@"Complete Post Recipe.");
//            if (request.responseStatusCode == 200) {
//                NSLog(@"%d", request.responseStatusCode);
//                UserXMLHandler* handler = [[UserXMLHandler alloc] initWithUser:_user];
//                [handler setEndDocumentTarget:self andAction:@selector(didParsedLoggingUser)];
//                NSXMLParser* parser = [[NSXMLParser alloc] initWithData:request.responseData];
//                parser.delegate = handler;
//                [parser parse];
//                //            }else if(request.responseStatusCode == 404){
//            } else {
//                _user = nil;
//                [self didParsedLoggingUser];
//            }
        }];
        [request setFailedBlock:^{
//            [self handleError:request.error];
        }];
        
        [request startAsynchronous];
    }
}

- (Boolean)validateInputInformation
{
    Boolean flag = YES;
    
    if ([trimSpaces([recipeName text]) length] == 0){
        [recipeName setText:@""];
        [recipeName setPlaceholder:@"Recipe name is blank"];
        flag = NO;
    }
    if ([[serving text] length] == 0){
        [serving setText:@""];
        [serving setPlaceholder:@"Serving is blank"];
        flag = NO;
    }
    if ([trimSpaces([recipeName text]) length] == 0 && [[serving text] length] == 0){
        [recipeName setText:@""];
        [recipeName setPlaceholder:@"Recipe name is blank"];
        [serving setText:@""];
        [serving setPlaceholder:@"Serving is blank"];
        flag = NO;
    }
    
    return flag;
}

#pragma mark - Text Fields Delegate Methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //activeTextField = textField;
    if ([textField tag] == 1) {
        [textField setKeyboardType:UIKeyboardTypeDefault];
    }
    if ([textField tag] == 2) {
        [textField setKeyboardType:UIKeyboardTypeNumberPad];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)backgroundTap:(id)sender
{
    [recipeName resignFirstResponder];
    [serving resignFirstResponder];
}

#pragma mark UI Table Deletage Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        return 135;
    }
    if (indexPath.row == 2) {
        return 100;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *normalCell = @"Normal";
    static NSString *inputCellIndentifier = @"Input";
    static NSString *itemCellIndentifier = @"Item";
    static NSString *actionCellIndentifier = @"Action";
    
    if (indexPath.row == 1) {
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:inputCellIndentifier];
        if (cell == nil) {
            cell = inputCell;
        }
        return cell;
    } else if (indexPath.row == 2) {
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:itemCellIndentifier];
        if (cell == nil) {
            cell = itemCell;
        }
        return cell;
    } else if (indexPath.row == 3){
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:actionCellIndentifier];
        if (cell == nil) {
            cell = actionCell;
        }
        return cell;
    }else {
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:normalCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:normalCell];
        }
        
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = [NSString stringWithString:@"Recipe Information"];
        cell.textLabel.textColor = [UIColor colorWithRed:0.76f green:0.54f blue:0.29f alpha:1.00f];
        
        return cell;
    }
}

@end
