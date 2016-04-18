# TSCalendarDemo

This is a calendar base on UICollectionView!

   You can use the calendar base on below code:
    
    *TSCalendarView* calendarView = [[TSCalendarView alloc] initWithFrame:CGRectMake(0, 60, kTSC_DeviceWidth, kTSC_DeviceWidth / 7.0 * 6.0)];
    *calendarView.uDay_titleColor = [UIColor redColor];
    *calendarView.uDay_subTitleColor = [UIColor orangeColor];
    *calendarView.uDay_selectedTitleColor = [UIColor whiteColor];
    *calendarView.uDay_selectedSubTitleColor = [UIColor greenColor];
    *calendarView.uDay_selectedBackgroundColor = [UIColor orangeColor];
    *calendarView.uDays_layoutType = TSCalendarDaysLayoutType_Default; 
    *calendarView.delegate = self;
    *[self.view addSubview:calendarView];
*There are some "delegate" you can complete:
* - (void)calendarHeightAtPresent:(float)calendarH;   //you can get current height for calendar when it scroll.
* - (void)calendarDidSelectItemModel:(TSCalendarUnitDateModel*)model andIndexPath:(NSIndexPath*)indexPath; //you can a day info selected.
* - (void)calendarCurrentMonth:(int)month andYear:(int)year;    //you can get the infomation about year and month when the calendar scroll stop.
