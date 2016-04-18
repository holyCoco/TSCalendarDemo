//
//  UIView+tool.m
//  MomaProject
//
//  Created by zq on 15/11/27.
//  Copyright (c) 2015年 zhangqiang. All rights reserved.
//

#import "UIView+tool.h"

@implementation UIView (tool)

- (void)resetX:(float)pX
{
    self.frame = CGRectMake(pX, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}
- (void)resetY:(float)pY
{
    self.frame = CGRectMake(self.frame.origin.x, pY, self.frame.size.width, self.frame.size.height);
}
- (void)resetWidth:(float)pWid
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, pWid, self.frame.size.height);
}
- (void)resetHeight:(float)pHeight
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, pHeight);
}

#pragma mark - 添加点击手势block
- (void)addBlock4Tap:(TapBlock)tapMBlock
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer* tapGes =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(tapMethod:)];
    [self addGestureRecognizer:tapGes];
    __weak UIView* weakSelf = self;
    weakSelf.tapBlock = tapMBlock;
}
- (void)tapMethod:(UIGestureRecognizer*)sender
{
    self.tapBlock(sender.view);
}
- (void)setTapBlock:(TapBlock)tapBlock
{
    objc_setAssociatedObject(self, @"tapBlock", tapBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (TapBlock)tapBlock
{
    return objc_getAssociatedObject(self, @"tapBlock");
}


@end
