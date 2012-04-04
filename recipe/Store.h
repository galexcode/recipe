//
//  Store.h
//  recipe
//
//  Created by ongsoft on 3/27/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Store : NSObject{
    NSString* _storeId;
    NSString* _name;
    NSString* _desc;
    CLLocationCoordinate2D _location;
}

@property (nonatomic) NSString *storeId;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *desc;
@property (nonatomic) CLLocationCoordinate2D location;

@end
