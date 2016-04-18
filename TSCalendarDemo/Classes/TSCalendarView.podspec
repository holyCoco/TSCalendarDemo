Pod::Spec.new do |s|
s.name = "TSCalendarView"
s.version = "1.0.0"
s.summary = "A calendar base on UICollectionView."


s.homepage = "https://github.com/holyCoco/TSCalendarDemo"
s.author = { "ZhangQiang" => "925324664@qq.com" }
s.source = { :git => "https://github.com/holyCoco/TSCalendarDemo.git",:commit => "4644e980528ba15d169e10b08f3b23fd8e32646f",:tag=>"1.0.0"}
s.source_files = 'TSCalendarDemo/Classes/TSCalendarView/*.{h,m}'
s.license = {:type=>'Custom',:text=>'Copyright (C) 2016 Apple Inc.All Rights Reserved.'}
s.platform=:ios,'7.0'
s.requires_arc = true
end