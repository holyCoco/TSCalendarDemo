//
//  TSCommonModel.h
//  TS_Calendar
//
//  Created by zq on 16/3/30.
//  Copyright © 2016年 zhangqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

#import "TSC_Logic.h"

#define TSC_START_YEAR 2000

typedef NS_ENUM(NSUInteger, TSCalendarDaysLayoutType) {
    TSCalendarDaysLayoutType_Default,
    TSCalendarDaysLayoutType_Lunar //显示阴历
};

@interface TSCommonModel : NSObject
@end

/**=============================================
 *  单天UI模型：高，宽，字体颜色，背景色，选中的背景和字体颜色，样式（日期数字居中/左上角，是否显示阴历，是否显示事件，等）
 */
@interface TSCalendarDaysLayoutModel : NSObject
@property (nonatomic, assign) float width, height;
@property (nonatomic, retain) UIColor *titleColor,
    *subTitleColor, //如：阴历，有无事件，天气等
    *backgroundColor,
    *selectedTitleColor,
    *selectedSubTitleColor,
    *selectedBackgroundColor;
@property (nonatomic, assign) TSCalendarDaysLayoutType layoutType; //单天的布局样式
@end

/**=============================================
 *  单天数据模型：年月日，NSDate，
 */
@interface TSCalendarUnitDateModel : NSObject
@property (nonatomic, assign) int year, month, day;
@property (nonatomic, assign) BOOL isBelongToThisMonth; //不可点击的有当月视图中上下各月的灰色view

+ (instancetype)createWithSufaceYear:(int)sufaceYear andSufaceMonth:(int)sufaceMonth andSufaceDay:(int)sufaceDay;

@end