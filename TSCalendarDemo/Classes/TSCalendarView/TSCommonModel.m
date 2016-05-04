//
//  TSCommonModel.m
//  TS_Calendar
//
//  Created by zq on 16/3/30.
//  Copyright © 2016年 zhangqiang. All rights reserved.
//
#import "TSCommonModel.h"
#import "UIColor+tool.h"

static NSString* dWidth = @"width";
static NSString* dHeight = @"height";
static NSString* dTitleColor = @"titleColor";
static NSString* dSubTitleColor = @"subTitleColor";
static NSString* dBackgroundColor = @"backgroundColor";
static NSString* dSelectedTitleColor = @"selectedTitleColor";
static NSString* dSelectedSubTitleColor = @"selectedSubTitleColor";
static NSString* dSelectedBackgroundColor = @"selectedBackgroundColor";
static NSString* dLayoutType = @"layoutType";
static NSString* dModTitleColor = @"modTitleColor"; //月份中不可选中的天的字体颜色 Mod = month other days
static NSString* dModBackColor = @"modBackColor";
static NSString* dISShowDayBorderLine = @"isShowUDayBorderLine";
static NSString* dBorderLineColor = @"borderLineColor";

@implementation TSCommonModel
@end

@interface TSCalendarDaysLayoutModel () {
}
@property (nonatomic, retain) NSDictionary* defaultSettingDic;
@end
@implementation TSCalendarDaysLayoutModel

- (NSDictionary*)defaultSettingDic
{
    if (_defaultSettingDic == nil) {
        _defaultSettingDic = @{
            dWidth : @([UIScreen mainScreen].bounds.size.width / 7.0),
            dHeight : @([UIScreen mainScreen].bounds.size.width / 7.0),
            dTitleColor : @"000000", //[UIColor blackColor],
            dSubTitleColor : @"acacac", //[UIColor grayColor],
            dBackgroundColor : @"ffffff", //[UIColor whiteColor],
            dSelectedTitleColor : @"ffffff", //[UIColor whiteColor],
            dSelectedSubTitleColor : @"ffffff", //[UIColor whiteColor],
            dSelectedBackgroundColor : @"000000", //[UIColor blackColor],
            dLayoutType : @(TSCalendarDaysLayoutType_Default),
            dModTitleColor : @"707070", //月份中不可选中的天的字体颜色 Mod = month other days
            dModBackColor : @"ececec",
            dISShowDayBorderLine : @(0),
            dBorderLineColor : @"d3d3d3"
        };
    }
    return _defaultSettingDic;
}

- (id)getDefaultValueWithPropertyName:(NSString*)ptyName
{
    id defaultValue = [self.defaultSettingDic objectForKey:ptyName];
    if ([ptyName rangeOfString:@"Color"].location != NSNotFound) { //此属性是颜色，需要转换
        defaultValue = [UIColor colorForHex:TSCString_Format(@"%@", defaultValue)];
    }
    return defaultValue;
}
#pragma mark------------------TSCalendarDaysLayoutModel--->LazyLoading-------------------
- (float)width
{
    if (_width == 0) {
        _width = [[self getDefaultValueWithPropertyName:dWidth] floatValue];
    }
    return _width;
}
- (float)height
{
    if (_height == 0) {
        _height = [[self getDefaultValueWithPropertyName:dHeight] floatValue];
    }
    return _height;
}
- (UIColor*)titleColor
{
    if (_titleColor == nil) {
        _titleColor = [self getDefaultValueWithPropertyName:dTitleColor];
    }
    return _titleColor;
}
- (UIColor*)subTitleColor
{
    if (_subTitleColor == nil) {
        _subTitleColor = [self getDefaultValueWithPropertyName:dSubTitleColor];
    }
    return _subTitleColor;
}
- (UIColor*)backgroundColor
{
    if (_backgroundColor == nil) {
        _backgroundColor = [self getDefaultValueWithPropertyName:dBackgroundColor];
    }
    return _backgroundColor;
}
- (UIColor*)selectedTitleColor
{
    if (_selectedTitleColor == nil) {
        _selectedTitleColor = [self getDefaultValueWithPropertyName:dSelectedTitleColor];
    }
    return _selectedTitleColor;
}
- (UIColor*)selectedSubTitleColor
{
    if (_selectedSubTitleColor == nil) {
        _selectedSubTitleColor = [self getDefaultValueWithPropertyName:dSelectedSubTitleColor];
    }
    return _selectedSubTitleColor;
}
- (UIColor*)selectedBackgroundColor
{
    if (_selectedBackgroundColor == nil) {
        _selectedBackgroundColor = [self getDefaultValueWithPropertyName:dSelectedBackgroundColor];
    }
    return _selectedBackgroundColor;
}
- (UIColor*)modBackColor
{
    if (_modBackColor == nil) {
        _modBackColor = [self getDefaultValueWithPropertyName:dModBackColor];
    }
    return _modBackColor;
}
- (UIColor*)modTitleColor
{
    if (_modTitleColor == nil) {
        _modTitleColor = [self getDefaultValueWithPropertyName:dModTitleColor];
    }
    return _modTitleColor;
}
- (UIColor*)borderLineColor
{
    if (_borderLineColor == nil) {
        _borderLineColor = [self getDefaultValueWithPropertyName:dBorderLineColor];
    }
    return _borderLineColor;
}
@end

