class AppDelegate
  attr_reader :window

  def application(application, didFinishLaunchingWithOptions: launch_options)
    return true if RUBYMOTION_ENV == 'test'

    initialize_main_controller

    true
  end

  def initialize_main_controller
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    view_controller.source_image = UIImage.imageNamed('image_test.jpg')

    window.setRootViewController(navigation_controller)

    window.makeKeyAndVisible
  end

  def navigation_controller
    @navigation_controller ||= UINavigationController.alloc.initWithRootViewController(view_controller)
  end

  def view_controller
    @view_controller ||= ViewController.alloc.init
  end

end
