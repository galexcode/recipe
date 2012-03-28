//
//  User.h
//  recipe
//
//  Created by ongsoft on 3/27/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject{
    NSString* _userId;
    NSString* _name;
    NSString* _password;
}

@property (nonatomic, retain) NSString *userId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *password;

@end
