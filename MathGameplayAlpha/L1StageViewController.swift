//
//  L1StageViewController.swift
//  MathGameplayAlpha
//
//  Created by Justin Lee on 8/1/17.
//  Copyright © 2017 Justin Lee. All rights reserved.
//

import UIKit

class L1StageViewController: UIViewController {

    // Displays the goal value
    @IBOutlet weak var target: UILabel!
    // Clicked to check the answer
    @IBOutlet weak var checkBtn: UIButton!
    // Pops up after each check
    @IBOutlet weak var endCard: UIButton!
    // Second to last = num of slots, Last = target num
    var setup = [0, 0, 0, 0, 0, 0]
    // Slot button
    @IBOutlet weak var S1: UIButton!
    @IBOutlet weak var S2: UIButton!
    @IBOutlet weak var S3: UIButton!
    @IBOutlet weak var S4: UIButton!
    @IBOutlet weak var S5: UIButton!
    // Number buttons
    @IBOutlet weak var N1: UIButton!
    @IBOutlet weak var N2: UIButton!
    @IBOutlet weak var N3: UIButton!
    @IBOutlet weak var N4: UIButton!
    // Operator buttons
    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var sub: UIButton!
    @IBOutlet weak var mul: UIButton!
    @IBOutlet weak var div: UIButton!
    // Saved buttons
    var savedSlot: UIButton? = nil
    var savedNum: UIButton? = nil
    var savedOp: UIButton? = nil
    var numBtns = [String: UIButton]()
    var slotOrder: [UIButton] = []
    // Keeps track of whether the player won the level
    private var isSuccessful: Bool = false
    // Keeps track of the level number
    var levelNum: Int = 0
    
    
    // Action when a slot button is clicked
    @IBAction func slotClicked(_ sender: UIButton) {
        // Cond: Num is active
        if (savedNum != nil) {
            // Send the number back to its previous slot
            if let num = numBtns[sender.currentTitle!] {
                num.setTitle(sender.currentTitle!, for: UIControlState())
            }
            sender.setTitle(savedNum?.currentTitle!, for: UIControlState())
            savedNum?.setTitle("", for: UIControlState())
            savedNum = nil
        }
        // Cond: Op is active
        else if (savedOp != nil) {
            // Send the number back to its previous slot
            if let num = numBtns[sender.currentTitle!] {
                num.setTitle(sender.currentTitle!, for: UIControlState())
            }
            sender.setTitle(savedOp?.currentTitle!, for: UIControlState())
            savedOp = nil
        }
        // Cond: Num and Op are inactive
        else {
            // Cond: Slot is active
            if (savedSlot != nil) {
                if (savedSlot == sender) {
                    let num = numBtns[sender.currentTitle!]
                    num?.setTitle(sender.currentTitle!, for: UIControlState())
                    sender.setTitle("", for: UIControlState())
                } else {
                    let slotString = savedSlot?.currentTitle
                    savedSlot?.setTitle(sender.currentTitle!, for: UIControlState())
                    sender.setTitle(slotString, for: UIControlState())
                }
                savedSlot = nil
            }
            // Cond: Slot is inactive
            else {
                savedSlot = sender
            }
        }
    }
    // Action when a number button is clicked
    @IBAction func numClicked(_ sender: UIButton) {
        // Cond: Slot is active
        if (savedSlot != nil) {
            savedSlot = nil
            savedNum = sender
        }
        // Cond: Op is active
        else if (savedOp != nil) {
            savedOp = nil
            savedNum = sender
        }
        // Cond: Slot and Op are inactive
        else {
            if (sender.currentTitle! != "") {
                savedNum = sender
                // Add the number button to the dictionary if it doesn't exist
                if let _ = numBtns.index(forKey: sender.currentTitle!) {
                    // Does nothing
                } else {
                    numBtns[sender.currentTitle!] = sender
                }
            } else {
                savedNum = nil
            }
        }
    }
    // Action when an operator button is clicked
    @IBAction func opClicked(_ sender: UIButton) {
        // Cond: Slot is active
        if (savedSlot != nil) {
            savedSlot = nil
        }
        // Cond: Num is active
        else if (savedNum != nil) {
            savedNum = nil
        }
        savedOp = sender
    }
    // Checks the given answer and displays the "win screen" is correct
    @IBAction func checkAnswer(_ sender: UIButton) {
        var endString = "Try again!"
        if (calcEquation(ind: 0, val: -1, gap: false) == setup[setup.count - 1]) {
            isSuccessful = true
            endString = "You win!"
        }
        endCard.setTitle(endString, for: UIControlState())
        endCard.isEnabled = true
        endCard.alpha = 1.0
    }
    // Checks if the user is successful
    @IBAction func checkWin(_ sender: Any) {
        if (isSuccessful) {
            var levels: [Bool] = UserDefaults.standard.object(forKey: "isActive") as! [Bool]
            if (levelNum < levels.count) {
                levels[levelNum] = true
            }
            UserDefaults.standard.set(levels, forKey: "isActive")
            performSegue(withIdentifier: "returnS1", sender: sender)
        } else {
            endCard.isEnabled = false
            endCard.alpha = 0.0
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Sets up the "main" buttons
        setupNum()
        setupSlot()
        setupOp()
        
        // Sets up the label displaying the target value
        target.text = String(setup[setup.count - 1])
        target.center = CGPoint(x: view.frame.width / 2, y: view.frame.height * 0.08)
        
        // Sets up the button that checks the current submission
        checkBtn.center = CGPoint(x: view.frame.width * 0.87, y: view.frame.height * 0.08)
        
        // Positions the message that appears after each check
        endCard.center = CGPoint(x: view.frame.width / 2, y: view.frame.height * 0.21)
        endCard.isEnabled = false
        endCard.alpha = 0.0
    }
    
    // Sets up the number buttons
    private func setupNum() {
        // Number of Number Buttons to be displayed
        var num = 0
        while (setup[num] != 0 && num < 4) {
            num = num + 1
        }
        var x_pct: CGFloat
        let x_demon = Double (num + 1)
        if (0 < num) {
            x_pct = CGFloat(1.0 / x_demon)
            N1.center = CGPoint(x: view.frame.width * x_pct, y: view.frame.height * 0.61)
            N1.setTitle(String(setup[0]), for: UIControlState())
        } else {
            N1.isEnabled = false
            N1.alpha = 0.0
        }
        if (1 < num) {
            x_pct = CGFloat(2.0 / x_demon)
            N2.center = CGPoint(x: view.frame.width * x_pct, y: view.frame.height * 0.61)
            N2.setTitle(String(setup[1]), for: UIControlState())
        } else {
            N2.isEnabled = false
            N2.alpha = 0.0
        }
        if (2 < num) {
            x_pct = CGFloat(3.0 / x_demon)
            N3.center = CGPoint(x: view.frame.width * x_pct, y: view.frame.height * 0.61)
            N3.setTitle(String(setup[2]), for: UIControlState())
        } else {
            N3.isEnabled = false
            N3.alpha = 0.0
        }
        if (3 < num) {
            x_pct = CGFloat(4.0 / x_demon)
            N4.center = CGPoint(x: view.frame.width * x_pct, y: view.frame.height * 0.61)
            N4.setTitle(String(setup[3]), for: UIControlState())
        } else {
            N4.isEnabled = false
            N4.alpha = 0.0
        }
    }
    // Sets up the slot buttons and adds them to slotOrder
    private func setupSlot() {
        // Number of Slot Buttons to be displayed
        let num = setup[setup.count - 2]
        var x_pct: CGFloat
        let x_demon = Double (num + 1)
        if (0 < num) {
            x_pct = CGFloat(1.0 / x_demon)
            S1.center = CGPoint(x: view.frame.width * x_pct, y: view.frame.height * 0.24)
            S1.setTitle("", for: UIControlState())
            slotOrder.append(S1)
        } else {
            S1.isEnabled = false
            S1.alpha = 0.0
        }
        if (1 < num) {
            x_pct = CGFloat(2.0 / x_demon)
            S2.center = CGPoint(x: view.frame.width * x_pct, y: view.frame.height * 0.24)
            S2.setTitle("", for: UIControlState())
            slotOrder.append(S2)
        } else {
            S2.isEnabled = false
            S2.alpha = 0.0
        }
        if (2 < num) {
            x_pct = CGFloat(3.0 / x_demon)
            S3.center = CGPoint(x: view.frame.width * x_pct, y: view.frame.height * 0.24)
            S3.setTitle("", for: UIControlState())
            slotOrder.append(S3)
        } else {
            S3.isEnabled = false
            S3.alpha = 0.0
        }
        if (3 < num) {
            x_pct = CGFloat(4.0 / x_demon)
            S4.center = CGPoint(x: view.frame.width * x_pct, y: view.frame.height * 0.24)
            S4.setTitle("", for: UIControlState())
            slotOrder.append(S4)
        } else {
            S4.isEnabled = false
            S4.alpha = 0.0
        }
        if (4 < num) {
            x_pct = CGFloat(5.0 / x_demon)
            S5.center = CGPoint(x: view.frame.width * x_pct, y: view.frame.height * 0.24)
            S5.setTitle("", for: UIControlState())
            slotOrder.append(S5)
        } else {
            S5.isEnabled = false
            S5.alpha = 0.0
        }
    }
    // Sets up the operator buttons
    private func setupOp() {
        add.center = CGPoint(x: view.frame.width * 0.44, y: view.frame.height * 0.73)
        sub.center = CGPoint(x: view.frame.width * 0.56, y: view.frame.height * 0.73)
        mul.center = CGPoint(x: view.frame.width * 0.44, y: view.frame.height * 0.81)
        div.center = CGPoint(x: view.frame.width * 0.56, y: view.frame.height * 0.81)
    }
    
    // Calculates the player's current answer
    private func calcEquation(ind: Int, val: Int, gap: Bool) -> Int {
        if (ind == 0) {
            if let x = Int(slotOrder[0].currentTitle!) {
                return calcEquation(ind: 1, val: x, gap: false)
            }
        } else if (ind >= slotOrder.count) {
            return val
        } else if (gap && slotOrder[ind].currentTitle != "") {
            return -1
        } else if (slotOrder[ind].currentTitle == "" || gap) {
            return calcEquation(ind: ind + 1, val: val, gap: true)
        } else if (slotOrder[ind].currentTitle == "+" && (ind + 1) < slotOrder.count) {
            if let x = Int(slotOrder[ind + 1].currentTitle!) {
                return calcEquation(ind: ind + 2, val: val + x, gap: false)
            }
        } else if (slotOrder[ind].currentTitle == "-" && (ind + 1) < slotOrder.count) {
            if let x = Int(slotOrder[ind + 1].currentTitle!) {
                return calcEquation(ind: ind + 2, val: val - x, gap: false)
            }
        } else if (slotOrder[ind].currentTitle == "x" && (ind + 1) < slotOrder.count) {
            if let x = Int(slotOrder[ind + 1].currentTitle!) {
                return calcEquation(ind: ind + 2, val: val * x, gap: false)
            }
        } else if (slotOrder[ind].currentTitle == "/" && (ind + 1) < slotOrder.count) {
            if let x = Int(slotOrder[ind + 1].currentTitle!) {
                if ((val % x) == 0) {
                    return calcEquation(ind: ind + 2, val: val / x, gap: false)
                }
            }
        }
        return -1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
