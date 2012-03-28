//
//  CategoryCell.m
//  recipe
//
//  Created by ongsoft on 3/28/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CategoryCell.h"

@implementation CategoryCell
@synthesize imageList;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imageList = nil;
    }
    return self;
}

- (id)initWithImageList:(NSMutableArray *)list reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        _imageList = list;
        UIImage *image = [UIImage imageNamed:@"kira.png"];
        _thumb1 = [[UIImageView alloc] initWithImage:image];
        _thumb2 = [[UIImageView alloc] initWithImage:image];
        _thumb3 = [[UIImageView alloc] initWithImage:image];
        [self.contentView addSubview:_thumb1];
        [self.contentView addSubview:_thumb2];
        [self.contentView addSubview:_thumb3];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect contentRect = self.contentView.bounds;
    CGFloat boundsX = contentRect.origin.x;
    CGRect frame;
    
    frame= CGRectMake(boundsX ,0, 100, 100);
    _thumb1.frame = frame;
    
    frame= CGRectMake(boundsX+100 ,0, 100, 100);
    _thumb2.frame = frame;
    
    frame= CGRectMake(boundsX+200 ,0, 100, 100);
    _thumb3.frame = frame;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
