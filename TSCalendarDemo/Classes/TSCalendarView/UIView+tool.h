//
//  UIView+tool.h
//  MomaProject
//
//  Created by zq on 15/11/27.
//  Copyright (c) 2015年 zhangqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

typedef void (^TapBlock)(UIView* view);

@interface UIView (tool)

- (void)resetX:(float)pX;
- (void)resetY:(float)pY;
- (void)resetWidth:(float)pWid;
- (void)resetHeight:(float)pHeight;

- (void)addBlock4Tap:(TapBlock)tapMBlock;

@end