Pod::Spec.new do |s|
s.name = "TSCalendarView"
s.version = "1.0.6"
s.summary = "A calendar base on UICollectionView."


s.homepage = "https://github.com/holyCoco/TSCalendarDemo"
s.author = { "ZhangQiang" => "925324664@qq.com" }
s.source = { :git => "https://github.com/holyCoco/TSCalendarDemo.git",:commit => "031fb6a24b9433607eb22fc0132d73a968e6878c",:tag=>"1.0.6"}
s.source_files = 'TSCalendarDemo/Classes/TSCalendarView/*.{h,m}'
s.license = {:type=>'Custom',:text=>'Copyright (C) 2016 Apple Inc.All Rights Reserved.'}
s.platform=:ios,'7.0'
s.requires_arc = true
end