Pod::Spec.new do |s|
s.name = "TSCalendarView"
s.version = "1.0.2"
s.summary = "A calendar base on UICollectionView."


s.homepage = "https://github.com/holyCoco/TSCalendarDemo"
s.author = { "ZhangQiang" => "925324664@qq.com" }
s.source = { :git => "https://github.com/holyCoco/TSCalendarDemo.git",:commit => "a826e94520f7d409b036dd24aacf2c005808e360",:tag=>"1.0.2"}
s.source_files = 'TSCalendarDemo/Classes/TSCalendarView/*.{h,m}'
s.license = {:type=>'Custom',:text=>'Copyright (C) 2016 Apple Inc.All Rights Reserved.'}
s.platform=:ios,'7.0'
s.requires_arc = true
end