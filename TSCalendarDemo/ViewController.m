//
//  ViewController.m
//  TSCalendarDemo
//
//  Created by zq on 16/4/18.
//  Copyright © 2016年 zhangqiang. All rights reserved.
//

#import "TSCalendarView.h"
#import "UIView+tool.h"
#import "ViewController.h"

/**
 <前言>:
 *  为了TSCalendar作为第三方库内部不再导入其他第三方库，我把ZQCollectionView（一个可以横向显示数据的collectionView，也是我在维护）文件添加进来，也把UIColor+MCUIColorsUtils内部的一些用到的方法拷贝到了UIColor+tool文件中，感谢UIColor+MCUIColorsUtils！
 *  本库有需要改进和不足的地方欢迎大家发邮件到我的邮箱：qz.toughsnail@gmail.com
 */

@interface ViewController () <TSCalendarDelegate> {
}
@property (nonatomic, retain) UIButton* tempBtn;
@end
@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor lightGrayColor]];

    TSCalendarView* calendarView = [[TSCalendarView alloc] initWithFrame:CGRectMake(0, 60, kTSC_DeviceWidth, kTSC_DeviceWidth / 7.0 * 6.0)];
    calendarView.uDay_titleColor = [UIColor redColor];
    calendarView.uDay_subTitleColor = [UIColor orangeColor];
    calendarView.uDay_selectedTitleColor = [UIColor whiteColor];
    calendarView.uDay_selectedSubTitleColor = [UIColor greenColor];
    calendarView.uDay_selectedBackgroundColor = [UIColor orangeColor];
    calendarView.uDays_layoutType = TSCalendarDaysLayoutType_Default; //阴历模式暂未完善，敬请期待
    calendarView.delegate = self;
    [self.view addSubview:calendarView];

    [calendarView doSelectCalendarOneDay:[NSDate date]];
    [self.view addSubview:self.tempBtn];
    [self.tempBtn addBlock4Tap:^(UIView* view) {
        [calendarView doSelectCalendarOneDay:@"2016-4-15"]; //此处可以传字符串也可以传NSDate，字符串年月日必须用“-”分隔
    }];
}

#pragma mark------------------TSCalendar.Delegate-------------------
- (void)calendarCurrentMonth:(int)month andYear:(int)year
{
    NSLog(@"year===%d===%d", year, month);
    [self.tempBtn setTitle:TSCString_Format(@"%d年%d月", year, month) forState:UIControlStateNormal];
}
- (void)calendarHeightAtPresent:(float)calendarH
{
    NSLog(@"nowCalendarH====%f", calendarH);
}
- (void)calendarDidSelectItemModel:(TSCalendarUnitDateModel*)model andIndexPath:(NSIndexPath*)indexPath
{
    TSCalendarUnitDateModel* unitDateModel = model;
    NSLog(@"unitDate===%d==%d==%d", unitDateModel.year, unitDateModel.month, unitDateModel.day);
}
#pragma mark------------------LazyLoading-------------------
- (UIButton*)tempBtn
{
    if (_tempBtn == nil) {
        _tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_tempBtn setFrame:CGRectMake(100, 400, kTSC_DeviceWidth - 200, 50)];
        [_tempBtn setBackgroundColor:[UIColor blueColor]];
    }
    return _tempBtn;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
