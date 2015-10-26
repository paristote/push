//
//  ViewController.swift
//  Push
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet var touchCounter:UILabel!
    @IBOutlet var touchGestureReco:UITapGestureRecognizer!
    var isForceTouchPossible:Bool = false
    
    let colors: [String: UIColor] = [
        "ice" : UIColor(red: 0.8, green: 0.8, blue: 1.0, alpha: 1.0),
        "cold" : UIColor.lightGrayColor(),
        "medium" : UIColor.purpleColor(),
        "warm" : UIColor.orangeColor(),
        "hot" : UIColor.redColor()
    ]
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        isForceTouchPossible = self.traitCollection.forceTouchCapability == UIForceTouchCapability.Available
        if !isForceTouchPossible {
            NSLog("3D Touch not available :(")
        } else {
            NSLog("3D Touch yeah :)")
        }
        touchCounter.text = "Tap anywhere to start!"

        self.view.addGestureRecognizer(touchGestureReco)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Touch Handling
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in (event?.touchesForView(self.view))! {
            NSLog("Touch at position X(%f) Y(%f)", touch.locationInView(nil).x, touch.locationInView(nil).y)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in (event?.touchesForView(self.view))! {
            if isForceTouchPossible {
                NSLog("Touch force: %f / %f", touch.force, touch.maximumPossibleForce)
                let forcePc:Int = Int(touch.force / touch.maximumPossibleForce * 100)
                touchCounter.text = String(format: "%d %%", forcePc);
                switch forcePc {
                case 20...39:
                    touchCounter.textColor = colors["cold"]
                case 40...59:
                    touchCounter.textColor = colors["medium"]
                case 60...79:
                    touchCounter.textColor = colors["warm"]
                case 80...100:
                    touchCounter.textColor = colors["hot"]
                default:
                    touchCounter.textColor = colors["ice"]
                }
            }
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }

}

