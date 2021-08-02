import UIKit
import QuartzCore

class PointlessSliderTrackLayer: CALayer {
  weak var pointlessSlider: PointlessSlider?
  
//  override init() {
//    super.init()
//    needsDisplayOnBoundsChange = true
//  }
//  
//  required init?(coder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }
  
  override func draw(in ctx: CGContext) {
    if let slider = pointlessSlider {
      // Clip
      let cornerRadius = bounds.height * slider.curvaceousness / 2.0
      let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
      ctx.addPath(path.cgPath)
      
      // Fill the track
      ctx.setFillColor(slider.trackTintColor.cgColor)
      ctx.addPath(path.cgPath)
      ctx.fillPath()
    }
  }
  
}

