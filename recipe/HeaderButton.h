//
//  HeaderButton.h
//  recipe
//
//  Created by Vu Tran Dao Vuong on 5/29/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Category.h"

@interface HeaderButton : UIButton
{
    Category* _category;
    NSMutableArray* _array;
    NSString* _titleText;
}

@property (nonatomic) Category* category;
@property (nonatomic) NSMutableArray* array;
@property (nonatomic) NSString* titleText;

@end
