//
//  CircleView.swift
//  CircleView
//
//  Created by Roman Filippov on 13/09/2017.
//  Copyright © 2017 romanfilippov. All rights reserved.
//

import UIKit

@IBDesignable public class CircleView: UIView {
  
  var circleLabel: UILabel!
  var panRecognizer: UIPanGestureRecognizer!
  
  @IBInspectable var outlineColor: UIColor = UIColor.blue
  @IBInspectable var counterColor: UIColor = UIColor.orange
  @IBInspectable var minValue: Int = 0
  @IBInspectable var maxValue: Int = 8
  @IBInspectable var lineWidth: CGFloat = 4.0
  @IBInspectable var arcWidth: CGFloat = 80.0
  @IBInspectable var arcAngle: Int = 270
  public var useInternalGestureRecognizer: Bool = false {
    didSet {
      if (useInternalGestureRecognizer)
      {
        guard panRecognizer == nil else {
          print("Not possible nil!")
          return
        }
        
        panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(panGesture:)))
        self.addGestureRecognizer(panRecognizer)
        
      } else {
        guard panRecognizer != nil else {
          print("Not possible not nil!")
          return
        }
        
        panRecognizer.removeTarget(self, action: #selector(handlePan(panGesture:)))
        panRecognizer = nil
      }
    }
  }
  
  
  var _counter: Int = 0 {
    didSet {
      
      guard _counter >= minValue else {
        _counter = minValue
        return
      }
      
      guard _counter <= maxValue else {
        _counter = maxValue
        return
      }
      
      circleLabel.text = String(_counter)
      setNeedsDisplay()
    }
  }
  
  @IBInspectable var counter: Int {
    get {
      return _counter
    }
    set (aNewValue) {
      
      if aNewValue != _counter {
        _counter = aNewValue
      }
    }
  }
  
  var radius: CGFloat {
    get {
      return max(bounds.width, bounds.height)
    }
  }
  
  var valuesCount: Int {
    get {
      return maxValue-minValue+1
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    createLabel()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    createLabel()
  }
  
  
  func createLabel() {
    
    circleLabel = UILabel(frame: CGRect.zero)
    circleLabel.text = "0"
    circleLabel.font = UIFont.systemFont(ofSize: 36)
    circleLabel.textAlignment = .center
    circleLabel.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(circleLabel)
    
    updateConstraints()
  }
  
  
  override public func updateConstraints() {
    
    let xCenter = NSLayoutConstraint(item: circleLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
    
    let yCenter = NSLayoutConstraint(item: circleLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
    
    NSLayoutConstraint.activate([xCenter, yCenter])
    
    super.updateConstraints()
  }
  
  override public func draw(_ rect: CGRect) {
    
    guard lineWidth>0 else {
      return
    }
    
    guard maxValue>minValue else {
      return
    }
    
    guard arcWidth>0 && arcAngle>0 else {
      return
    }
    
    guard (minValue...maxValue) ~= counter else {
      return
    }
    
    let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
    
    let arcAngleRadians = CGFloat(arcAngle.degreesToRadians)
    
    
    let startAngle: CGFloat = 3 * .pi/2 - arcAngleRadians/2
    let endAngle: CGFloat = 3 * .pi/2 + arcAngleRadians/2
    
    let path = UIBezierPath(arcCenter: center,
                            radius: radius/2 - arcWidth/2,
                            startAngle: startAngle,
                            endAngle: endAngle,
                            clockwise: true)
    
    path.lineWidth = arcWidth
    counterColor.setStroke()
    path.stroke()
    
    
    let arcLengthPerValue = arcAngleRadians / CGFloat(maxValue - minValue)
    let outlineEndAngle = arcLengthPerValue * CGFloat(counter - minValue) + startAngle
    
    // outer line
    let outlinePath = UIBezierPath(arcCenter: center,
                                   radius: (bounds.width - lineWidth)/2,
                                   startAngle: startAngle,
                                   endAngle: outlineEndAngle,
                                   clockwise: true)
    
    //inner line
    outlinePath.addArc(withCenter: center,
                       radius: bounds.width/2 - arcWidth + lineWidth/2,
                       startAngle: outlineEndAngle,
                       endAngle: startAngle,
                       clockwise: false)
    
    outlinePath.close()
    outlineColor.setStroke()
    outlinePath.lineWidth = lineWidth
    outlinePath.stroke()
    
  }
  
  // MARK: - UIPanGestureRecognizer delegate
  
  func handlePan(panGesture:UIPanGestureRecognizer) {
    
    switch panGesture.state {
      
    case .began,
         .changed:
      let translation = panGesture.translation(in: self)
      let pointsPerValue = radius / CGFloat(valuesCount)
      var maxDelta: CGFloat = 0
      if abs(translation.x) > abs(translation.y) {
        maxDelta = translation.x
      } else {
        maxDelta = -translation.y
      }
      counter = Int(maxDelta) / Int(pointsPerValue)
      
    case .ended:
      panGesture.setTranslation(CGPoint.zero, in: self)
      
    default:
      return
    }
    
  }
  
}
