//
//  RecipeNavigationLabel.m
//  recipe
//
//  Created by Vu Tran Dao Vuong on 6/6/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import "RecipeNavigationLabel.h"

@implementation RecipeNavigationLabel

- (id)initWithTitle:(NSString*)title
{
    self = [super initWithFrame:CGRectMake(0, 0, 100, 44)];//CGRectZero];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setFont:[UIFont boldSystemFontOfSize:15.00f]];
        [self setShadowColor:[UIColor colorWithWhite:0.0 alpha:0.5]];
        [self setTextAlignment:UITextAlignmentCenter];
        [self setTextColor:[UIColor colorWithRed:0.76f green:0.54f blue:0.29f alpha:1.00f]];
        [self setLineBreakMode:UILineBreakModeWordWrap];
        [self setMinimumFontSize:10.00f];
        [self setNumberOfLines:2];
        [self setText:title];
        [self sizeToFit];
    }
    return self;
}

- (id)initWithHeaderLogo
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setFont:[UIFont boldSystemFontOfSize:20.00f]];
        [self setShadowColor:[UIColor colorWithWhite:0.0 alpha:0.5]];
        [self setTextAlignment:UITextAlignmentCenter];
        [self setTextColor:[UIColor colorWithRed:0.76f green:0.54f blue:0.29f alpha:1.00f]];
        [self sizeToFit];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
