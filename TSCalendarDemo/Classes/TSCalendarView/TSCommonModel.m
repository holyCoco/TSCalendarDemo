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

@implementation TSCommonModel
@end

@interface TSCalendarDaysLayoutModel () {
}
@property (nonatomic, retain) NSDictionary* defaultSettingDic;
@end
@implementation TSCalendarDaysLayoutModel

- (void)doSetPropertyDefaultValueWithPname:(NSString*)proptyName andSettedValue:(id)settedValue
{
    u_int count;
    objc_property_t* properties = class_copyPropertyList([TSCalendarDaysLayoutModel class], &count);
    for (int i = 0; i < count; i++) {
        const char* pName = property_getName(properties[i]);
        NSString* propertyName = [NSString stringWithUTF8String:pName];
        if ([propertyName isEqualToString:proptyName]) {
            if (([settedValue isKindOfClass:[NSNumber class]] && [settedValue floatValue] == 0)
                || settedValue == nil) {
                if ([proptyName rangeOfString:@"Color"].location != NSNotFound) { //默认属性是颜色，需要转换
                    [self setValue:[UIColor colorForHex:[self.defaultSettingDic objectForKey:proptyName]] forKey:proptyName];
                }
                else { //默认属性是字符串或者数字
                    [self setValue:[self.defaultSettingDic objectForKey:proptyName] forKey:proptyName];
                }
            }
            return;
        }
    }
}

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
            dLayoutType : @(TSCalendarDaysLayoutType_Default)
        };
    }
    return _defaultSettingDic;
}

- (void)setWidth:(float)width
{
    if (_width != 0 && _width == width) {
        return;
    }
    _width = width;
    [self doSetPropertyDefaultValueWithPname:dWidth andSettedValue:@(width)];
}
- (void)setHeight:(float)height
{
    if (_height != 0 && _height == height) {
        return;
    }
    _height = height;
    [self doSetPropertyDefaultValueWithPname:dHeight andSettedValue:@(height)];
}
- (void)setTitleColor:(UIColor*)titleColor
{
    if (_titleColor && _titleColor == titleColor) {
        return;
    }
    _titleColor = titleColor;
    [self doSetPropertyDefaultValueWithPname:dTitleColor andSettedValue:titleColor];
}
- (void)setSubTitleColor:(UIColor*)subTitleColor
{
    if (_subTitleColor && _subTitleColor == subTitleColor) {
        return;
    }
    _subTitleColor = subTitleColor;
    [self doSetPropertyDefaultValueWithPname:dSubTitleColor andSettedValue:subTitleColor];
}
- (void)setBackgroundColor:(UIColor*)backgroundColor
{
    if (_backgroundColor && _backgroundColor == backgroundColor) {
        return;
    }
    _backgroundColor = backgroundColor;
    [self doSetPropertyDefaultValueWithPname:dBackgroundColor andSettedValue:backgroundColor];
}
- (void)setSelectedTitleColor:(UIColor*)selectedTitleColor
{
    if (_selectedTitleColor && _selectedTitleColor == selectedTitleColor) {
        return;
    }
    _selectedTitleColor = selectedTitleColor;
    [self doSetPropertyDefaultValueWithPname:dSelectedTitleColor andSettedValue:selectedTitleColor];
}
- (void)setSelectedSubTitleColor:(UIColor*)selectedSubTitleColor
{
    if (_selectedSubTitleColor && _selectedSubTitleColor == selectedSubTitleColor) {
        return;
    }
    _selectedSubTitleColor = selectedSubTitleColor;
    [self doSetPropertyDefaultValueWithPname:dSelectedSubTitleColor andSettedValue:selectedSubTitleColor];
}
- (void)setSelectedBackgroundColor:(UIColor*)selectedBackgroundColor
{
    if (_selectedBackgroundColor && _selectedBackgroundColor == selectedBackgroundColor) {
        return;
    }
    _selectedBackgroundColor = selectedBackgroundColor;
    [self doSetPropertyDefaultValueWithPname:dSelectedBackgroundColor andSettedValue:selectedBackgroundColor];
}
- (void)setLayoutType:(TSCalendarDaysLayoutType)layoutType
{
    if (_layoutType == layoutType) {
        return;
    }
    _layoutType = layoutType;
    [self doSetPropertyDefaultValueWithPname:dLayoutType andSettedValue:@(layoutType)];
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
    int nextMonthDaysNumber = [[TSC_Logic getInstance]
        getDaysNumberOfYear:nextMonthYear
                   andMonth:nextMonth];
    int tempNum1 = monthFirstDayWeekday + currentMonthDaysNumber;

    //当前这个月需要的格子数
    int currentMonthNeededGridNum = ((tempNum1 / 7) + ((tempNum1 % 7) == 0 ? 0 : 1)) * 7;
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