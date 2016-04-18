//
//  UIColor+tool.h
//  TSCalendarDemo
//
//  Created by zq on 16/4/18.
//  Copyright © 2016年 zhangqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (tool)

+ (UIColor*)colorWithHexRGB:(NSUInteger)hexRGB;
+ (UIColor*)colorForHex:(NSString*)hexColor;

@end
