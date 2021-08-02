import UIKit
import QuartzCore

class PointlessSliderShadowLayer: CALayer {
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
      //let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)

      // Shadow path (1pt ring around bounds)
      let path = UIBezierPath(roundedRect: bounds.insetBy(dx: -3, dy:-3), cornerRadius: cornerRadius)
      let cutout = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).reversing()
      
      
      path.append(cutout)
      
      shadowPath = path.cgPath
      masksToBounds = true
      // Shadow properties
      shadowColor = UIColor.black.cgColor
      shadowOffset = CGSize(width: 0, height: 0)
      shadowOpacity = 0.25
      shadowRadius = 5
      
      //backgroundColor = UIColor.red.withAlphaComponent(0).cgColor
      self.cornerRadius = cornerRadius
     // ctx.fillPath()
      //innerShadow.cornerRadius = self.frame.size.height/2
      
//      ctx.addPath(path.cgPath)
//
//      // Fill the track
//      ctx.setFillColor(slider.trackTintColor.cgColor)
//      ctx.addPath(path.cgPath)
//      ctx.fillPath()
//
//      // Fill the highlighted range
//      ctx.setFillColor(slider.trackHighlightTintColor.cgColor)
//      let currentValuePosition = CGFloat(slider.positionForValue(value: slider.currentValue))
//      let rect = CGRect(x: CGFloat(0), y: CGFloat(0.0), width: currentValuePosition, height: bounds.height)
//      let highlightedPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
//
//
//      ctx.addPath(highlightedPath.cgPath)
//      ctx.fillPath()
    }
  }
  
}

