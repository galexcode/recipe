//
//  CategoryCell.m
//  recipe
//
//  Created by Vu Tran on 3/28/12.
//  Copyright 2012 OngSoft. All rights reserved.
//

#import "CategoryCell.h"

@implementation CategoryCell
@synthesize imageList;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //custome init
    }
    return self;
}

- (id)initWithImageList:(NSMutableArray *)list reuseIdentifier:(NSString *)reuseIdentifier refController:(HomeViewController *)refController{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        _refController = refController;
        UIImage *image = [UIImage imageNamed:@"beef.jpg"];
        _button1 = [[UIButton alloc] init];
        _button2 = [[UIButton alloc] init];
        _button3 = [[UIButton alloc] init];
        [_button1 setImage:image forState:UIControlStateNormal];
        [_button2 setImage:image forState:UIControlStateNormal];
        [_button3 setImage:image forState:UIControlStateNormal];
        [_button1 addTarget:self action:@selector(tapOnThumbs:) forControlEvents:UIControlEventTouchUpInside];
        [_button1 addTarget:self action:@selector(tapOnThumbs:) forControlEvents:UIControlEventTouchUpInside];
        [_button1 addTarget:self action:@selector(tapOnThumbs:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_button1];
        [self.contentView addSubview:_button2];
        [self.contentView addSubview:_button3];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect contentRect = self.contentView.bounds;
    CGFloat boundsX = contentRect.origin.x;
    CGRect frame;
    
    frame= CGRectMake(boundsX ,0, 100, 100);
    _button1.frame = frame;
    
    frame= CGRectMake(boundsX+100 ,0, 100, 100);
    _button2.frame = frame;
    
    frame= CGRectMake(boundsX+200 ,0, 100, 100);
    _button3.frame = frame;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma Methods Handle Tap On Thumbs
- (void)tapOnThumbs:(id)sender{
    [_refController showRecipeView];
}

@end
