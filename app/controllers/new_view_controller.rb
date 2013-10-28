class NewViewController < UIViewController
  CROP_RECT = [[10, 100], [300, 300 * 0.75]]

  attr_reader :touch_center, :scale_center, :scale

  def viewDidLoad
    super

    add_subviews

    reset

    add_gesture_recognizers

    setup_constraints
  end

  def add_subviews
    view.addSubview(crop_view)
    view.insertSubview(image_view, belowSubview: crop_view)
  end

  def add_gesture_recognizers
    crop_view.addGestureRecognizer(pan_recognizer)
    crop_view.addGestureRecognizer(pinch_recognizer)
    crop_view.addGestureRecognizer(rotation_recognizer)
    crop_view.addGestureRecognizer(tap_recognizer)
  end

  def viewDidAppear(animted)
    super

    crop_view.crop_rect = CROP_RECT
  end

  def reset
    @scale = 1

    image_view.transform = CGAffineTransformIdentity
    image_view.frame     = view.bounds
    image_view.transform = CGAffineTransformMakeScale(scale, scale)
  end

  def touchesBegan(touches, withEvent: event)
    handle_touches(event.allTouches)
  end

  def touchesMoved(touches, withEvent: event)
    handle_touches(event.allTouches)
  end

  def touchesEnded(touches, withEvent: event)
    handle_touches(event.allTouches)
  end

  def touchesCancelled(touches, withEvent: event)
    handle_touches(event.allTouches)
  end

  def handle_touches(touches)
    @touch_center = CGPointZero

    if touches.count >= 2
      touches.each do |touch|
        touch_location = touch.locationInView(image_view)

        @touch_center = CGPointMake(touch_center.x + touch_location.x, touch_center.y + touch_location.y)
      end

      @touch_center = CGPointMake(touch_center.x / touches.count, touch_center.y / touches.count)
    end
  end

  def handle_pan(recognizer)

    translation = recognizer.translationInView(image_view)
    transform   = CGAffineTransformTranslate(image_view.transform, translation.x, translation.y)

    image_view.transform = transform

    recognizer.setTranslation(CGPointZero, inView: crop_view)
  end

  def handle_pinch(recognizer)
    if recognizer.state == UIGestureRecognizerStateBegan
      @scale_center = @touch_center
    end

    delta_x = scale_center.x - image_view.bounds.size.width / 2.0
    delta_y = scale_center.y - image_view.bounds.size.height / 2.0

    transform = CGAffineTransformTranslate(image_view.transform, delta_x, delta_y)
    transform = CGAffineTransformScale(transform, recognizer.scale, recognizer.scale)
    transform = CGAffineTransformTranslate(transform, -delta_x, -delta_y)

    @scale *= recognizer.scale

    @image_view.transform = transform

    recognizer.scale = 1
  end

  def handle_rotation(recognizer)

    delta_x = touch_center.x - image_view.bounds.size.width / 2
    delta_y = touch_center.y - image_view.bounds.size.height / 2

    transform = CGAffineTransformTranslate(image_view.transform, delta_x, delta_y)
    transform = CGAffineTransformRotate(transform, recognizer.rotation)
    transform = CGAffineTransformTranslate(transform, -delta_x, -delta_y)

    image_view.transform = transform

    recognizer.rotation = 0
  end

  def handle_tap(recognizer)

    reset
  end

  def pan_recognizer
    @pan_recognizer ||= UIPanGestureRecognizer.alloc.initWithTarget(self, action: 'handle_pan:').tap do |recognizer|
      recognizer.cancelsTouchesInView = false
      recognizer.delegate             = self
    end
  end

  def tap_recognizer
    @tap_recognizer ||= UITapGestureRecognizer.alloc.initWithTarget(self, action: 'handle_tap:').tap do |recognizer|
      recognizer.numberOfTapsRequired = 2
    end
  end

  def rotation_recognizer
    @rotation_recognizer ||= UIRotationGestureRecognizer.alloc.initWithTarget(self, action: 'handle_rotation:').tap do |recognizer|
      recognizer.cancelsTouchesInView = false
      recognizer.delegate             = self
    end
  end

  def pinch_recognizer
    @pinch_recognizer ||= UIPinchGestureRecognizer.alloc.initWithTarget(self, action: 'handle_pinch:').tap do |recognizer|
      recognizer.cancelsTouchesInView = false
      recognizer.delegate             = self
    end
  end

  def source_image=(image)
    @source_iamge = image

    image_view.image = image
  end

  def setup_constraints
    view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
      'H:|[crop]|',
      options: 0,
      metrics: nil,
      views:   { 'crop' => crop_view }))

    view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
      'V:|[crop]|',
      options: 0,
      metrics: nil,
      views:   { 'crop' => crop_view }))
  end

  def image_view
    @image_view ||= UIImageView.alloc.init.tap do |view|
      view.translatesAutoresizingMaskIntoConstraints = false
    end
  end

  def crop_view
    @crop_view ||= Motion::ImageEditorView.alloc.init.tap do |view|
      view.translatesAutoresizingMaskIntoConstraints = false
    end
  end

  def prefersStatusBarHidden
    true
  end
end
