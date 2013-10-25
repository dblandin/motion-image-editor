class AppDelegate
  attr_accessor :window

  def application(application, didFinishLaunchingWithOptions: launch_options)
    return true if RUBYMOTION_ENV == 'test'

    initialize_main_controller

    true
  end

  private

  def picker
    @picker = UIImagePickerController.alloc.init.tap do |controller|
      controller.allowsEditing = false
      controller.sourceType    = UIImagePickerControllerSourceTypePhotoLibrary
      controller.delegate      = self
    end
  end

  def initialize_main_controller
    self.window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    window.setRootViewController(picker)

    window.makeKeyAndVisible
  end

  def imagePickerController(picker, didFinishPickingMediaWithInfo:info)
    image = info[UIImagePickerControllerOriginal]

    controller = ViewController.alloc.init
    controller.source_image = image

    picker.pushViewController(controller, animated: true)
  end

  def imagePickerControllerDidCancel(picker)
  end
end
