//
//  GameScore.swift
//  TicTacToe
//
//  Created by Bruce Reece on 10/27/21.
//

import UIKit

class GameScore: UIViewController {
    
    @IBOutlet weak var compWin: UILabel!
    @IBOutlet weak var humWin: UILabel!
    @IBOutlet weak var tie: UILabel!
    
    // Boolean variable
    var reset = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.compWin.text = "\(GlobalVars.sharedManager.computerWin)"
        self.humWin.text = "\(GlobalVars.sharedManager.humanWin)"
        self.tie.text = "\(GlobalVars.sharedManager.tie)"
    }
    
    // Reset the scores to 0 if user resets
    @IBAction func resetSc(_ sender: Any) {
        reset = true
        self.compWin.text = "0"
        self.humWin.text = "0"
        self.tie.text = "0"
        print("User hit reset")
    }
    
    // Will update when user switch back to GameScore
    override func viewDidAppear(_ animated: Bool) {
        self.compWin.text = "\(GlobalVars.sharedManager.computerWin)"
        self.humWin.text = "\(GlobalVars.sharedManager.humanWin)"
        self.tie.text = "\(GlobalVars.sharedManager.tie)"
    }
    
    // Overwrite global variable if user reset score
    override func viewDidDisappear(_ animated: Bool) {
        if reset == true{
            GlobalVars.sharedManager.computerWin = 0
            GlobalVars.sharedManager.humanWin = 0
            GlobalVars.sharedManager.tie = 0
            reset = false
        }
    }
}
