class ViewController < Motion::ImageEditorController
  CROP_RECT = CGRectMake(10, 100, 300, 300 * 0.75)

  def viewDidAppear(animated)
    self.crop_rect = CROP_RECT

    super
  end

  def viewDidLoad
    super

    view.backgroundColor = UIColor.whiteColor

    navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(
      UIBarButtonSystemItemSave,
      target: self,
      action: 'process_image:')
  end

  def process_image(sender)
    process do |image|
      result_controller       = ResultController.alloc.init
      result_controller.image = image

      navigationController.pushViewController(result_controller, animated: true)
    end
  end

  def prefersStatusBarHidden
    true
  end
end
