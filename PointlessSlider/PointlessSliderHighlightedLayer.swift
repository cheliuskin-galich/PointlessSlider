//
//  PointlessSliderHighlightedLayer.swift
//  PointlessSlider
//
//  Created by Sergey Cheliuskin-Galich on 12.03.2021.
//  Copyright © 2021 Sergey Cheliuskin-Galich. All rights reserved.
//
import UIKit
import QuartzCore

class PointlessSliderHighlightedLayer: CALayer {
  weak var pointlessSlider: PointlessSlider?

  private let amountLayer: CALayer = CALayer()
  
//  override func draw(in ctx: CGContext) {
//    if let slider = pointlessSlider {
//      cornerRadius = bounds.height * slider.curvaceousness / 2.0
//      ctx.setFillColor(slider.trackHighlightTintColor.cgColor)
//      let currentValuePosition = CGFloat(slider.positionForValue(value: slider.currentValue))
//      let rect = CGRect(x: CGFloat(0), y: CGFloat(0.0), width: currentValuePosition, height: bounds.height)
//      let highlightedPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
//
//
//      ctx.addPath(highlightedPath.cgPath)
//      ctx.fillPath()
//    }
//  }
  
  
  override func display() {
    super.display()
    if let slider = pointlessSlider {
      let currentValuePosition = CGFloat(slider.positionForValue(value: slider.currentValue))
      amountLayer.cornerRadius = bounds.height * slider.curvaceousness / 2.0
      amountLayer.backgroundColor = slider.trackHighlightTintColor.cgColor
      amountLayer.frame = CGRect(x: CGFloat(0), y: CGFloat(0.0), width: currentValuePosition, height: bounds.height)
    }
  }
  
  override init() {
    super.init()
    self.addSublayer(amountLayer)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
//  override func displayIfNeeded() {
//    super.displayIfNeeded()
//    if let slider = pointlessSlider {
//      cornerRadius = bounds.height * slider.curvaceousness / 2.0
//
//      ctx.setFillColor(slider.trackHighlightTintColor.cgColor)
//      let currentValuePosition = CGFloat(slider.positionForValue(value: slider.currentValue))
//      let rect = CGRect(x: CGFloat(0), y: CGFloat(0.0), width: currentValuePosition, height: bounds.height)
//      let highlightedPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
//
//
//      ctx.addPath(highlightedPath.cgPath)
//      ctx.fillPath()
//    }
//  }
  
//  override init() {
//    super.init()
//  }
//
//  required init?(coder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }
  
}

