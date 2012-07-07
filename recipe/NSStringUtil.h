//
//  NSStringUtil.h
//  recipe
//
//  Created by Vu Tran on 02/05/2012.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSStringUtil : NSObject

+ (Boolean)stringIsValidEmail:(NSString *)checkString;
+ (NSString *)formatDate:(NSDate*)date usingFormat:(NSString *)dateFormat;
+ (NSData*) encryptString:(NSString*)plaintext withKey:(NSString*)key;
+ (NSString*) decryptData:(NSData*)ciphertext withKey:(NSString*)key;

@end
