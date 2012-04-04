//
//  User.h
//  recipe
//
//  Created by Vu Tran on 3/27/12.
//  Copyright 2012 OngSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject{
    NSString* _userId;
    NSString* _name;
    NSString* _password;
}

@property (nonatomic) NSString *userId;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *password;

@end
