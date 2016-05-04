# TSCalendar

This is a calendar base on UICollectionView!

   You can use the calendar base on below code:
    
    TSCalendarView* calendarView = [[TSCalendarView alloc] initWithFrame:CGRectMake(0, 60, kTSC_DeviceWidth, kTSC_DeviceWidth / 7.0 * 6.0)];
    calendarView.uDay_titleColor = [UIColor redColor];
    calendarView.uDay_subTitleColor = [UIColor orangeColor];
    calendarView.uDay_selectedTitleColor = [UIColor whiteColor];
    calendarView.uDay_selectedSubTitleColor = [UIColor greenColor];
    calendarView.uDay_selectedBackgroundColor = [UIColor orangeColor];
    calendarView.uDays_layoutType = TSCalendarDaysLayoutType_Default; 
    //-----------------------v1.0.1-------------------------
    calendarView.uDay_backgroundColor = [UIColor clearColor];    //可以修改日历可点击dayView为透明
    calendarView.isShowUDayBorderLine = YES;                     //可以修分割线的颜色以及是否显示
    calendarView.uDay_BorderLineColor = [UIColor redColor];
    calendarView.uDays_ModBackColor = [UIColor lightGrayColor];  //可以修改日历不可点击dayView的背景色和字体颜色
    calendarView.uDays_ModTitleColor = [UIColor grayColor];
    //-------------------------------------------------------
    calendarView.delegate = self;
    [self.view addSubview:calendarView];

	There are some "delegate" you can complete:
	* - (void)calendarHeightAtPresent:(float)calendarH;   //you can get current height for calendar when it scroll.
	* - (void)calendarDidSelectItemModel:(TSCalendarUnitDateModel*)model andIndexPath:(NSIndexPath*)indexPath; //you can a day info selected.
	* - (void)calendarCurrentMonth:(int)month andYear:(int)year;    //you can get the infomation about year and month when the calendar scroll stop.


   版本特性：
   *-v1.0.3
      *修改12月显示为0月的bug   
      *添加选中天的样式：可以设置圆形填充选中，圆形边框选中，和矩形填充选中，选中背景色和字体颜色自定
