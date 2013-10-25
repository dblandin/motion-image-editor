class Motion; class ImageEditorController < UIViewController
  DEFAULT_CROP_WIDTH  = 320
  DEFAULT_CROP_HEIGHT = 320

  def viewDidLoad
    super

    view.multipleTouchEnabled   = true
    view.userInteractionEnabled = true
    view.layer.masksToBounds    = true
  end

  def pan_recognizer
    @pan_recognizer ||= UIPanGestureRecognizer.alloc.initWithTarget(self, action: 'handle_pan:').tap do |recognizer|
      recognizer.cancelsTouchesInView = false
      recognizer.delegate             = self
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

  def tap_recognizer
    @tap_recognizer ||= UITapGestureRecognizer.alloc.initWithTarget(self, action: 'handle_tap:').tap do |recognizer|
      recognizer.numberOfTapsRequired = 2
    end
  end

  def source_image=(image)
    @source_image = image
    @preview_image = nil
  end

  def preview_image
    @preview_image ||= begin
      if source_image
        if source_image.size.height > MAX_UI_IMAGE_SIZE || source_image.size.width > MAX_UI_IMAGE_SIZE
          aspect = source_image.size.height / source_image.size.width

          if aspect <= 1.0 # portrait
            size = CGSizeMake(PREVIEW_IMAGE_SIZE, PREVIEW_IMAGE_SIZE * aspect)
          else # landscape
            size = CGSizeMake(PREVIEW_IMAGE_SIZE, PREVIEW_IMAGE_SIZE * aspect)
          end

          scaled_image(source_image, size: size, quality: INTERPOLATION_LOW)
        end
      end
    end
  end

  def crop_rect=(rect)
    crop_view.crop_rect = rect
  end

  def crop_rect
    if CGSizeEqualToSize(crop_view.crop_rect.size, CGSizeZero)
      origin = [(crop_view.bounds.size.width - DEFAULT_CROP_WIDTH) / 2, (crop_view.bounds.size.height - DEFAULT_CROP_HEIGHT) / 2]
      size   = [DEFAULT_CROP_WIDTH, DEFAULT_CROP_HEIGHT]

      crop_view.crop_rect = [origin, size]
    end

    crop_view.crop_rect
  end

  def crop_size=(size)
    rect_origin = [(crop_view.bounds.size.width - size.width) / 2, (crop_view.bounds.size.height - size.height) / 2]
    rect_size   = [DEFAULT_CROP_WIDTH, DEFAULT_CROP_HEIGHT]

    self.crop_rect = [rect_origin, rect_size]
  end

  def crop_view
    @crop_view ||= ImageEditorView.alloc.init
  end

  def image_view
    @image_view ||= UIImageView.alloc.init
  end
end; end
