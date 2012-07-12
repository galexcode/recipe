//
//  HorizontalTableCell2.m
//  recipe
//
//  Created by Vu Tran on 7/10/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import "HorizontalTableCell2.h"
#import "GlobalStore.h"
#import "RecipeCell.h"
#import "RecipeTitleLabel.h"
#import "ControlVariables.h"
#import "RecipeViewController.h"

@implementation HorizontalTableCell2

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
        //UIImageView *contentBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 290, kCellHeight+5)];
        //UIImage *contentBg = [[UIImage imageNamed:@"glass_content"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 15, 15)];
        //[contentBgView setImage:contentBg];
        
        //[self addSubview:contentBgView];
        
        //self.horizontalTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kCellHeight, kTableLength)];
        self.horizontalTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kCellHeight, kTableLength)];
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        [self.horizontalTableView setPagingEnabled:YES];
        
        self.horizontalTableView.showsVerticalScrollIndicator = YES;
        self.horizontalTableView.showsHorizontalScrollIndicator = NO;
        [self.horizontalTableView setScrollIndicatorInsets:UIEdgeInsetsMake(0, 0, 0, 100)];
        
        self.horizontalTableView.transform = CGAffineTransformMakeRotation(-M_PI * 0.5);
        //[self.horizontalTableView setFrame:CGRectMake(kRowHorizontalPadding * 0.5, kRowVerticalPadding * 0.5, kTableLength - kRowHorizontalPadding, kCellHeight)];
        [self.horizontalTableView setFrame:CGRectMake(7, 4, 276, kCellHeight)];
        
        self.horizontalTableView.rowHeight = kCellWidth;
        //self.horizontalTableView.backgroundColor = kHorizontalTableBackgroundColor;
        self.horizontalTableView.backgroundColor = [UIColor clearColor];
        
        self.horizontalTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.horizontalTableView.separatorColor = [UIColor clearColor];
        
        [self.horizontalTableView setBounces:NO];
        
        self.horizontalTableView.dataSource = self;
        self.horizontalTableView.delegate = self;
        [self addSubview:self.horizontalTableView];
        
        pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(260, -13, 10, 10)];
        [self addSubview:pageControl];
    }
    
    return self;
}

- (void)populatePageControl
{
    if ([self.recipes count] > 3)
        [pageControl setNumberOfPages:2];
    else
        [pageControl setNumberOfPages:1];
}

#pragma mark Scroll View delegate
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    if (pageControlUsed) {
        return;
    }
    CGFloat pageWidth = 276;
    int page = floor((sender.contentOffset.y - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlUsed = NO;
}

- (IBAction)changePage:(id)sender {

}

#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.recipes count] <= 3) {
        return [self.recipes count];
    }
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RecipeSquareCell";
    
    __block RecipeCell *cell = (RecipeCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) 
    {
        cell = [[RecipeCell alloc] initWithFrame:CGRectMake(0, 0, kCellWidth, kCellHeight)];
    }
    
    if (indexPath.row >= [self.recipes count]) {
        [cell.shadowView setBackgroundColor:[UIColor clearColor]];
        cell.defaultRecipe.image = nil;
        cell.thumbnail.image = nil;
        return cell;
    }    
    __block Recipe *currentRecipe = [self.recipes objectAtIndex:indexPath.row];
    
    //    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //    
    //    dispatch_async(concurrentQueue, ^{        
    //        UIImage *image = nil;
    //        if ([[currentRecipe imageList] count] > 0) {
    //            NSURL *url = [NSURL URLWithString:[GlobalStore imageLinkWithImageId:[[currentRecipe imageList] objectAtIndex:0] forWidth:184 andHeight:0]];
    //            image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    //        }
    //        
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //            [cell.thumbnail setImage:image]; 
    //        });
    //    });
    
    if ([[currentRecipe imageList] count] > 0) {
        cell.thumbnail.url = [NSURL URLWithString:[GlobalStore imageLinkWithImageId:[[currentRecipe imageList] objectAtIndex:0] forWidth:184 andHeight:184]];
        
        [[[GlobalStore sharedStore] objectManager] manage:cell.thumbnail];
    } else {
        cell.thumbnail.image = [UIImage imageNamed:@"default_recipe_square"];
    }
    
    //cell.titleLabel.text = [currentRecipe name];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < [self.recipes count]) {
        Recipe *currentRecipe = [self.recipes objectAtIndex:indexPath.row];
        RecipeViewController *viewControllerToPush;
        if ([[[[GlobalStore sharedStore] loggedUser] userId] isEqualToString:[[currentRecipe owner] userId]]) {
            viewControllerToPush = [[RecipeViewController alloc] initWithEditableRecipe];
        } else {
            viewControllerToPush = [[RecipeViewController alloc] initWithNibName:@"RecipeViewController" bundle:nil];
        }
        [[viewControllerToPush navigationItem] setTitle:[currentRecipe name]];
        [viewControllerToPush setRecipe:currentRecipe];
        [self.navController performSelector:@selector(pushViewController:animated:) withObject:viewControllerToPush];
    }
}

@end

