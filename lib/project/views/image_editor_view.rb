class Motion; class ImageEditorView < UIView
  def initWithFrame(frame)
    super.tap do |view|
      view.opaque          = false
      view.layer.opacity   = 0.7
      view.backgroundColor = UIColor.clearColor

      view.addSubview(image_view)

      view.setup_constraints
    end
  end

  def setup_constraints
    addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
      'H:|[image]|',
      options: 0,
      metrics: nil,
      views:   { 'image' => image_view }))

    addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
      'V:|[image]|',
      options: 0,
      metrics: nil,
      views:   { 'image' => image_view }))
  end

  def crop_rect
    @crop_rect ||= CGRectZero
  end

  def crop_rect=(rect)
    @crop_rect = CGRectOffset(rect, frame.origin.x, frame.origin.y)

    UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)

    context = UIGraphicsGetCurrentContext()

    UIColor.blackColor.setFill
    UIRectFill(bounds)

    UIColor.clearColor.setFill
    UIRectFill(CGRectInset(rect, 1, 1))

    image_view.image = UIGraphicsGetImageFromCurrentImageContext()

    UIGraphicsEndImageContext()
  end

  def image_view
    @image_view ||= UIImageView.alloc.init.tap do |image_view|
      image_view.translatesAutoresizingMaskIntoConstraints = false
    end
  end
end; end
