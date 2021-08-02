import UIKit
import QuartzCore


public class PointlessSlider: UIControl {
  enum FullnessState{
    case full
    case low
    case normal
  }
  
  public var minimumValue = 0.0{
    didSet{
      updateLayerFrames()
    }
  }
  public var maximumValue = 1.0{
    didSet{
      updateLayerFrames()
    }
  }
  
  public var currentValue = 0.2{
    didSet{
//      currentValueView.setTitle("\(roundValue(currentValue, to: incrementValue))")
    }
  }
  //  {
  //    didSet(newValue){
  //      if newValue >= maximumValue{
  //        currentValue = maximumValue
  //      }
  //    }
  //  }
  
  public var incrementValue: Double = 1
  
  
  var previousLocation = CGPoint()
  
  private var fullness: FullnessState{
    guard maximumValue != 0, maximumValue > minimumValue else { return .full}
    switch (currentValue / maximumValue) * 100 {
    case 0...10:
      return .low
    case 95...:
      return .full
    default:
      return .normal
    }
  }
  
  public var trackTintColor = UIColor(white: 0.9, alpha: 1.0)
  public var trackHighlightTintColor: UIColor{
    switch fullness {
    case .full:
      return UIColor(red: 172/255, green: 237/255, blue: 71/255, alpha: 1.0)
    case .low:
      return UIColor(red: 237/255, green: 83/255, blue: 47/255, alpha: 1.0)
    case .normal:
      fallthrough
    default:
      return UIColor(red: 95/255, green: 135/255, blue: 236/255, alpha: 1.0)
    }
  }
  
  public var thumbTintColor = UIColor.white
  public var curvaceousness : CGFloat = 0.3
  
  
  public var isHasInsetsForThumb: Bool = true{
    didSet{
      updateLayerFrames()
    }
  }
  
  public var isContinious: Bool = false
  
  private var isEditable: Bool{
    get{
      return maximumValue > 0 ? true : false
    }
  }
  
  
  override public var frame: CGRect {
    didSet {
      updateLayerFrames()
    }
  }
  
  let trackLayer = PointlessSliderTrackLayer()
  let shadowLayer = PointlessSliderShadowLayer()
  let currentThumbView = PointlessSliderThumbView()
  let highlightedLayer = PointlessSliderHighlightedLayer()
  let currentValueView = PointlessSliderCurrentValueView()
  
  var thumbViewTrackingTouch: ((UITouch) -> ())?
  
  var thumbWidth: CGFloat {
    return CGFloat(bounds.height) * 2
  }
  
  override public init(frame: CGRect) {
    super.init(frame: frame)
    //    trackLayer.pointlessSlider = self
    //     trackLayer.contentsScale = UIScreen.main.scale
    //
    //     currentThumbLayer.pointlessSlider = self
    //     currentThumbLayer.contentsScale = UIScreen.main.scale
    //
    //     layer.addSublayer(trackLayer)
    //     layer.addSublayer(currentThumbLayer)
    //
    //
    //     updateLayerFrames()
    
    prepareSlider()
  }
  
  public override func didMoveToSuperview() {
    super.didMoveToSuperview()
    
  }
  
  required public init?(coder: NSCoder) {
    super.init(coder: coder)
    prepareSlider()
    
  }
  
  func prepareSlider(){
    trackLayer.needsDisplayOnBoundsChange = true
    trackLayer.pointlessSlider = self
    trackLayer.contentsScale = UIScreen.main.scale
    
    highlightedLayer.needsDisplayOnBoundsChange = true
    highlightedLayer.pointlessSlider = self
    highlightedLayer.contentsScale = UIScreen.main.scale
    
    shadowLayer.pointlessSlider = self
    shadowLayer.contentsScale = UIScreen.main.scale
    
    currentThumbView.pointlessSlider = self
    //currentThumbView.contentsScale = UIScreen.main.scale
    //    currentThumbLayer.position = CGPoint(x: 0, y: 0)
    //currentThumbView.backgroundColor = UIColor.red.withAlphaComponent(0.5)
    currentThumbView.translatesAutoresizingMaskIntoConstraints = false
    
    //currentValueView.setTitle("123122131223")
    self.translatesAutoresizingMaskIntoConstraints = false
    
    addSubview(currentValueView)
    
    layer.insertSublayer(trackLayer, at: 0)
    layer.insertSublayer(shadowLayer, at: 1)
    layer.insertSublayer(highlightedLayer, at: 2)
    
    
    updateLayerFrames()
  }
  
  func screenSize() -> CGSize{
    let screenSize: CGRect = UIScreen.main.bounds
//    let screenWidth = screenSize.width
//    let screenHeight = screenSize.height
    return screenSize.size
  }
  
