//
//  ZQCollectionView.h
//  TS_Calendar
//
//  Created by zq on 16/4/8.
//  Copyright © 2016年 zhangqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    QCollectionScrollDirection_Horizontal,
    QCollectionScrollDirection_Vertical
} QCollectionScrollDirection;
static NSString* QCollectionCellReuseIdentity = @"QCollectionCellReuseIdentity";

@protocol ZQCollectionViewDelegate <NSObject>
@required
- (NSInteger)qNumberOfSectionsInCollectionView:(UICollectionView*)collection;
- (UICollectionViewCell*)qCollectionView:(UICollectionView*)collectionView
                  cellForItemAtIndexPath:(NSIndexPath*)indexPath;
- (void)qCollectionView:(UICollectionView*)collectionView didSelectItemAtIndexPath:(NSIndexPath*)indexPath;

@optional
- (void)qScrollViewDidScroll:(UIScrollView*)scrollView;
- (void)qScrollViewWillBeginDragging:(UIScrollView*)scrollView;
- (void)qScrollViewWillEndDragging:(UIScrollView*)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint*)targetContentOffset;
- (void)qScrollViewDidEndDragging:(UIScrollView*)scrollView willDecelerate:(BOOL)decelerate;
- (void)qScrollViewWillBeginDecelerating:(UIScrollView*)scrollView;
- (void)qScrollViewDidEndDecelerating:(UIScrollView*)scrollView;
- (void)qScrollViewDidEndScrollingAnimation:(UIScrollView*)scrollView;
@end

@interface ZQCollectionView : UIView
@property (nonatomic, assign) id<ZQCollectionViewDelegate> collectionDelegate;
@property (nonatomic, assign) BOOL pagingEnabled;
@property (nonatomic, assign) BOOL bounces;
@property (nonatomic, retain) UIColor* collectionBackgroundColor;

- (instancetype)initWithFrame:(CGRect)frame andHorizonNum:(int)horizonNumber andVerticalNum:(int)verticalNumber
           andScrollDirection:(QCollectionScrollDirection)qCollectionScrollDirection
       andCollectionCellClass:(Class)cellClass;

@end
