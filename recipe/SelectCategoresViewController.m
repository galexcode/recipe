//
//  SelectCategoresViewController.m
//  recipe
//
//  Created by Vu Tran Dao Vuong on 6/16/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#define checkmark [UIImage imageNamed:@"checkmark.png"]

#import "SelectCategoresViewController.h"
#import "Category.h"
#import "GlobalStore.h"

@interface SelectCategoresViewController ()

@end

@implementation SelectCategoresViewController
@synthesize selectedCategories = _selectedCategories;
@synthesize recipe = _recipe;

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
    NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES selector:@selector(localizedCompare:)];
    sortedCategories = [[[[GlobalStore sharedStore] categories] allKeys] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark UI Table Deletage Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[[GlobalStore sharedStore] categories] allKeys] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *normalCell = @"Normal";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:normalCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:normalCell];
    }
    
    NSString *categoryName = [sortedCategories objectAtIndex:indexPath.row];
    Category *currentCategory = (Category*)[[[GlobalStore sharedStore] categories] objectForKey:categoryName];
    
    UIImageView *checkmarkView = [[UIImageView alloc] initWithFrame:CGRectMake(294, 10, checkmark.size.width, checkmark.size.height)];
    checkmarkView.image = nil;
    [cell setAccessoryView:checkmarkView];
    for (int i = 0; i < [[[self recipe] categoryList] count]; i++) {
        if ([[currentCategory categoryId] isEqualToString:[[[self recipe] categoryList] objectAtIndex:i]]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            checkmarkView.image = checkmark;
            break;
        }
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithString:categoryName];
    cell.textLabel.textColor = [UIColor colorWithRed:0.76f green:0.54f blue:0.29f alpha:1.00f];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *categoryName = [sortedCategories objectAtIndex:indexPath.row];
    Category *currentCategory = (Category*)[[[GlobalStore sharedStore] categories] objectForKey:categoryName];
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [((UIImageView*)[cell accessoryView]) setImage:nil];
        [[[self recipe] categoryList] removeObject:[currentCategory categoryId]];
    } else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [((UIImageView*)[cell accessoryView]) setImage:checkmark];
        [[[self recipe] categoryList] addObject:[currentCategory categoryId]];
    }
}


@end
