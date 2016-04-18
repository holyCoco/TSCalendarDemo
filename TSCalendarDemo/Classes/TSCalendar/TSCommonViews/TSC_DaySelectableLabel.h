//
//  TSC_DaySelectableLabel.h
//  TS_Calendar
//
//  Created by zq on 16/3/31.
//  Copyright © 2016年 zhangqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSC_DaySelectableLabel : UILabel

@property (nonatomic, assign) BOOL isSelected4TSC;
@property (nonatomic, retain) UIColor* defaultTextColor;
@property (nonatomic, retain) UIColor* selectTextColor;

@end
