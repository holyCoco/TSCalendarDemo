//
//  TSC_Logic.h
//  TS_Calendar
//
//  Created by zq on 16/4/5.
//  Copyright © 2016年 zhangqiang. All rights reserved.
//

#import "TSC_Constants.h"
#import <Foundation/Foundation.h>

#define LogicReturn_Date @"TSCReturnDate"
#define LogicReturn_DateComp @"TSCReturnDateComponents"

#define TSC_TIME_ADD_ZEROMATCH(baseTime) ([baseTime length] > 1 ? baseTime : [NSString stringWithFormat:@"0%@", baseTime])

typedef enum {
    TSCDateFormate_YMD = 0, //年月日
    TSCDateFormate_YMDHMS //年月日，时分秒
} TSCDateFormate;

@interface TSC_Logic : NSObject

+ (instancetype)getInstance;

/**
 *  根据YY-MM-DD hh:mm:ss获得标准格式（个位数的补成双位数）
 */
- (NSString*)timeMatchedString4Base:(NSString*)baseTimeStr;

/**
 *  根据yyyy-MM-dd格式获得NSDate和NSDateComponents
 */
- (NSDictionary*)dateInfo4FormateDateType:(TSCDateFormate)tscDateFormate andTimeMatchStr:(NSString*)timeMatchStr;

/**
 *  NSDate转换NSDateComps
 */
- (NSDateComponents*)dateCompoent4BaseDate:(NSDate*)baseDate andFormateDateType:(TSCDateFormate)tscDateFormate;

/**
 *  根据年月获得当月有几天
 */
- (int)getDaysNumberOfYear:(int)year andMonth:(int)month;
@end
