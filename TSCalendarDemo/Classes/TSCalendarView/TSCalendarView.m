//
//  TSCalendarView.m
//  TS_Calendar
//
//  Created by zq on 16/4/11.
//  Copyright © 2016年 zhangqiang. All rights reserved.
//

#import "TSCalendarView.h"
#import "TSCommonModel.h"
#import "UIView+tool.h"

@interface TSCalendarView () <ZQCollectionViewDelegate> {
    NSIndexPath* _lastSelectIndexPath;
    UICollectionView* _calendarCollectionView;
    float _unitW, _unitH;
}
@property (nonatomic, retain) TS_CollectionView* mCollectionView;
@property (nonatomic, retain) TSCalendarDaysLayoutModel* daysLayoutModel;
@end

@implementation TSCalendarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.mCollectionView];
        _unitW = self.mCollectionView.frame.size.width / 7.0;
        _unitH = self.mCollectionView.frame.size.height / 6.0;
    }
    return self;
}

#pragma mark------------------ZQCollection.Delegate-------------------
- (NSInteger)qNumberOfSectionsInCollectionView:(UICollectionView*)collection
{
    return 1200;
}
- (UICollectionViewCell*)qCollectionView:(UICollectionView*)collectionView
                  cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    TSCalendarUnitDayCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:QCollectionCellReuseIdentity forIndexPath:indexPath];
    //=============布局设置
    cell.dayLayoutType = self.daysLayoutModel.layoutType;
    cell.dayTitleColor = self.daysLayoutModel.titleColor;
    cell.daySubTitleColor = self.daysLayoutModel.subTitleColor;
    cell.daySelectedTitleColor = self.daysLayoutModel.selectedTitleColor;
    cell.daySelectedSubTitleColor = self.daysLayoutModel.selectedSubTitleColor;
    cell.daySelectedBackgroundColor = self.daysLayoutModel.selectedBackgroundColor;
    cell.daySelectBGType = self.daysLayoutModel.daySelectedBGType;
    cell.dayBackgroundColor = self.daysLayoutModel.backgroundColor;
    cell.modTitleColor = self.daysLayoutModel.modTitleColor;
    cell.modBackgroundColor = self.daysLayoutModel.modBackColor;
    cell.isShowDayBorderLine = self.daysLayoutModel.isShowUDayBorderLine;
    cell.borderLineColor = self.daysLayoutModel.borderLineColor;
    //============= 年月日设置
    cell.sufaceYear = TSC_START_YEAR + (int)indexPath.section / 12;
    cell.sufaceMonth = (int)indexPath.section % 12 + 1;
    cell.sufaceDay = (int)indexPath.row;
    [cell resetModelAndDateShowText];
    cell.isTSC_UnitDayViewSelected = NO; //没有选中

    //选中的不能因为重用给变了颜色
    if (_lastSelectIndexPath) {
        [self doSelectUICalendarViewUnitDay:_lastSelectIndexPath andCollectionView:collectionView];
    }
    return cell;
}
- (void)qCollectionView:(UICollectionView*)collectionView didSelectItemAtIndexPath:(NSIndexPath*)indexPath
{
    NSLog(@"lastSection===%d", (int)indexPath.section);
    if (_lastSelectIndexPath) {
        TSCalendarUnitDayCell* lastCell = (TSCalendarUnitDayCell*)[collectionView cellForItemAtIndexPath:_lastSelectIndexPath];
        lastCell.isTSC_UnitDayViewSelected = NO;
    }
    TSCalendarUnitDayCell* cell = [self doSelectUICalendarViewUnitDay:indexPath andCollectionView:collectionView];
    _lastSelectIndexPath = indexPath;
    //======== CalendarDalegate.SelectDate
    if (self.delegate && [self.delegate respondsToSelector:@selector(calendarDidSelectItemModel:andIndexPath:)]) {
        [self.delegate calendarDidSelectItemModel:cell.unitDateModel andIndexPath:indexPath];
    }
}

