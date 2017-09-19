//
//  ViewController.swift
//  RFCircleView
//
//  Created by filiroman on 09/19/2017.
//  Copyright (c) 2017 filiroman. All rights reserved.
//

import UIKit
import RFCircleView

class ViewController: UIViewController {
  
  @IBOutlet weak var circleView: CircleView!
  @IBOutlet weak var plusButton: UIButton!
  @IBOutlet weak var minusButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
      
      circleView.useInternalGestureRecognizer = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  @IBAction func buttonPressed(_ sender: UIButton) {
    if sender == plusButton {
      circleView.counter += 1
    } else {
      circleView.counter -= 1
    }
  }
}

