//
//  TitleViewController.swift
//  MathGameplayAlpha
//
//  Created by Justin Lee on 8/1/17.
//  Copyright © 2017 Justin Lee. All rights reserved.
//

import UIKit

class TitleViewController: UIViewController {

    // The title of the game
    @IBOutlet weak var gameTitle: UILabel!
    // Click to be taken to "Stage 1"
    @IBOutlet weak var playBtn: UIButton!
    // Click to reset progress
    @IBOutlet weak var resetBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sets locations based on size of devoce
        gameTitle.center = CGPoint(x: view.frame.width / 2, y: view.frame.height * 0.13)
        playBtn.center = CGPoint(x: view.frame.width / 2, y: view.frame.height * 0.63)
        resetBtn.center = CGPoint(x: view.frame.width * 0.10, y: view.frame.height * 0.10)
        
        // Loads current progress, if available
        if let _ = UserDefaults.standard.object(forKey: "isActive") as? [Bool] {
            // Do nothing
        } else {
            UserDefaults.standard.set([true, false], forKey: "isActive")
        }
    }
    
    // Resets current progress
    @IBAction func resetGame(_ sender: Any) {
        UserDefaults.standard.set([true, false], forKey: "isActive")
    }

}
