//
//  NSStringUtil.m
//  recipe
//
//  Created by Vu Tran on 02/05/2012.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import "NSStringUtil.h"
#import "RNCryptor.h"

@implementation NSStringUtil

+ (Boolean)stringIsValidEmail:(NSString *)checkString{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

+ (NSString *)formatDate:(NSDate*)date usingFormat:(NSString *)dateFormat
{
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormat];
    [formatter setCalendar:cal];
    [formatter setLocale:[NSLocale currentLocale]];
    NSString *ret = [formatter stringFromDate:date];
    return ret;
}

+ (NSData*) encryptString:(NSString*)plaintext withKey:(NSString*)key {
    RNCryptor *cryptor = [RNCryptor AES256Cryptor];
    
    NSData *plainData = [plaintext dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    
    NSInputStream *encryptInputStream = [NSInputStream inputStreamWithData:plainData];
    NSOutputStream *encryptOutputStream = [NSOutputStream outputStreamToMemory];
    
    [cryptor encryptFromStream:encryptInputStream toStream:encryptOutputStream password:key error:&error];
    
    NSLog(@"Encrypt failed:%@", error);
    
    [encryptOutputStream close];
    [encryptInputStream close];
    
    NSData *encryptedData = [encryptOutputStream propertyForKey:NSStreamDataWrittenToMemoryStreamKey];
    
    return encryptedData;
}

+ (NSString*) decryptData:(NSData*)ciphertext withKey:(NSString*)key {
    RNCryptor *cryptor = [RNCryptor AES256Cryptor];
    
    NSError *error;
    
    NSInputStream *decryptInputStream = [NSInputStream inputStreamWithData:ciphertext];
    NSOutputStream *decryptOutputStream = [NSOutputStream outputStreamToMemory];
    
    [cryptor decryptFromStream:decryptInputStream toStream:decryptOutputStream password:key error:&error];
    
    NSLog(@"Decrypt failed:%@", error);
    
    [decryptOutputStream close];
    [decryptInputStream close];
    
    NSData *decryptedData = [decryptOutputStream propertyForKey:NSStreamDataWrittenToMemoryStreamKey];
    
    return [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
}

@end
