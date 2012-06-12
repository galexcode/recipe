//
//  RecipeDisclosureIndicators.h
//  recipe
//
//  Created by Vu Tran Dao Vuong on 6/11/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeDisclosureIndicators : UIControl
{
	UIColor *_accessoryColor;
	UIColor *_highlightedColor;
}

@property (nonatomic, retain) UIColor *accessoryColor;
@property (nonatomic, retain) UIColor *highlightedColor;

+ (RecipeDisclosureIndicators *)accessoryWithColor:(UIColor *)color;

@end
