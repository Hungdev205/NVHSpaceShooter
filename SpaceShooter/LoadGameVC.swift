//
//  LoadGameVC.swift
//  SpaceShooter
//
//  Created by Hùng Nguyễn  on 8/2/16.
//  Copyright © 2016 Tien Son. All rights reserved.
//

import UIKit

class LoadGameVC: UIViewController {

    var progessView: UIProgressView?
    var progessLabel: UILabel?
    var background: UIImageView?
    
    var timer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addControls()
        addGestures()
    }

    
    func addControls()  {
        // create background
        background = UIImageView(image: UIImage(named: "spaceShooter.jpg"))
        background?.contentMode = .ScaleAspectFill
        view.addSubview(background!)
        
        // Create Progress View Control
        progessView = UIProgressView(progressViewStyle: UIProgressViewStyle.Default)
        let progessFrame = CGRectMake(view.center.x, view.center.y - 100, 600, 21)
        progessView?.frame = progessFrame
        progessView?.center = self.view.center
        view.addSubview(progessView!)
        
        // Add Label
        progessLabel = UILabel()
        let frame = CGRectMake(view.center.x - 25, view.center.y - 50, 100 ,50 )
        progessLabel?.frame = frame
        view.addSubview(progessLabel!)
    }
    
    func addGestures() {
        // Add Single Tap and Doube Tap Gestures
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.numberOfTapsRequired = 1
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTap.numberOfTapsRequired = 2
        
        view.addGestureRecognizer(tap)
        view.addGestureRecognizer(doubleTap)
        tap.requireGestureRecognizerToFail(doubleTap)
        
    }

    func handleTap(gesture: UITapGestureRecognizer)  {
        if gesture.state == .Ended {
           timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
        }
        
        if progessLabel?.text == "100.0 %"
        {
            let playGame = self.storyboard?.instantiateViewControllerWithIdentifier("MainVC") as! ViewController
            self.navigationController?.pushViewController(playGame, animated: true)
        }

    }
    
    func handleDoubleTap(gesture: UITapGestureRecognizer) {
        if gesture.state == .Ended {
            progessView?.progress = 0.0
            progessLabel?.text = "0 %"
            timer.invalidate()
        }
    }
    
    
    func updateProgress() {
        progessView?.progress += 0.20
        let progressValue = self.progessView?.progress
        progessLabel?.text = "\(progressValue! * 100) %"
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
