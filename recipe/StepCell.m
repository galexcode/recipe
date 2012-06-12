//
//  StepCell.m
//  recipe
//
//  Created by Vu Tran Dao Vuong on 6/11/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import "StepCell.h"
//#import "RecipeDisclosureIndicators.h"

@implementation StepCell
@synthesize stepIndentifier;
@synthesize stepDescription;
@synthesize accessoryArrow;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

//- (void)awakeFromNib
//{
////    RecipeDisclosureIndicators *accessory = [RecipeDisclosureIndicators accessoryWithColor:[UIColor colorWithRed:0.76f green:0.54f blue:0.29f alpha:1.00f]];
////    [accessory setHighlightedColor:[UIColor orangeColor]];
////    [self setAccessoryView:accessory];
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
