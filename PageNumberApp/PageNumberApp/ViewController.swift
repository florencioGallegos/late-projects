//
//  ViewController.swift
//  PageNumberApp
//
//  Created by MAC Consultant on 3/9/19.
//  Copyright © 2019 MAC Consultant. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pageNoLabel: UILabel!
    @IBOutlet weak var pageImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pageNoLabel.isUserInteractionEnabled = true
        pageImage.isUserInteractionEnabled = true
        
        pageImage.image = UIImage(named: "blank.png")
        pageNoLabel.text = ("1")
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGesture))
        print ("here")
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        pageImage.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        pageImage.addGestureRecognizer(swipeRight)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @objc func swipeGesture(sendr:UIGestureRecognizer) {
    var pageNo = Int(pageNoLabel.text!)
    
    if let swipeGesture = sendr as? UISwipeGestureRecognizer {
        switch swipeGesture.direction {
        case UISwipeGestureRecognizer.Direction.right:
            if pageNo! > 1 {
            pageNo! = pageNo! - 1
            pageNoLabel.text = String(pageNo!)
            print("swipe right ")
            }
            else { pageNo = 1 }
            print("swipe right ")
            print(pageNo!)
        case UISwipeGestureRecognizer.Direction.left:
            if pageNo! <= 100 {
            pageNo! = pageNo! + 1
                pageNoLabel.text = String(pageNo!)
                print("swipe left ")            }
            else { pageNo = 100 }
            print(pageNo)
        default: break
            }
    }
  }
}

