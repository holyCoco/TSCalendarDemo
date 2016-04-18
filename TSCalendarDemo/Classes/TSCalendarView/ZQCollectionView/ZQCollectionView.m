//
//  ZQCollectionView.m
//  TS_Calendar
//
//  Created by zq on 16/4/8.
//  Copyright © 2016年 zhangqiang. All rights reserved.
//

#import "ZQCollectionView.h"

@interface ZQCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate> {
    int _horizonNumber, _verticalNumber;
    QCollectionScrollDirection _qCollectionScrollDirection;
    CGRect _thisFrame;
}
@property (nonatomic, retain) UICollectionView* collectionV;

@end
@implementation ZQCollectionView

- (instancetype)initWithFrame:(CGRect)frame andHorizonNum:(int)horizonNumber andVerticalNum:(int)verticalNumber
           andScrollDirection:(QCollectionScrollDirection)qCollectionScrollDirection
       andCollectionCellClass:(Class)cellClass
{
    self = [super initWithFrame:frame];
    if (self) {
        _thisFrame = frame;
        _horizonNumber = horizonNumber; //横
        _verticalNumber = verticalNumber; //竖
        _qCollectionScrollDirection = qCollectionScrollDirection;
        self.backgroundColor = [UIColor whiteColor];
        //create flowLayout
        UICollectionViewFlowLayout* viewLayout = [[UICollectionViewFlowLayout alloc] init];
        viewLayout.headerReferenceSize = CGSizeMake(0.0, 0.0); //头部视图框架大小
        viewLayout.itemSize = CGSizeMake(frame.size.width / horizonNumber, frame.size.height / verticalNumber);
        viewLayout.minimumLineSpacing = 0.0f; //每行的最小间距
        viewLayout.minimumInteritemSpacing = 0.0f; //每列的最小间距
        viewLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0); //网格视图 上下左右的边距
        viewLayout.scrollDirection = (qCollectionScrollDirection == QCollectionScrollDirection_Horizontal) ? UICollectionViewScrollDirectionHorizontal : UICollectionViewScrollDirectionVertical;
        //create collectionView
        UICollectionView* collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:viewLayout];
        [collectionView registerClass:cellClass forCellWithReuseIdentifier:QCollectionCellReuseIdentity];
        collectionView.pagingEnabled = YES;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.bounces = NO;
        [self addSubview:collectionView];
        self.collectionV = collectionView;
    }
    return self;
}

#pragma mark------------------UIScrollView.Delegate-------------------
- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    if (self.collectionDelegate && [self.collectionDelegate respondsToSelector:@selector(qScrollViewDidScroll:)]) {
        [self.collectionDelegate qScrollViewDidScroll:scrollView];
    }
}
// called on start of dragging (may require some time and or distance to move)
- (void)scrollViewWillBeginDragging:(UIScrollView*)scrollView
{
    if (self.collectionDelegate && [self.collectionDelegate respondsToSelector:@selector(qScrollViewWillBeginDragging:)]) {
        [self.collectionDelegate qScrollViewWillBeginDragging:scrollView];
    }
}
// called on finger up if the user dragged. velocity is in points/millisecond. targetContentOffset may be changed to adjust where the scroll view comes to rest
- (void)scrollViewWillEndDragging:(UIScrollView*)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint*)targetContentOffset
{
    if (self.collectionDelegate && [self.collectionDelegate respondsToSelector:@selector(qScrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
        [self.collectionDelegate qScrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
}
// called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
- (void)scrollViewDidEndDragging:(UIScrollView*)scrollView willDecelerate:(BOOL)decelerate;
{
    if (self.collectionDelegate && [self.collectionDelegate respondsToSelector:@selector(qScrollViewDidEndDragging:willDecelerate:)]) {
        [self.collectionDelegate qScrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}
// called on finger up as we are moving
- (void)scrollViewWillBeginDecelerating:(UIScrollView*)scrollView
{
    if (self.collectionDelegate && [self.collectionDelegate respondsToSelector:@selector(qScrollViewWillBeginDecelerating:)]) {
        [self.collectionDelegate qScrollViewWillBeginDecelerating:scrollView];
    }
}
// called when scroll view grinds to a halt
- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
    if (self.collectionDelegate && [self.collectionDelegate respondsToSelector:@selector(qScrollViewDidEndDecelerating:)]) {
        [self.collectionDelegate qScrollViewDidEndDecelerating:scrollView];
    }
}
// called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView*)scrollView
{
    if (self.collectionDelegate && [self.collectionDelegate respondsToSelector:@selector(qScrollViewDidEndScrollingAnimation:)]) {
        [self.collectionDelegate qScrollViewDidEndScrollingAnimation:scrollView];
    }
}

#pragma mark------------------UICollectionView.delegate-------------------
- (NSInteger)numberOfSectionsInCollectionView:
    (UICollectionView*)collectionView
{
    if (self.collectionDelegate) {
        return [self.collectionDelegate qNumberOfSectionsInCollectionView:collectionView];
    }
    return 20;
}

- (NSInteger)collectionView:(UICollectionView*)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return _horizonNumber * _verticalNumber;
}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView
                 cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    UICollectionViewCell* cell = nil;
    if (self.collectionDelegate) {
        int indexRowNumber = (int)indexPath.row;
        if (_qCollectionScrollDirection == QCollectionScrollDirection_Horizontal) {
            indexRowNumber = indexRowNumber / _verticalNumber + _horizonNumber * (indexRowNumber % _verticalNumber);
        }
        cell = [self.collectionDelegate qCollectionView:collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:indexRowNumber inSection:indexPath.section]];
    }
    else {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:QCollectionCellReuseIdentity forIndexPath:indexPath];
    }
    return cell;
}
- (void)collectionView:(UICollectionView*)collectionView didSelectItemAtIndexPath:(NSIndexPath*)indexPath
{
    if (self.collectionDelegate) {
        [self.collectionDelegate qCollectionView:collectionView didSelectItemAtIndexPath:indexPath];
    }
}

/**
 *  Setter
 */
- (void)setPagingEnabled:(BOOL)pagingEnabled
{
    _pagingEnabled = pagingEnabled;
    self.collectionV.pagingEnabled = pagingEnabled;
}
- (void)setBounces:(BOOL)bounces
{
    _bounces = bounces;
    self.collectionV.bounces = bounces;
}
- (void)setCollectionBackgroundColor:(UIColor*)collectionBackgroundColor
{
    _collectionBackgroundColor = collectionBackgroundColor;
    self.collectionV.backgroundColor = collectionBackgroundColor;
}

@end
