require 'xcodeproj'
require 'fileutils'


# 项目配置
app_name = 'Example'
app_dir = './' + app_name
source_path = app_dir + '/' + app_name
project_path = source_path + '.xcodeproj'

# 创建App目录
FileUtils.mkdir_p source_path unless Dir.exist?(source_path)

# 创建 XX.xcodeproj工程文件，并保存
project = Xcodeproj::Project.new(project_path).save

# 打开创建的Example.xcodeproj文件
#project = Xcodeproj::Project.open(project_path)
#exampleGroup = project.main_group.new_group(app_name,app_dir)
#project.save


