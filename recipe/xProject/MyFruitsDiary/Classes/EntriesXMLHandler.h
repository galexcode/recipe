//
//  EntriesXMLHandler.h
//  MyFruitsDiary
//
//  Created by Khoi Pham on 3/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BaseXMLHandler.h"
#import "MyFruitsDiaryGlobal.h"

@interface EntriesXMLHandler : BaseXMLHandler {
	NSMutableArray*		_fruitList;
	NSMutableArray*		_entriesList;
	Entry*				_currentEntry;
	FruitBag*			_currentFruitBag;
	
}

-(id) initWithEntriesList:(NSMutableArray*)entriesList andFruitList:(NSMutableArray*)fruitList;


@end
