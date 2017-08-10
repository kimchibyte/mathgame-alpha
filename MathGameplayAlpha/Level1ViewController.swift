//
//  Level1ViewController.swift
//  MathGameplayAlpha
//
//  Created by Justin Lee on 8/1/17.
//  Copyright © 2017 Justin Lee. All rights reserved.
//

import UIKit

class Level1ViewController: UIViewController {

    // Title of the Stage
    @IBOutlet weak var levelBtn: UILabel!
    // Button to begin Level 1
    @IBOutlet weak var L1: UIButton!
    // Button to begin Level 2
    @IBOutlet weak var L2: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sets the Stage title's location
        levelBtn.center = CGPoint(x: view.frame.width / 2, y: view.frame.height * 0.04)

        // Sets the buttons' locations and usability depending on the current progress
        let active: [Bool] = UserDefaults.standard.object(forKey: "isActive") as! [Bool]
        L1.isEnabled = active[0]
        L1.alpha = CGFloat(NSNumber(value: active[0]))
        L1.center = CGPoint(x: view.frame.width * 0.20, y: view.frame.height * 0.77)
        L2.isEnabled = active[1]
        L2.alpha = CGFloat(NSNumber(value: active[1]))
        L2.center = CGPoint(x: view.frame.width * 0.63, y: view.frame.height * 0.65)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Stores the destination StoryBoard as a constant
        let dest: L1StageViewController = segue.destination as! L1StageViewController
        // Sets up the levels
        if (segue.identifier == "s1l1") {
            dest.setup = [1, 2, 3, 0, 5, 6]
            dest.levelNum = 1
        } else if (segue.identifier == "s1l2") {
            dest.setup = [1, 4, 0, 0, 3, 3]
            dest.levelNum = 2
        }
    }

}
