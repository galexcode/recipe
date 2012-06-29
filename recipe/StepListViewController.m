//
//  StepListViewController.m
//  recipe
//
//  Created by SaRy on 4/5/12.
//  Copyright (c) 2012 Perselab. All rights reserved.
//

#define COMMENT_LABEL_WIDTH 280
#define COMMENT_LABEL_MIN_HEIGHT 44
#define COMMENT_LABEL_PADDING 10

#import "StepListViewController.h"
#import "RecipeNavigationLabel.h"
#import "StepCell.h"
#import "Step.h"

@interface StepListViewController ()

@end

@implementation StepListViewController
@synthesize pageTitle;
@synthesize pageTitleText = _pageTitleText;
@synthesize stepListTable;
@synthesize steps = _steps;

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
    RecipeNavigationLabel *label = [[RecipeNavigationLabel alloc] initWithTitle:[[self navigationItem] title]];
    [[self navigationItem] setTitleView:label];
    
//    UIImageView *headerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_header"]];
//    [[self pageTitle] setText:[self pageTitleText]];
    
//    [[self navigationItem] setTitleView:headerView];
    
    selectedIndex = 0;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setStepListTable:nil];
    [self setPageTitle:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//This just a convenience function to get the height of the label based on the comment text
-(CGFloat)getLabelHeightForIndex:(NSInteger)index
{
    CGSize maximumSize = CGSizeMake(COMMENT_LABEL_WIDTH, 10000);
    
    NSString *oneLine = [NSString stringWithString:@"1 line"];
    
    CGSize heighOfOneLine = [oneLine sizeWithFont: [UIFont fontWithName:@"Helvetica" size:17.0f]
                                constrainedToSize:maximumSize
                                    lineBreakMode:UILineBreakModeWordWrap];
    
    Step *currentStep = [[self steps] objectAtIndex:index];
    
    CGSize labelHeighSize = [[currentStep desc] sizeWithFont: [UIFont fontWithName:@"Helvetica" size:17.0f]
                                                        constrainedToSize:maximumSize
                                                            lineBreakMode:UILineBreakModeWordWrap];
    return labelHeighSize.height + heighOfOneLine.height*2;
}

#pragma mark - Table Delegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.steps count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"StepCell";
    
    StepCell *cell = (StepCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Step *currentStep = [[self steps] objectAtIndex:indexPath.row];
    
    if (cell == nil) 
    {
        //NSArray* topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"IngredientCell" owner:nil options:nil];
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"StepCell" owner:self options:nil];
        
        for (id currentObject in topLevelObjects) {
            if ([currentObject isKindOfClass:[StepCell class]]) {
                cell = (StepCell*)currentObject;
                break;
            }
        }
    }
    
    if(selectedIndex == indexPath.row)
    {
        cell.accessoryArrow.center = CGPointMake(278, 22);
        cell.accessoryArrow.transform = CGAffineTransformMakeRotation(3.14159265358979323846264338327950288/2);
    }
    else 
    {
        [cell.stepDescription setHidden:YES];
    }
    CGFloat labelHeight = [self getLabelHeightForIndex:indexPath.row];
            
    cell.stepDescription.frame = CGRectMake(cell.stepDescription.frame.origin.x, 
                                                     cell.stepDescription.frame.origin.y, 
                                                     cell.stepDescription.frame.size.width, 
                                                     labelHeight);
    
    cell.stepIndentifier.text = [NSString stringWithFormat:@"Step %d", indexPath.row+1];
    cell.stepDescription.text  = [currentStep desc];
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //If this is the selected index we need to return the height of the cell
    //in relation to the label height otherwise we just return the minimum label height with padding
    if(selectedIndex == indexPath.row)
    {
        return [self getLabelHeightForIndex:indexPath.row] + COMMENT_LABEL_MIN_HEIGHT;
    }
    else {
        return COMMENT_LABEL_MIN_HEIGHT;
    }
}



-(NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //We only don't want to allow selection on any cells which cannot be expanded
    if([self getLabelHeightForIndex:indexPath.row] > COMMENT_LABEL_MIN_HEIGHT)
    {
        return indexPath;
    }
    else {
        return nil;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //The user is selecting the cell which is currently expanded
    //we want to minimize it back
    if(selectedIndex == indexPath.row)
    {
        selectedIndex = -1;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        return;
    }
    
    //First we check if a cell is already expanded.
    //If it is we want to minimize make sure it is reloaded to minimize it back
    if(selectedIndex >= 0)
    {
        NSIndexPath *previousPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
        selectedIndex = indexPath.row;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:previousPath] withRowAnimation:UITableViewRowAnimationFade];        
    }
    
    //Finally set the selected index to the new selection and reload it to expand
    selectedIndex = indexPath.row;
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

@end
