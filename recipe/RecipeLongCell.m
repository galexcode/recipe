//
//  RecipeLongCell.m
//  recipe
//
//  Created by Vu Tran Dao Vuong on 6/16/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "RecipeLongCell.h"

@implementation RecipeLongCell
@synthesize recipeName;
@synthesize recipeDescription;
@synthesize thumbBorder;
@synthesize thumb;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) awakeFromNib
{
    [[[self thumb] layer] setCornerRadius:5];
    [[[self thumb] layer] setMasksToBounds:YES];
    [[[self thumbBorder] layer] setCornerRadius:5];
    [[[self thumbBorder] layer] setMasksToBounds:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
