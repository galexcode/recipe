//
//  FruitBag.h
//  MyFruitsDiary
//
//  Created by Khoi Pham on 3/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "Fruit.h"

@interface FruitBag : NSObject {
	int			_count;
	Fruit		*_fruit;
}

@property (nonatomic) int count;
@property (nonatomic,retain) Fruit* fruit;

-(id) initWithCount:(int)c andFruit:(Fruit*)fr;
-(int) totalVitamins;
@end
