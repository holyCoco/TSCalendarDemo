//
//  TSC_Constants.h
//  TS_Calendar
//
//  Created by zq on 16/4/6.
//  Copyright © 2016年 zhangqiang. All rights reserved.
//

#ifdef __OBJC__
#import "TSC_Color.h"
#endif

#ifndef TSC_Constants_h
#define TSC_Constants_h

#define kTSC_DeviceWidth [UIScreen mainScreen].bounds.size.width
#define kTSC_DeviceHeight [UIScreen mainScreen].bounds.size.height

#define TSCString_Format(...) [NSString stringWithFormat:__VA_ARGS__]
#define TSCLog(fmt, ...) \
    NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define TSC_ViewBottomY(tempView) \
    (tempView.frame.origin.y + tempView.frame.size.height)
#define TSC_ViewEndX(tempView) (tempView.frame.origin.x + tempView.frame.size.width)

#define IS_iOS9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)

#endif /* TSC_Constants_h */
