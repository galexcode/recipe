//
//  Fruit.h
//  MyFruitsDiary
//
//  Created by Khoi Pham on 3/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Fruit : NSObject {
	NSString*	_fruitId;
	int			_vitamins;
	NSString	*_name;
	NSData		*_image;
	NSString	*_imageURL;
	NSString	*_type;
}

@property (nonatomic, retain) NSString* fruitId;
@property (nonatomic) int vitamins;
@property (nonatomic,retain) NSString* name;
@property (retain) NSString* imageURL;
@property (retain) NSData*  image;
@property (nonatomic,retain) NSString* type;

-(id) initWithId:(NSString*)frId vitamins:(int)vitamins name:(NSString*)name img:(NSString*)imageName andType:(NSString*)type;
@end
