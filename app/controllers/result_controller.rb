class ResultController < UIViewController
  def viewDidLoad
    super

    view.backgroundColor = UIColor.whiteColor

    view.addSubview(image_view)
    image_view.frame = view.bounds
  end

  def image=(image)
    image_view.image = image
  end

  def image_view
    @image_view ||= UIImageView.alloc.init.tap do |view|
      view.contentMode = UIViewContentModeScaleAspectFit
    end
  end
end
