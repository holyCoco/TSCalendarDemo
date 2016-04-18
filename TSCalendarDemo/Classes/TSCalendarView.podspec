Pod::Spec.new do |s|
s.name = "TSCalendarView"
s.version = "1.0.0"
s.summary = "A calendar base on UICollectionView."


s.homepage = "https://github.com/holyCoco/TSCalendarDemo"
s.author = { "ZhangQiang" => "925324664@qq.com" }
s.source = { :git => "https://github.com/holyCoco/TSCalendarDemo.git",:commit => "04ef0fdf15525d5112640c606c27af893d2e1457",:tag=>"1.0.0"}
s.source_files = 'TSCalendarDemo/Classes/TSCalendarView/*.{h,m}'
s.license = {:type=>'Custom',:text=>'Copyright (C) 2016 Apple Inc.All Rights Reserved.'}
s.platform=:ios,'7.0'
s.requires_arc = true
end