#pragma mark------------------ScrollView.Delegate-------------------
- (void)qScrollViewDidScroll:(UIScrollView*)scrollView
{
}
- (void)qScrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
    [self resetCollectionViewHeightWithScroll:scrollView];
    int pageNum = scrollView.contentOffset.x / scrollView.frame.size.width;
    int year = TSC_START_YEAR + (pageNum + 1) / 12 + ((pageNum + 1) % 12 > 0 ? 1 : 0) - 1;
    int month = pageNum % 12 + 1;
    if (self.delegate && [self.delegate respondsToSelector:@selector(calendarCurrentMonth:andYear:)]) {
        [self.delegate calendarCurrentMonth:month andYear:year];
    }
}
- (void)qScrollViewDidEndScrollingAnimation:(UIScrollView*)scrollView
{
    [self resetCollectionViewHeightWithScroll:scrollView];
}

#pragma mark------------------Operate-------------------
- (TSCalendarUnitDayCell*)doSelectUICalendarViewUnitDay:(NSIndexPath*)selectIndex andCollectionView:(UICollectionView*)collectionV
{
    TSCalendarUnitDayCell* selectCell = (TSCalendarUnitDayCell*)[collectionV cellForItemAtIndexPath:selectIndex];
    selectCell.isTSC_UnitDayViewSelected = YES;
    return selectCell;
}
#pragma mark------------------SomeLogic-------------------
- (void)resetCollectionViewHeightWithScroll:(UIScrollView*)scrollView
{
    int section = scrollView.contentOffset.x / scrollView.frame.size.width;
    int year = TSC_START_YEAR + section / 12;
    int month = section % 12 + 1;
    int numbers4Month = [[TSC_Logic getInstance] getDaysNumberOfYear:year andMonth:month];
    int firstMonthDayWeekday = (int)[(NSDateComponents*)[[[TSC_Logic getInstance] dateInfo4FormateDateType:TSCDateFormate_YMDHMS andTimeMatchStr:TSCString_Format(@"%d-%d-1", year, month)] objectForKey:LogicReturn_DateComp] weekday];
    int tempNum = firstMonthDayWeekday + numbers4Month - 1;
    int occupyNumbersInMonth = (tempNum / 7 + (tempNum % 7 == 0 ? 0 : 1)) * 7;
    int occupyLinesInMonth = occupyNumbersInMonth / 7;
    //    float newHeight = occupyLinesInMonth * (self.frame.size.height / 6.0);
    float newHeight = occupyLinesInMonth * _unitH;
    [self.mCollectionView resetHeight:newHeight];
    //============ Calendar->Delegate
    if (self.delegate && [self.delegate respondsToSelector:@selector(calendarHeightAtPresent:)]) {
        [self.delegate calendarHeightAtPresent:newHeight];
        [self resetHeight:newHeight];
    }
}
/**
 *  初始化选中某一天
 */
