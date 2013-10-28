class ViewController < Motion::ImageEditorController
  CROP_RECT = CGRectMake(10, 100, 300, 300 * 0.75)

  def viewDidLoad
    super

    self.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(
      UIBarButtonSystemItemSave,
      target: self,
      action: 'process_image')
  end

  def viewDidAppear(animated)
    super

    self.crop_rect = CROP_RECT
  end

  def done_callback
    -> (image) do
      p 'received image', image

      result_controller       = ResultController.alloc.init
      result_controller.image = image

      navigationController.pushViewController(result_controller, animated: true)
    end
  end

  def cancel_callback
    -> { p 'cancelled' }
  end

  def prefersStatusBarHidden
    true
  end
end