  public func updateLayerFrames() {
    
    
    if isHasInsetsForThumb{
      trackLayer.frame = bounds.insetBy(dx: thumbWidth / 2, dy: 0)
      highlightedLayer.frame = trackLayer.frame
    }else{
      trackLayer.frame = bounds
      highlightedLayer.frame = trackLayer.frame
    }
    
    trackLayer.setNeedsDisplay()
    highlightedLayer.setNeedsDisplay()
    
    shadowLayer.frame = trackLayer.frame
    shadowLayer.setNeedsDisplay()
    
    let currentThumbCenter = CGFloat(positionForValue(value: currentValue))
    let currentThumbPosition = CGPoint(x: CGFloat(positionForValue(value: currentValue)), y: 0)
    
    let currentValueViewHeight: CGFloat = 34
    let currentValueViewWidth: CGFloat = 100
    let currentValueViewYOffset: CGFloat = 80

    currentValueView.frame = CGRect(x: 0, y: 0, width: currentValueViewWidth, height: currentValueViewHeight)
    currentValueView.frame.origin = convert(CGPoint(x: currentThumbCenter - currentValueViewWidth / 2, y: center.y - currentValueViewYOffset), to: currentValueView.superview)
    
    if let currentValueViewSuperView = currentValueView.superview{
      if currentValueView.frame.origin.x < 0{
        currentValueView.frame.origin.x = 0
      }
      
      if currentValueView.frame.origin.x + currentValueViewWidth > currentValueViewSuperView.bounds.width{
        currentValueView.frame.origin.x = currentValueViewSuperView.bounds.width - currentValueViewWidth
      }
    }

    
//    currentThumbView.frame = CGRect(x: currentThumbCenter - thumbWidth/2, y: 0, width: thumbWidth, height: thumbWidth * 2)
    
    currentThumbView.frame = CGRect(origin: .zero, size: CGSize(width: thumbWidth, height: thumbWidth))
    currentThumbView.center = convert(CGPoint(x: currentThumbPosition.x, y: currentThumbPosition.y + frame.height/2), to: currentThumbView.superview)
    
    print("1 \(currentThumbView.center.y)")
    print("1 \(center.y)")
    //currentThumbView.center.y = center.y
    print("2 \(currentThumbView.center.y)")
    print("2 \(center.y)")
    //currentThumbLayer.backgroundColor = UIColor.red.withAlphaComponent(0.3).cgColor
    currentThumbView.setNeedsDisplay()
  }
  
  func positionForValue(value: Double) -> Double {
    guard maximumValue != 0 else{
      return Double(bounds.width)
    }
    
    if isHasInsetsForThumb{
      return Double(bounds.width - thumbWidth) * (value - minimumValue) /
        (maximumValue - minimumValue)
    }else{
      return Double(bounds.width) * (value - minimumValue) /
        (maximumValue - minimumValue)
    }
  }
  
  
  public func setValue(_ value: Double){
    if value >= maximumValue{
      self.currentValue = maximumValue
    }else{
      self.currentValue = value
    }
    

    updateLayerFrames()

//    currentValueView.setTitle("\( roundValue(currentValue, to: incrementValue))")

    currentValueView.setTitle(format(value: roundValue(currentValue, to: incrementValue)))
  }
  
//  override public func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
////    previousLocation = touch.location(in: self)
////
////    // Hit test the thumb layers
////    if currentThumbView.frame.contains(previousLocation) {
////      currentThumbView.isHighlighted = true
////    }
//
//    return true
//  }
  
  public func beginTracking(){
    guard isEditable else { return }
    currentValueView.animatePresent()
  }
  
  public override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    guard isEditable else { return false }
    return currentThumbView.isHighlighted
  }
  
  func boundValue(value: Double, toLowerValue lowerValue: Double, upperValue: Double) -> Double {
    return min(max(value, lowerValue), upperValue)
  }
  
  override public func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    guard isEditable else { return false}
    let location = touch.location(in: self)
    
    // 1. Determine by how much the user has dragged
    let deltaLocation = Double(location.x - previousLocation.x)
    var deltaValue: Double = 0
    if isHasInsetsForThumb{
      deltaValue = (maximumValue - minimumValue) * deltaLocation / Double(bounds.width - thumbWidth)
    }else{
      deltaValue = (maximumValue - minimumValue) * deltaLocation / Double(bounds.width)
    }
    
    
    previousLocation = location
    
    // 2. Update the values
    if currentThumbView.isHighlighted {
      currentValue += deltaValue
      currentValue = boundValue(value: currentValue, toLowerValue: minimumValue, upperValue: maximumValue)
    }
    
    // 3. Update the UI
    CATransaction.begin()
    CATransaction.setDisableActions(true)
    
    updateLayerFrames()
    currentValueView.setTitle(format(value: roundValue(currentValue, to: incrementValue)))
//    currentValueView.setTitle("\( roundValue(currentValue, to: incrementValue))")
    
    CATransaction.commit()
    if isContinious{
      sendActions(for: .valueChanged)
    }
    return true
  }
  
  override public func endTracking(_ touch: UITouch?, with event: UIEvent?) {
    guard isEditable else { return }
    if !isContinious{
      currentValue = roundValue(currentValue, to: incrementValue)
      sendActions(for: .valueChanged)
    }
    currentThumbView.isHighlighted = false
    currentValueView.animateDismiss()
  }
  
  fileprivate func roundValue(_ value: Double, to increment: Double) -> Double {
    if increment == 0 {
      return value
    }
    return increment * Double(round(value / increment))
  }
  
  fileprivate func format(value: Double) -> String {
     return value.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", value) : String(value)
  }
  
  public func boundThumb(to view: UIView?){
    if let destinationView = view{
      if currentThumbView.superview != nil, currentValueView.superview != nil{
        currentThumbView.removeFromSuperview()
        currentValueView.removeFromSuperview()
      }
      
      destinationView.addSubview(currentThumbView)
      destinationView.bringSubviewToFront(currentThumbView)
      destinationView.addSubview(currentValueView)
      destinationView.bringSubviewToFront(currentValueView)
    }else{
      currentThumbView.removeFromSuperview()
      currentValueView.removeFromSuperview()
    }
  }
  
  
}
