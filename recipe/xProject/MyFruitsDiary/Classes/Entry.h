//
//  Entry.h
//  MyFruitsDiary
//
//  Created by Khoi Pham on 3/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Entry : NSObject {
	NSString		*_entryId;
	NSDate			*_date;
	NSMutableArray	*_fruitBags;
}

@property (retain) NSString *entryId;
@property (nonatomic,retain) NSDate *date;
@property (nonatomic,retain) NSMutableArray* fruitBags;

-(id) initWithDate:(NSDate*)d;
-(NSString*) dateByStringWithFormat:(NSString*)format;
-(void) setDateByString: (NSString*)strDate withFormat:(NSString*)format;
-(NSString*) detailByString;
-(int) totalVitamins;

@end
