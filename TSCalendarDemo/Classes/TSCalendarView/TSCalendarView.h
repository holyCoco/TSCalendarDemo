//
//  TSCalendarView.h
//  TS_Calendar
//
//  Created by zq on 16/4/11.
//  Copyright © 2016年 zhangqiang. All rights reserved.
//

#import "TSCalendarUnitDayCell.h"
#import "TSCommonModel.h"
#import <UIKit/UIKit.h>
#import "ZQCollectionView.h"

@protocol TSCalendarDelegate <NSObject>
- (void)calendarHeightAtPresent:(float)calendarH;
- (void)calendarDidSelectItemModel:(TSCalendarUnitDateModel*)model andIndexPath:(NSIndexPath*)indexPath;
- (void)calendarCurrentMonth:(int)month andYear:(int)year;
@end

@interface TSCalendarView : UIView

@property (nonatomic, retain) UIColor *uDay_titleColor,
    *uDay_subTitleColor, //如：阴历，有无事件，天气等
    *uDay_backgroundColor,
    *uDay_selectedTitleColor,
    *uDay_selectedSubTitleColor,
    *uDay_selectedBackgroundColor;
@property (nonatomic, assign) TSCalendarDaysLayoutType uDays_layoutType; //单天的布局样式

@property (nonatomic, assign) id<TSCalendarDelegate> delegate;

- (void)doSelectCalendarOneDay:(id)selectDayObject; //可以传NSDate，也可以是拼接的字符串

@end
