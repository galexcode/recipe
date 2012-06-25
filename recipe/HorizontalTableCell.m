//
//  HorizontalTableCell.m
//  HorizontalTables
//
//  Created by Felipe Laso on 8/19/11.
//  Copyright 2011 Felipe Laso. All rights reserved.
//

#import "HorizontalTableCell.h"
#import "RecipeCell.h"
#import "RecipeTitleLabel.h"
#import "ControlVariables.h"
#import "RecipeViewController.h"

@implementation HorizontalTableCell

@synthesize horizontalTableView = _horizontalTableView;
@synthesize recipes = _recipes;
@synthesize navController;


- (NSString *) reuseIdentifier 
{
    return @"HorizontalCell";
}


- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        self.horizontalTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kCellHeight, kTableLength)];
        
        self.horizontalTableView.showsVerticalScrollIndicator = YES;
        self.horizontalTableView.showsHorizontalScrollIndicator = NO;
        [self.horizontalTableView setScrollIndicatorInsets:UIEdgeInsetsMake(0, 0, 0, 100)];
        
        self.horizontalTableView.transform = CGAffineTransformMakeRotation(-M_PI * 0.5);
        [self.horizontalTableView setFrame:CGRectMake(kRowHorizontalPadding * 0.5, kRowVerticalPadding * 0.5, kTableLength - kRowHorizontalPadding, kCellHeight)];
        
        self.horizontalTableView.rowHeight = kCellWidth;
        //self.horizontalTableView.backgroundColor = kHorizontalTableBackgroundColor;
        self.horizontalTableView.backgroundColor = [UIColor clearColor];
        
        self.horizontalTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.horizontalTableView.separatorColor = [UIColor clearColor];
        
        self.horizontalTableView.dataSource = self;
        self.horizontalTableView.delegate = self;
        [self addSubview:self.horizontalTableView];
    }
    
    return self;
}

#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"Number of recipe: %d of %@", [self.recipes count], @"category");
    return [self.recipes count];
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *cellIdentifier = @"ArticleCell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    
//    if (cell == nil) 
//    {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//    }
//    
//    cell.textLabel.text = @"The title of the cell in the table within the table :O";
//    
//    return cell;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RecipeCell";
    
    __block RecipeCell *cell;// = (RecipeCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) 
    {
        cell = [[RecipeCell alloc] initWithFrame:CGRectMake(0, 0, kCellWidth, kCellHeight)];
    }
    
    //__block NSDictionary *currentRecipe = [self.recipes objectAtIndex:indexPath.row];
    __block Recipe *currentRecipe = [self.recipes objectAtIndex:indexPath.row];
    
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
//    if ([cell.thumbnail image] == nil) {
//        dispatch_async(concurrentQueue, ^{        
//            UIImage *image = nil;
//            if ([[currentRecipe imageList] count] > 0) {
//                NSString *link = [NSString stringWithFormat:@"http://www.perselab.com/recipe/image/%@/250", [[currentRecipe imageList] objectAtIndex:0]];
//                NSURL *url = [NSURL URLWithString:link];
//                //image = [UIImage imageNamed:[currentArticle objectForKey:@"ImageName"]];
//                //image = [UIImage imageNamed:@"OrangeJuice"];
//                image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
//            }
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [cell.thumbnail setImage:image]; 
//            });
//        }); 
//    }
    dispatch_async(concurrentQueue, ^{        
        UIImage *image = nil;
        if ([[currentRecipe imageList] count] > 0) {
            NSString *link = [NSString stringWithFormat:@"http://www.perselab.com/recipe/image/%@/250", [[currentRecipe imageList] objectAtIndex:0]];
            NSURL *url = [NSURL URLWithString:link];
            //image = [UIImage imageNamed:[currentArticle objectForKey:@"ImageName"]];
            //image = [UIImage imageNamed:@"OrangeJuice"];
            image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [cell.thumbnail setImage:image]; 
        });
    }); 
    
    //cell.titleLabel.text = [currentRecipe objectForKey:@"Title"];
    cell.titleLabel.text = [currentRecipe name];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Recipe *currentRecipe = [self.recipes objectAtIndex:indexPath.row];
    RecipeViewController *viewControllerToPush = [[RecipeViewController alloc] initWithNibName:@"RecipeViewController" bundle:nil];
    [[viewControllerToPush navigationItem] setTitle:[currentRecipe name]];
    [viewControllerToPush setRecipe:currentRecipe];
    [self.navController performSelector:@selector(pushViewController:animated:) withObject:viewControllerToPush];
}

@end
