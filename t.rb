require 'xcodeproj'

# 创建 Example.xcodeproj工程文件，并保存
  Xcodeproj::Project.new("./Example.xcodeproj").save

# 打开创建的Example.xcodeproj文件
  proj=Xcodeproj::Project.open("./Example.xcodeproj")

# 创建一个分组，名称为Example，对应的路径为./Example
  exampleGroup=proj.main_group.new_group("Example","./Example")

# 给Example分组添加文件引用
  exampleGroup.new_reference("AppDelegate.h")
  ref1=exampleGroup.new_reference("AppDelegate.m")
  ref2=exampleGroup.new_reference("Images.xcassets")
  exampleGroup.new_reference("Base.lproj/LaunchScreen.xib")

# 在Example分组下创建一个名字为Supporting Files的子分组，并给该子分组添加main和info.plist文件引用
  supportingGroup=exampleGroup.new_group("Supporting Files")
  ref3=supportingGroup.new_reference("main.m")
  supportingGroup.new_reference("Info.plist")

# 创建target，主要的参数 type: application :dynamic_library framework :static_library 意思大家都懂的
# name：target名称
# platform：平台 :ios或者:osx
  target = proj.new_target(:application,"Example",:ios)

# 添加target配置信息
  target.build_configuration_list.set_setting('INFOPLIST_FILE', "$(SRCROOT)/Example/Info.plist")

# target添加相关的文件引用，这样编译的时候才能引用到
  target.add_file_references([ref1,ref2,ref3])

  testGroup=proj.main_group.new_group("ExampleTests","./ExampleTests")
  ref4=testGroup.new_reference("ExampleTests.m")
  supportingGroup=testGroup.new_group("Supporting Files")
  supportingGroup.new_reference("Info.plist")

# 创建test target
  testTarget = proj.new_target(:unit_test_bundle,"ExampleTests",:ios,nil,proj.products_group)
  testRefrence = testTarget.product_reference
  testRefrence.set_explicit_file_type('wrapper.cfbundle')
  testRefrence.name = "ExampleTests.xctest"
  testTarget.add_file_references([ref4])
  
 # 保存
  proj.save
