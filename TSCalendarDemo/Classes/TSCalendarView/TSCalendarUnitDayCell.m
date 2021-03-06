//
//  TSCalendarUnitDayCell.m
//  TS_Calendar
//
//  Created by zq on 16/4/11.
//  Copyright © 2016年 zhangqiang. All rights reserved.
//

#import "TSCalendarUnitDayCell.h"

@interface TSCalendarUnitDayCell () {
}
@property (nonatomic, retain) UIImageView* selectBackgroundView;
@end

@implementation TSCalendarUnitDayCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.selectBackgroundView];
        [self.contentView addSubview:self.dayLabel];
        [self.contentView addSubview:self.lunarDayLabel];

        float unitH = self.frame.size.height;
        float unitW = self.frame.size.width;

        if (![self.contentView viewWithTag:1234]) {
            UILabel* line1 = [[UILabel alloc] initWithFrame:CGRectMake(0, unitH - 0.5, unitW, 0.5)];
            [line1 setBackgroundColor:kColor_Line_Color];
            line1.tag = 1234;
            [self.contentView addSubview:line1];
            UILabel* line2 = [[UILabel alloc] initWithFrame:CGRectMake(unitW - 0.5, 0, 0.5, unitH)];
            [line2 setBackgroundColor:kColor_Line_Color];
            line2.tag = 1235;
            [self.contentView addSubview:line2];
        }
    }
    return self;
}

/**
 *  重新设置年月日model以及显示
 */
- (void)resetModelAndDateShowText
{
    TSCalendarUnitDateModel* unitDateModel = [TSCalendarUnitDateModel createWithSufaceYear:self.sufaceYear andSufaceMonth:self.sufaceMonth andSufaceDay:self.sufaceDay];
    self.unitDateModel = unitDateModel;
    //    self.dayLabel.text = TSCString_Format(@"%d-\n%d-%d", unitDateModel.year, unitDateModel.month, unitDateModel.day);
    self.dayLabel.text = TSCString_Format(@"%d", unitDateModel.day);
    self.userInteractionEnabled = unitDateModel.isBelongToThisMonth;
    self.backgroundColor = unitDateModel.isBelongToThisMonth ? self.dayBackgroundColor : self.modBackgroundColor;
    self.dayLabel.textColor = unitDateModel.isBelongToThisMonth ? self.dayTitleColor : self.modTitleColor;
    self.lunarDayLabel.textColor = unitDateModel.isBelongToThisMonth ? self.daySubTitleColor : self.modTitleColor;
    self.lunarDayLabel.text = @"初一";
}

