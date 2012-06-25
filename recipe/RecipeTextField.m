//
//  RecipeTextField.m
//  recipe
//
//  Created by Vu Tran Dao Vuong on 6/6/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#define padding 10

#import "RecipeTextField.h"

@implementation RecipeTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

//- (void)drawTextInRect:(CGRect)rect
//{
//    [[UIColor colorWithRed:0.76f green:0.54f blue:0.29f alpha:1.00f] setFill];
//    [[self placeholder] drawInRect:rect withFont:[UIFont systemFontOfSize:14.00f]];
//}

- (void)drawPlaceholderInRect:(CGRect)rect
{
    [[UIColor colorWithRed:0.76f green:0.54f blue:0.29f alpha:0.5f] setFill];
    [[self placeholder] drawInRect:rect withFont:[UIFont systemFontOfSize:14.00f]];
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectMake(bounds.origin.x + padding, bounds.origin.y, bounds.size.width, bounds.size.height);
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectMake(bounds.origin.x + padding, bounds.origin.y, bounds.size.width, bounds.size.height);
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