- (void)doSelectCalendarOneDay:(id)selectDayObject
{
    NSDateComponents* dateCompents = nil;
    if ([selectDayObject isKindOfClass:[NSDate class]]) { //是NSDate
        dateCompents = [[TSC_Logic getInstance] dateCompoent4BaseDate:selectDayObject andFormateDateType:TSCDateFormate_YMDHMS];
    }
    else if ([selectDayObject isKindOfClass:[NSString class]]) //是字符串
    {
        dateCompents = (NSDateComponents*)[[[TSC_Logic getInstance] dateInfo4FormateDateType:TSCDateFormate_YMDHMS andTimeMatchStr:selectDayObject] objectForKey:LogicReturn_DateComp];
    }
    int year = (int)dateCompents.year;
    int month = (int)dateCompents.month;
    int day = (int)dateCompents.day;
    int firstDayWeekDay = (int)[[[[TSC_Logic getInstance] dateInfo4FormateDateType:TSCDateFormate_YMDHMS andTimeMatchStr:TSCString_Format(@"%d-%d-1", year, month)] objectForKey:LogicReturn_DateComp] weekday];
    int cSection = (year - TSC_START_YEAR) * 12 + month - 1;
    float contentOffset_X = cSection * self.mCollectionView.frame.size.width;
    int cRow = firstDayWeekDay - 1 + day;
    if (self.delegate && [self.delegate respondsToSelector:@selector(calendarCurrentMonth:andYear:)]) {
        [self.delegate calendarCurrentMonth:month andYear:year];
    }
    int currentPageNum = _calendarCollectionView.contentOffset.x / _calendarCollectionView.frame.size.width;
    if (_lastSelectIndexPath && (int)_lastSelectIndexPath.section == currentPageNum && cSection == currentPageNum) {
        NSIndexPath* tempIndexPath = [NSIndexPath indexPathForRow:[self showIndexRow:cRow] inSection:cSection];
        [self qCollectionView:_calendarCollectionView didSelectItemAtIndexPath:tempIndexPath];
    }
    else {
        _lastSelectIndexPath = [NSIndexPath indexPathForRow:[self showIndexRow:cRow] inSection:cSection];
        [_calendarCollectionView scrollToItemAtIndexPath:_lastSelectIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        //偏移到对应月份
        [_calendarCollectionView setContentOffset:CGPointMake(contentOffset_X, _calendarCollectionView.contentOffset.y) animated:NO];
        //修改collectionView的高度以对应相应月份的值显示
        [self resetCollectionViewHeightWithScroll:_calendarCollectionView];
    }
    //======== CalendarDelegate->SelectDate
    if (self.delegate && [self.delegate respondsToSelector:@selector(calendarDidSelectItemModel:andIndexPath:)]) {
        TSCalendarUnitDateModel* unitDateModel = [TSCalendarUnitDateModel new];
        unitDateModel.year = year;
        unitDateModel.month = month;
        unitDateModel.day = day;
        unitDateModel.isBelongToThisMonth = year;
        [self.delegate calendarDidSelectItemModel:unitDateModel andIndexPath:_lastSelectIndexPath];
    }
}

- (int)showIndexRow:(int)originIndexRow
{
    int pY = originIndexRow / 7;
    int pX = originIndexRow % 7;
    int resultNo = pX > 0 ? ((pX - 1) * 6 + pY) : pY;
    return resultNo;
}
#pragma mark------------------LazyLoading-------------------
- (TS_CollectionView*)mCollectionView
{
    if (_mCollectionView == nil) {
        _mCollectionView = [[TS_CollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) andHorizonNum:7 andVerticalNum:6 andScrollDirection:QCollectionScrollDirection_Horizontal andCollectionCellClass:[TSCalendarUnitDayCell class]];
        _mCollectionView.collectionDelegate = self;
        _mCollectionView.clipsToBounds = YES;
        _mCollectionView.collectionBackgroundColor = [UIColor clearColor];
        _mCollectionView.layer.borderColor = [self.daysLayoutModel.borderLineColor CGColor];
        _mCollectionView.layer.borderWidth = 0.5;

        for (UIView* tempView in _mCollectionView.subviews) {
            if ([tempView isKindOfClass:[UICollectionView class]]) {
                UICollectionView* collectionV = (UICollectionView*)tempView;
                collectionV.showsHorizontalScrollIndicator = NO;
                _calendarCollectionView = collectionV;
            }
        }
    }
    _mCollectionView.layer.borderColor = [self.daysLayoutModel.borderLineColor CGColor];
    return _mCollectionView;
}
- (TSCalendarDaysLayoutModel*)daysLayoutModel
{
    if (_daysLayoutModel == nil) {
        _daysLayoutModel = [[TSCalendarDaysLayoutModel alloc] init];
    }
    _daysLayoutModel.titleColor = self.uDay_titleColor;
    _daysLayoutModel.subTitleColor = self.uDay_subTitleColor;
    _daysLayoutModel.backgroundColor = self.uDay_backgroundColor;
    _daysLayoutModel.selectedTitleColor = self.uDay_selectedTitleColor;
    _daysLayoutModel.selectedSubTitleColor = self.uDay_selectedSubTitleColor;
    _daysLayoutModel.selectedBackgroundColor = self.uDay_selectedBackgroundColor;
    _daysLayoutModel.layoutType = self.uDays_layoutType;
    _daysLayoutModel.modBackColor = self.uDays_ModBackColor;
    _daysLayoutModel.modTitleColor = self.uDays_ModTitleColor;
    _daysLayoutModel.isShowUDayBorderLine = self.isShowUDayBorderLine;
    _daysLayoutModel.borderLineColor = self.uDay_BorderLineColor;
    _daysLayoutModel.daySelectedBGType = self.uDay_SelectedBGType;
    return _daysLayoutModel;
}

@end
