# -*- coding: utf-8 -*-
$:.unshift('/Library/RubyMotion/lib')
require 'motion/project/template/ios'
require './lib/motion-image-editor'

begin
  require 'bundler'
  require 'motion/project/template/gem/gem_tasks'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'motion-image-editor'
  app.frameworks += %w(UIKit)

  app.pods do
    pod 'UIImage-Resize', '~> 1.0.1'
  end
end
