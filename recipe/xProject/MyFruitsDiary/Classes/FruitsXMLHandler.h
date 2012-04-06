//
//  FruitsXMLHandler.h
//  MyFruitsDiary
//
//  Created by Khoi Pham on 3/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BaseXMLHandler.h"
#import "MyFruitsDiaryGlobal.h"

@interface FruitsXMLHandler : BaseXMLHandler {
	Fruit*			_currentObject;
	NSMutableArray*	_fruitList;
}

-(id) initWithFruitList:(NSMutableArray*)fruitList;

@end
