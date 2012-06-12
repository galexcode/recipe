//
//  StepDescriptionLabel.m
//  recipe
//
//  Created by Vu Tran Dao Vuong on 6/12/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//
#define MARGIN_X 10
#define MARGIN_Y 10

#import "StepDescriptionLabel.h"

@implementation StepDescriptionLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    return CGRectInset(bounds, MARGIN_X, MARGIN_Y);
}

- (void)drawTextInRect:(CGRect)rect
{
    [super drawTextInRect: CGRectInset(self.bounds, MARGIN_X, MARGIN_Y)];
}

@end
