//
//  IngredientCell.m
//  recipe
//
//  Created by Vu Tran Dao Vuong on 6/9/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import "IngredientCell.h"
//#import "RecipeDisclosureIndicators.h"

@implementation IngredientCell
@synthesize thumb;
@synthesize unit;
@synthesize quantity;
@synthesize name;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
