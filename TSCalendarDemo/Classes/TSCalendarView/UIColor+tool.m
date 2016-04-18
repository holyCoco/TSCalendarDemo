//
//  UIColor+tool.m
//  TSCalendarDemo
//
//  Created by zq on 16/4/18.
//  Copyright © 2016年 zhangqiang. All rights reserved.
//

#import "UIColor+tool.h"

@implementation UIColor (tool)

+ (UIColor*)colorWithHexRGB:(NSUInteger)hexRGB
{
    return [UIColor colorWithIntegerRed:((hexRGB & 0xFF0000) >> 16) green:((hexRGB & 0x00FF00) >> 8) blue:(hexRGB & 0x0000FF) alpha:1.0f];
}

+ (UIColor*)colorForHex:(NSString*)hexColor
{
    hexColor = [[hexColor stringByTrimmingCharactersInSet:
                              [NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];

    // String should be 6 or 7 characters if it includes '#'
    if ([hexColor length] < 6)
        return [UIColor blackColor];

    // strip # if it appears
    if ([hexColor hasPrefix:@"#"])
        hexColor = [hexColor substringFromIndex:1];

    // if the value isn't 6 characters at this point return
    // the color black
    if ([hexColor length] != 6)
        return [UIColor blackColor];

    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;

    NSString* rString = [hexColor substringWithRange:range];

    range.location = 2;
    NSString* gString = [hexColor substringWithRange:range];

    range.location = 4;
    NSString* bString = [hexColor substringWithRange:range];

    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];

    return [UIColor colorWithRed:((float)r / 255.0f)
                           green:((float)g / 255.0f)
                            blue:((float)b / 255.0f)
                           alpha:1.0f];
}

+ (UIColor*)colorWithIntegerRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:red / 255.0f green:green / 255.0f blue:blue / 255.0f alpha:alpha];
}

@end