@implementation TSCalendarUnitDateModel
+ (instancetype)createWithSufaceYear:(int)sufaceYear andSufaceMonth:(int)sufaceMonth andSufaceDay:(int)sufaceDay
{
    TSCalendarUnitDateModel* model = [[TSCalendarUnitDateModel alloc] init];
    NSString* jointTimeStr = [NSString stringWithFormat:@"%d-%d-%d", sufaceYear, sufaceMonth, 1];
    NSDictionary* dateInfoDic = [[TSC_Logic getInstance] dateInfo4FormateDateType:TSCDateFormate_YMDHMS andTimeMatchStr:jointTimeStr];
    NSDateComponents* resultDateComps = [dateInfoDic objectForKey:LogicReturn_DateComp];
    //上个月，下个月的------年月
    int lastMonthYear = (sufaceMonth == 1 ? (sufaceYear - 1) : sufaceYear); //上个月--年
    int lastMonth = (sufaceMonth == 1 ? 12 : (sufaceMonth - 1)); //上个月
    int nextMonthYear = (sufaceMonth == 12 ? (sufaceYear + 1) : sufaceYear); //下个月--年
    int nextMonth = (sufaceMonth == 12 ? 1 : (sufaceMonth + 1)); //下个月

    int monthFirstDayWeekday = (int)resultDateComps.weekday;
    int lastMonthDaysNumber = [[TSC_Logic getInstance]
        getDaysNumberOfYear:lastMonthYear
                   andMonth:lastMonth];
    int currentMonthDaysNumber = [[TSC_Logic getInstance] getDaysNumberOfYear:sufaceYear andMonth:sufaceMonth];
    //当前这个月需要的格子数
    //    int currentMonthNeededGridNum = ((tempNum1 / 7) + ((tempNum1 % 7) == 0 ? 0 : 1)) * 7;
    if ((sufaceDay + 1) < monthFirstDayWeekday) { //上个月
        model.year = lastMonthYear;
        model.month = lastMonth;
        model.day = lastMonthDaysNumber - (monthFirstDayWeekday - (sufaceDay + 2));
    }
    else if ((sufaceDay + 1) > (currentMonthDaysNumber + monthFirstDayWeekday - 1)) //下个月
    {
        model.year = nextMonthYear;
        model.month = nextMonth;
        model.day = ((sufaceDay + 1) - (currentMonthDaysNumber + monthFirstDayWeekday - 1));
    }
    else {
        model.year = sufaceYear;
        model.month = sufaceMonth;
        model.day = (sufaceDay + 1) - (monthFirstDayWeekday - 1);
    }
    model.isBelongToThisMonth = (model.year == sufaceYear && model.month == sufaceMonth);
    return model;
}

@end