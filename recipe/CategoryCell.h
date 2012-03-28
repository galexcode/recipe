//
//  CategoryCell.h
//  recipe
//
//  Created by ongsoft on 3/28/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryCell : UITableViewCell{
    UIImageView* _thumb1;
    UIImageView* _thumb2;
    UIImageView* _thumb3;
    NSMutableArray* _imageList;
}

@property (nonatomic, retain) NSMutableArray *imageList;

- (id)initWithImageList:(NSMutableArray *)list reuseIdentifier:(NSString *)reuseIdentifier;

@end
