//
//  HeaderButton.h
//  recipe
//
//  Created by Vu Tran Dao Vuong on 5/29/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderButton : UIButton
{
    NSArray* _array;
    NSString* _titleText;
}

@property (nonatomic) NSArray* array;
@property (nonatomic) NSString* titleText;

@end
