//
//  RecipeTextField.m
//  recipe
//
//  Created by Vu Tran Dao Vuong on 6/6/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import "RecipeTextField.h"

@implementation RecipeTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawPlaceholderInRect:(CGRect)rect
{
    [[UIColor colorWithRed:0.76f green:0.54f blue:0.29f alpha:1.00f] setFill];
    [[self placeholder] drawInRect:rect withFont:[UIFont systemFontOfSize:14.00f]];
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