#pragma mark------------------ Setter -------------------
- (void)setDayLayoutType:(TSCalendarDaysLayoutType)dayLayoutType //设置单天样式
{
    if (dayLayoutType != 0 && _dayLayoutType == dayLayoutType) {
        return;
    }
    _dayLayoutType = dayLayoutType;
    self.dayLabel.hidden = YES;
    self.lunarDayLabel.hidden = YES;
    if (dayLayoutType == TSCalendarDaysLayoutType_Default) {
        self.dayLabel.hidden = NO;
        [self.dayLabel setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }
    else if (dayLayoutType == TSCalendarDaysLayoutType_Lunar) {
        self.dayLabel.hidden = NO;
        self.lunarDayLabel.hidden = NO;
        [self.dayLabel setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height * (3 / 5.0))];
        [self.lunarDayLabel setFrame:CGRectMake(0, self.frame.size.height * (3 / 5.0), self.frame.size.width, self.frame.size.height * (2 / 5.0))];
    }
}
- (void)setIsTSC_UnitDayViewSelected:(BOOL)isTSC_UnitDayViewSelected //设置是否选中的操作
{
    if (self.userInteractionEnabled == NO || _isTSC_UnitDayViewSelected == isTSC_UnitDayViewSelected) {
        return;
    }
    _isTSC_UnitDayViewSelected = isTSC_UnitDayViewSelected;
    if (self.daySelectBGType == TSCalendarDaySelectedBGType_Rectangle) {
        self.backgroundColor = isTSC_UnitDayViewSelected ? self.daySelectedBackgroundColor : (self.dayBackgroundColor ? self.dayBackgroundColor : [UIColor whiteColor]);
    }
    else if (self.daySelectBGType == TSCalendarDaySelectedBGType_StrokeCircle) {
        self.selectBackgroundView.layer.borderColor = isTSC_UnitDayViewSelected ? self.daySelectedBackgroundColor.CGColor : (self.dayBackgroundColor.CGColor ? self.dayBackgroundColor.CGColor : [UIColor whiteColor].CGColor);
    }
    else if (self.daySelectBGType == TSCalendarDaySelectedBGType_FilledCircle) {
        self.selectBackgroundView.backgroundColor = isTSC_UnitDayViewSelected ? self.daySelectedBackgroundColor : (self.dayBackgroundColor ? self.dayBackgroundColor : [UIColor whiteColor]);
    }

    if (self.dayLayoutType == TSCalendarDaysLayoutType_Default) {
        self.dayLabel.isSelected4TSC = isTSC_UnitDayViewSelected;
    }
    else if (self.dayLayoutType == TSCalendarDaysLayoutType_Lunar) {
        self.dayLabel.isSelected4TSC = isTSC_UnitDayViewSelected;
        self.lunarDayLabel.isSelected4TSC = isTSC_UnitDayViewSelected;
    }
}
- (void)setDaySelectBGType:(TSCalendarDaySelectedBGType)daySelectBGType
{
    _daySelectBGType = daySelectBGType;
    if (daySelectBGType == TSCalendarDaySelectedBGType_Rectangle) {
        self.selectBackgroundView.hidden = YES;
    }
    else if (daySelectBGType == TSCalendarDaySelectedBGType_FilledCircle) {
        self.selectBackgroundView.hidden = NO;
        self.selectBackgroundView.layer.cornerRadius = self.selectBackgroundView.frame.size.width / 2.0;
        self.selectBackgroundView.layer.borderWidth = 0;
    }
    else if (daySelectBGType == TSCalendarDaySelectedBGType_StrokeCircle) {
        self.selectBackgroundView.hidden = NO;
        self.selectBackgroundView.layer.cornerRadius = self.selectBackgroundView.frame.size.width / 2.0;
        self.selectBackgroundView.backgroundColor = [UIColor clearColor];
        self.selectBackgroundView.layer.borderWidth = 1.5;
        self.selectBackgroundView.layer.borderColor = [UIColor clearColor].CGColor;
    }
}
- (void)setDayTitleColor:(UIColor*)dayTitleColor
{
    _dayTitleColor = dayTitleColor;
    self.dayLabel.defaultTextColor = dayTitleColor;
}
- (void)setDaySubTitleColor:(UIColor*)daySubTitleColor
{
    _daySubTitleColor = daySubTitleColor;
    self.lunarDayLabel.defaultTextColor = daySubTitleColor;
}
- (void)setDaySelectedTitleColor:(UIColor*)daySelectedTitleColor
{
    _daySelectedTitleColor = daySelectedTitleColor;
    self.dayLabel.selectTextColor = daySelectedTitleColor;
}
- (void)setDaySelectedSubTitleColor:(UIColor*)daySelectedSubTitleColor
{
    _daySelectedSubTitleColor = daySelectedSubTitleColor;
    self.lunarDayLabel.selectTextColor = daySelectedSubTitleColor;
}
- (void)setDayBackgroundColor:(UIColor*)dayBackgroundColor
{
    _dayBackgroundColor = dayBackgroundColor;
    self.backgroundColor = dayBackgroundColor;
}
- (void)setIsShowDayBorderLine:(BOOL)isShowDayBorderLine
{
    _isShowDayBorderLine = isShowDayBorderLine;
    UIView* border1 = [self.contentView viewWithTag:1234];
    border1.hidden = !isShowDayBorderLine;
    UIView* border2 = [self.contentView viewWithTag:1235];
    border2.hidden = !isShowDayBorderLine;
}
- (void)setBorderLineColor:(UIColor*)borderLineColor
{
    _borderLineColor = borderLineColor;
    UIView* border1 = [self.contentView viewWithTag:1234];
    UIView* border2 = [self.contentView viewWithTag:1235];
    border1.backgroundColor = borderLineColor;
    border2.backgroundColor = borderLineColor;
}
#pragma mark------------------LazyLoading-------------------
- (UIImageView*)selectBackgroundView
{
    if (_selectBackgroundView == nil) {
        _selectBackgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width)];
        _selectBackgroundView.backgroundColor = [UIColor clearColor];
        _selectBackgroundView.bounds = CGRectMake(0, 0, _selectBackgroundView.frame.size.width / 5.0 * 4.0, _selectBackgroundView.frame.size.width / 5.0 * 4.0);
    }
    return _selectBackgroundView;
}
- (TSC_DaySelectableLabel*)dayLabel
{
    if (_dayLabel == nil) {
        _dayLabel = [[TSC_DaySelectableLabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height / 2.0)];
        _dayLabel.defaultTextColor = self.dayTitleColor;
        _dayLabel.selectTextColor = self.daySelectedTitleColor;
        _dayLabel.isSelected4TSC = NO;
        _dayLabel.font = [UIFont systemFontOfSize:15.0];
        _dayLabel.adjustsFontSizeToFitWidth = YES;
        _dayLabel.minimumScaleFactor = 0.3;
        _dayLabel.numberOfLines = 3;
    }
    return _dayLabel;
}
- (TSC_DaySelectableLabel*)lunarDayLabel
{
    if (_lunarDayLabel == nil) {
        _lunarDayLabel = [[TSC_DaySelectableLabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height / 2.0, self.frame.size.width, self.frame.size.height / 2.0)];
        _lunarDayLabel.defaultTextColor = self.daySubTitleColor;
        _lunarDayLabel.selectTextColor = self.daySelectedSubTitleColor;
        _lunarDayLabel.isSelected4TSC = NO;
        _lunarDayLabel.font = [UIFont systemFontOfSize:10.0];
        _lunarDayLabel.minimumScaleFactor = 0.3;
    }
    return _lunarDayLabel;
}

@end
