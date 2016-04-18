//
//  TSC_DaySelectableLabel.m
//  TS_Calendar
//
//  Created by zq on 16/3/31.
//  Copyright © 2016年 zhangqiang. All rights reserved.
//

#import "TSC_DaySelectableLabel.h"

@implementation TSC_DaySelectableLabel

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}
- (void)setIsSelected4TSC:(BOOL)isSelected4TSC
{
    _isSelected4TSC = isSelected4TSC;
    self.textColor = isSelected4TSC ? self.selectTextColor : self.defaultTextColor;
    //    self.backgroundColor = isSelected4TSC ? self.selectBackgroundColor : self.defaultBackgroundColor;
}

@end
