import UIKit
import QuartzCore

class PointlessSliderThumbView: UIControl {
//  var highlighted = false
  weak var pointlessSlider: PointlessSlider?
  
//  override var frame: CGRect{
//    didSet{
//      frame.origin.y = pointlessSlider?.frame.origin.y ?? 0
//    }
//  }
  
  override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    let previousLocation = touch.location(in: pointlessSlider)
    pointlessSlider?.previousLocation = previousLocation
    pointlessSlider?.beginTracking()
    return true
  }
  
  override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    return pointlessSlider?.continueTracking(touch, with: event) ?? false
  }
  
  override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
    pointlessSlider?.endTracking(touch, with: event)
  }
}

