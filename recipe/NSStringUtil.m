//
//  NSStringUtil.m
//  recipe
//
//  Created by Vu Tran on 02/05/2012.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import "NSStringUtil.h"

@implementation NSStringUtil

+ (Boolean)stringIsValidEmail:(NSString *)checkString{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

@end
