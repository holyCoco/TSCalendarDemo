//
//  TSC_Logic.m
//  TS_Calendar
//
//  Created by zq on 16/4/5.
//  Copyright © 2016年 zhangqiang. All rights reserved.
//

#import "TSC_Logic.h"

#define TSC_TIME_ADD_ZEROMATCH(baseTime) ([baseTime length] > 1 ? baseTime : [NSString stringWithFormat:@"0%@", baseTime])

@interface TSC_Logic () {
}
@property (nonatomic, retain) NSDictionary* dateFormateDic;
@end

@implementation TSC_Logic

+ (instancetype)getInstance
{
    static TSC_Logic* _instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [TSC_Logic new];
    });
    return _instance;
}

/**
 *  根据YY-MM-DD hh:mm:ss获得标准格式（个位数的补成双位数）
 */
- (NSString*)timeMatchedString4Base:(NSString*)baseTimeStr
{
    NSArray* allTimesCompoents = [baseTimeStr componentsSeparatedByString:@" "];
    if (allTimesCompoents.count == 1) {
        NSString* ymdStr = [allTimesCompoents firstObject];
        NSArray* ymdCompoents = [ymdStr componentsSeparatedByString:@"-"];
        if (ymdCompoents.count == 3) {
            return TSCString_Format(@"%@-%@-%@ 00:00:00",
                [ymdCompoents objectAtIndex:0],
                TSC_TIME_ADD_ZEROMATCH([ymdCompoents objectAtIndex:1]),
                TSC_TIME_ADD_ZEROMATCH([ymdCompoents objectAtIndex:2]));
        }
    }
    else if (allTimesCompoents.count == 2) {
        NSArray* ymdCompoents = [[allTimesCompoents firstObject] componentsSeparatedByString:@"-"];
        NSArray* hmsCompoents = [[allTimesCompoents objectAtIndex:1] componentsSeparatedByString:@":"];
        if (ymdCompoents.count == 3 && hmsCompoents.count == 3) {
            return TSCString_Format(@"%@-%@-%@ %@:%@:%@",
                [ymdCompoents objectAtIndex:0],
                TSC_TIME_ADD_ZEROMATCH([ymdCompoents objectAtIndex:1]),
                TSC_TIME_ADD_ZEROMATCH([ymdCompoents objectAtIndex:2]),
                TSC_TIME_ADD_ZEROMATCH([hmsCompoents objectAtIndex:0]),
                TSC_TIME_ADD_ZEROMATCH([hmsCompoents objectAtIndex:1]),
                TSC_TIME_ADD_ZEROMATCH([hmsCompoents objectAtIndex:2]));
        }
    }
    return baseTimeStr;
}

/**
 *  根据yyyy-MM-dd格式获得NSDate和NSDateComponents
 */
- (NSDictionary*)dateInfo4FormateDateType:(TSCDateFormate)tscDateFormate andTimeMatchStr:(NSString*)timeMatchStr
{
    timeMatchStr = [self timeMatchedString4Base:timeMatchStr];
    if (tscDateFormate == TSCDateFormate_YMD) {
        timeMatchStr = [[timeMatchStr componentsSeparatedByString:@" "] firstObject];
    }
    NSString* dateFormateStr = [self.dateFormateDic objectForKey:[NSString stringWithFormat:@"%d", (int)tscDateFormate]];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:dateFormateStr];

    //translate to NSDate(solve the 8 hours!)
    NSDate* nowDate = [formatter dateFromString:timeMatchStr];
    NSTimeZone* zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:nowDate];
    nowDate = [nowDate dateByAddingTimeInterval:interval];
    //Date转换DateComps
    NSDateComponents* dateComp = [self dateCompoent4BaseDate:nowDate andFormateDateType:tscDateFormate];
    //    NSLog(@"date==%@\ndateComp==%@", nowDate, dateComp);
    return @{ LogicReturn_Date : nowDate,
        LogicReturn_DateComp : dateComp };
}

/**
 *  NSDate转换NSDateComps
 */
- (NSDateComponents*)dateCompoent4BaseDate:(NSDate*)baseDate andFormateDateType:(TSCDateFormate)tscDateFormate
{
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    if ((int)tscDateFormate == TSCDateFormate_YMDHMS) {
        unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitTimeZone;
    }
    NSDateComponents* dateComp = [calendar components:unitFlags fromDate:baseDate];
    return dateComp;
}

/**
 *  根据年月获得当月有几天
 */
- (int)getDaysNumberOfYear:(int)year andMonth:(int)month
{
    NSDictionary* dateInfoDic = [self dateInfo4FormateDateType:TSCDateFormate_YMD andTimeMatchStr:TSCString_Format(@"%d-%d-%d", year, month, 1)];
    NSDate* date = [dateInfoDic objectForKey:LogicReturn_Date];
    NSCalendar* c = [NSCalendar currentCalendar];
    NSRange days = [c rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return (int)days.length;
}

#pragma mark------------------LazyLoading-------------------
- (NSDictionary*)dateFormateDic
{
    if (_dateFormateDic == nil) {
        _dateFormateDic = @{ TSCString_Format(@"%d", (int)TSCDateFormate_YMD) : @"yyyy-MM-dd",
            TSCString_Format(@"%d", (int)TSCDateFormate_YMDHMS) : @"yyyy-MM-dd HH:mm:ss" };
    }
    return _dateFormateDic;
}
@end
