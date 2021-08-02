//
//  PointlessSliderCurrentValueView.swift
//  PointlessSlider
//
//  Created by Sergey Cheliuskin-Galich on 01.04.2021.
//  Copyright © 2021 Sergey Cheliuskin-Galich. All rights reserved.
//

import UIKit

class PointlessSliderCurrentValueView: UIView{
  
  private(set) var isPresented: Bool = false

  
  lazy var textLabel: UILabel = {
    return UILabel()
  }()
  
  override var frame: CGRect{
    didSet{
      textLabel.frame = bounds
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    prepareView()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    prepareView()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
  }

  private func prepareView(){
    self.translatesAutoresizingMaskIntoConstraints = false
    self.alpha = 0
    addSubview(textLabel)

    
    textLabel.textAlignment = .center
    textLabel.font = .systemFont(ofSize: 14, weight: .light)
    
    layer.cornerRadius = 5
    layer.backgroundColor = UIColor.white.cgColor
    layer.shadowOpacity = 0.1
    layer.shadowRadius = 20
    layer.shadowColor = UIColor.black.cgColor
  }
  
  func setTitle(_ title: String?) {
    textLabel.text = title
  }
  
  func animatePresent(){
    if true{
      UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
        self.alpha = 1
      }, completion: {[weak self] _ in
        self?.isPresented = true
      })
    }
  }
  
  func animateDismiss(){
    UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
      self.alpha = 0
    }, completion: nil)
    isPresented = false
  }
}
