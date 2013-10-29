unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end

lib_dir_path = File.dirname(File.expand_path(__FILE__))
Motion::Project::App.setup do |app|
  app.files.unshift(Dir.glob(File.join(lib_dir_path, "project/**/*.rb")))

  app.pods ||= Motion::Project::CocoaPods.new(app)
  app.pods.pod 'UIImage-Resize', '~> 1.0.1'
end
