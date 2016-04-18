Pod::Spec.new do |s|
s.name = "TSCalendarView"
s.version = "1.0.0"
s.summary = "A calendar base on UICollectionView."


s.homepage = "https://github.com/holyCoco/TSCalendarDemo"
s.author = { "ZhangQiang" => "925324664@qq.com" }
s.source = { :git => "https://github.com/holyCoco/TSCalendarDemo.git",:commit => "6228c4b0f1d0b7b9a6c5d91ca3a1d21430f1b304",:tag=>"1.0.0"}
s.source_files = 'TSCalendarDemo/Classes/*.{h,m}'
s.license = {:type=>'Custom',:text=>'Copyright (C) 2016 Apple Inc.All Rights Reserved.'}
s.platform=:ios,'7.0'
s.requires_arc = true
end