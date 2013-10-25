class ViewController < Motion::ImageEditorController
  def viewDidLoad
    super

    show_image_picker
  end

  def show_image_picker
    presentViewController(picker, animated: true, completion: nil)
  end
end
