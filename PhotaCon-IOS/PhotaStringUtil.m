//
//  PhotaStringUtil.m
//  PhotaCon-IOS
//
//  Created by chenghao lin on 1/13/13.
//  Copyright (c) 2013 billionaire. All rights reserved.
//

#import "PhotaStringUtil.h"

@implementation PhotaStringUtil
//Check is a string is a valid email
+(BOOL)NSStringIsValidEmail:(NSString *)checkString {
    BOOL stricterFilter = YES; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}
@end
