//  Name: Bruce Reece
//  Topic: Tic Tac Toe
//  Date: 10/06/2021
//  ViewController.swift
//  TicTacToe
//
//  Created by Bruce Reece on 9/22/21.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    // Get images references
    @IBOutlet weak var s1: UIImageView!
    @IBOutlet weak var s2: UIImageView!
    @IBOutlet weak var s3: UIImageView!
    @IBOutlet weak var s4: UIImageView!
    @IBOutlet weak var s5: UIImageView!
    @IBOutlet weak var s6: UIImageView!
    @IBOutlet weak var s7: UIImageView!
    @IBOutlet weak var s8: UIImageView!
    @IBOutlet weak var s9: UIImageView!
    
    // Get label references
    @IBOutlet weak var whoseTurn: UILabel!
    
    // varibles
    let humanPlayer = "X"
    let computerPlay = "O"
    var board: [String] = ["0","1","2","3","4","5","6","7","8"]
    var turn = "X"
    var win = 0
    var hwin = 0 // human win counter
    var cwin = 0 // computer win counter
    var ntie = 0 // tie counter
    var mBoardArray: [UIImageView] = []
    var xSound: AVAudioPlayer?
    var oSound: AVAudioPlayer?
    var gameDifficulty: Int!
    
    // Path for xSound and oSound
    let xPath = Bundle.main.path(forResource: "sword.mp3", ofType: nil)!
    let oPath = Bundle.main.path(forResource: "swish.mp3", ofType: nil)!
   
    
    // Action new game will reset the game
    @IBAction func newGame(_ sender:Any) {
        s1.image = nil
        s2.image = nil
        s3.image = nil
        s4.image = nil
        s5.image = nil
        s6.image = nil
        s7.image = nil
        s8.image = nil
        s9.image = nil
        print("TTT Activity: Starting New Game")
        turn = humanPlayer
        board = ["0","1","2","3","4","5","6","7","8"]
        self.whoseTurn.text = "You go first!"
        win = 0
    }
    
    //==========================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action:
                                                    #selector(ViewController.img1Clicked))
        let tapGesture2 = UITapGestureRecognizer(target: self, action:
                                                    #selector(ViewController.img2Clicked))
        let tapGesture3 = UITapGestureRecognizer(target: self, action:
                                                    #selector(ViewController.img3Clicked))
        let tapGesture4 = UITapGestureRecognizer(target: self, action:
                                                    #selector(ViewController.img4Clicked))
        let tapGesture5 = UITapGestureRecognizer(target: self, action:
                                                    #selector(ViewController.img5Clicked))
        let tapGesture6 = UITapGestureRecognizer(target: self, action:
                                                    #selector(ViewController.img6Clicked))
        let tapGesture7 = UITapGestureRecognizer(target: self, action:
                                                    #selector(ViewController.img7Clicked))
        let tapGesture8 = UITapGestureRecognizer(target: self, action:
                                                    #selector(ViewController.img8Clicked))
        let tapGesture9 = UITapGestureRecognizer(target: self, action:
                                                    #selector(ViewController.img9Clicked))
        tapGesture1.numberOfTapsRequired = 1
        tapGesture2.numberOfTapsRequired = 1
        tapGesture3.numberOfTapsRequired = 1
        tapGesture4.numberOfTapsRequired = 1
        tapGesture5.numberOfTapsRequired = 1
        tapGesture6.numberOfTapsRequired = 1
        tapGesture7.numberOfTapsRequired = 1
        tapGesture8.numberOfTapsRequired = 1
        tapGesture9.numberOfTapsRequired = 1
        
        s1.addGestureRecognizer(tapGesture1)
        s2.addGestureRecognizer(tapGesture2)
        s3.addGestureRecognizer(tapGesture3)
        s4.addGestureRecognizer(tapGesture4)
        s5.addGestureRecognizer(tapGesture5)
        s6.addGestureRecognizer(tapGesture6)
        s7.addGestureRecognizer(tapGesture7)
        s8.addGestureRecognizer(tapGesture8)
        s9.addGestureRecognizer(tapGesture9)
        
        mBoardArray.append(s1)
        mBoardArray.append(s2)
        mBoardArray.append(s3)
        mBoardArray.append(s4)
        mBoardArray.append(s5)
        mBoardArray.append(s6)
        mBoardArray.append(s7)
        mBoardArray.append(s8)
        mBoardArray.append(s9)
        
        // Initialize the global variable
        GlobalVars.sharedManager.humanWin = hwin
        GlobalVars.sharedManager.computerWin = cwin
        GlobalVars.sharedManager.tie = ntie
        
        // Game Difficulty
        gameDifficulty = 1
    }
    // Update the global variable after user leave this control view
    override func viewDidDisappear(_ animated: Bool) {
        GlobalVars.sharedManager.humanWin = hwin
        GlobalVars.sharedManager.computerWin = cwin
        GlobalVars.sharedManager.tie = ntie
        print("Computer Score updated to \(GlobalVars.sharedManager.computerWin)")
        print("Human Score updated to \(GlobalVars.sharedManager.humanWin)")
        print("Tie Score updated to \(GlobalVars.sharedManager.tie)")
    }
    
    // Will update counter when user reset score GameScore
    override func viewDidAppear(_ animated: Bool) {
        cwin = GlobalVars.sharedManager.computerWin
        hwin = GlobalVars.sharedManager.humanWin
        ntie = GlobalVars.sharedManager.tie
        print("Computer Score reset to \(cwin)")
        print("Human Score reset to \(hwin)")
        print("Tie Score reset to \(ntie)")
    }

    //============================================================================
    // img1 to img9
    @objc func img1Clicked(){
         // This code is for testing the GUI, will change in real game code
        if(win == 0 && s1.image == nil){
            // check to see it is X's turn
            if(turn == humanPlayer){
                s1.image = #imageLiteral(resourceName: "x_img.png")
                playX()
                board[0] = humanPlayer
                turn = computerPlay
                whoseTurn.text = "Computer’s Turn"
                print("TTT_ACTIVITY: ")
                displayBoard()
                win = checkForWinner()
                showStatus()
                
                // check to see if game is over after X's move
                if(win == 0){
                    let when = DispatchTime.now() + .seconds(2) // Delay time
                    DispatchQueue.main.asyncAfter(deadline: when){
                        self.getComputerMove()
                        self.turn = self.humanPlayer
                    self.whoseTurn.text = "Human’s Turn"
                    print("TTT_ACTIVITY: ")
                        self.displayBoard()
                        self.win = self.checkForWinner()
                        self.showStatus()
                    }
                }
                
            }
        }
        
    }

    @objc func img2Clicked(){
         // This code is for testing the GUI, will change in real game code
        if(win == 0 && s2.image == nil){
            // check to see it is X's turn
            if(turn == humanPlayer){
                s2.image = #imageLiteral(resourceName: "x_img.png")
                playX()
                board[1] = humanPlayer
                turn = computerPlay
                whoseTurn.text = "Computer’s Turn"
                print("TTT_ACTIVITY: ")
                displayBoard()
                win = checkForWinner()
                showStatus()
                
                // check to see if game is over after X's move
                if(win == 0){
                    let when = DispatchTime.now() + .seconds(2) // Delay time
                    DispatchQueue.main.asyncAfter(deadline: when){
                        self.getComputerMove()
                        self.turn = self.humanPlayer
                    self.whoseTurn.text = "Human’s Turn"
                    print("TTT_ACTIVITY: ")
                        self.displayBoard()
                        self.win = self.checkForWinner()
                        self.showStatus()
                    }
                }
                
            }
        }
        
    }
    
    @objc func img3Clicked(){
         // This code is for testing the GUI, will change in real game code
        if(win == 0 && s3.image == nil){
            // check to see it is X's turn
            if(turn == humanPlayer){
                s3.image = #imageLiteral(resourceName: "x_img.png")
                playX()
                board[2] = humanPlayer
                turn = computerPlay
                whoseTurn.text = "Computer’s Turn"
                print("TTT_ACTIVITY: ")
                displayBoard()
                win = checkForWinner()
                showStatus()
                
                // check to see if game is over after X's move
                if(win == 0){
                    let when = DispatchTime.now() + .seconds(2) // Delay time
                    DispatchQueue.main.asyncAfter(deadline: when){
                        self.getComputerMove()
                        self.turn = self.humanPlayer
                    self.whoseTurn.text = "Human’s Turn"
                    print("TTT_ACTIVITY: ")
                        self.displayBoard()
                        self.win = self.checkForWinner()
                        self.showStatus()
                    }
                }
                
            }
        }
        
    }
    
    @objc func img4Clicked(){
         // This code is for testing the GUI, will change in real game code
        if(win == 0 && s4.image == nil){
            // check to see it is X's turn
            if(turn == humanPlayer){
                s4.image = #imageLiteral(resourceName: "x_img.png")
                playX()
                board[3] = humanPlayer
                turn = computerPlay
                whoseTurn.text = "Computer’s Turn"
                print("TTT_ACTIVITY: ")
                displayBoard()
                win = checkForWinner()
                showStatus()
                
                // check to see if game is over after X's move
                if(win == 0){
                    let when = DispatchTime.now() + .seconds(2) // Delay time
                    DispatchQueue.main.asyncAfter(deadline: when){
                        self.getComputerMove()
                        self.turn = self.humanPlayer
                    self.whoseTurn.text = "Human’s Turn"
                    print("TTT_ACTIVITY: ")
                        self.displayBoard()
                        self.win = self.checkForWinner()
                        self.showStatus()
                    }
                }
                
            }
        }
        
    }
    
    @objc func img5Clicked(){
         // This code is for testing the GUI, will change in real game code
        if(win == 0 && s5.image == nil){
            // check to see it is X's turn
            if(turn == humanPlayer){
                s5.image = #imageLiteral(resourceName: "x_img.png")
                playX()
                board[4] = humanPlayer
                turn = computerPlay
                whoseTurn.text = "Computer’s Turn"
                print("TTT_ACTIVITY: ")
                displayBoard()
                win = checkForWinner()
                showStatus()
                
                // check to see if game is over after X's move
                if(win == 0){
                    let when = DispatchTime.now() + .seconds(2) // Delay time
                    DispatchQueue.main.asyncAfter(deadline: when){
                        self.getComputerMove()
                        self.turn = self.humanPlayer
                    self.whoseTurn.text = "Human’s Turn"
                    print("TTT_ACTIVITY: ")
                        self.displayBoard()
                        self.win = self.checkForWinner()
                        self.showStatus()
                    }
                }
                
            }
        }
        
    }
    
    @objc func img6Clicked(){
         // This code is for testing the GUI, will change in real game code
        if(win == 0 && s6.image == nil){
            // check to see it is X's turn
            if(turn == humanPlayer){
                s6.image = #imageLiteral(resourceName: "x_img.png")
                playX()
                board[5] = humanPlayer
                turn = computerPlay
                whoseTurn.text = "Computer’s Turn"
                print("TTT_ACTIVITY: ")
                displayBoard()
                win = checkForWinner()
                showStatus()
                
                // check to see if game is over after X's move
                if(win == 0){
                    let when = DispatchTime.now() + .seconds(2) // Delay time
                    DispatchQueue.main.asyncAfter(deadline: when){
                        self.getComputerMove()
                        self.turn = self.humanPlayer
                    self.whoseTurn.text = "Human’s Turn"
                    print("TTT_ACTIVITY: ")
                        self.displayBoard()
                        self.win = self.checkForWinner()
                        self.showStatus()
                    }
                }
                
            }
        }
    }
    
    @objc func img7Clicked(){
         // This code is for testing the GUI, will change in real game code
        if(win == 0 && s7.image == nil){
            // check to see it is X's turn
            if(turn == humanPlayer){
                s7.image = #imageLiteral(resourceName: "x_img.png")
                playX()
                board[6] = humanPlayer
                turn = computerPlay
                whoseTurn.text = "Computer’s Turn"
                print("TTT_ACTIVITY: ")
                displayBoard()
                win = checkForWinner()
                showStatus()
                
                // check to see if game is over after X's move
                if(win == 0){
                    let when = DispatchTime.now() + .seconds(2) // Delay time
                    DispatchQueue.main.asyncAfter(deadline: when){
                        self.getComputerMove()
                        self.turn = self.humanPlayer
                    self.whoseTurn.text = "Human’s Turn"
                    print("TTT_ACTIVITY: ")
                        self.displayBoard()
                        self.win = self.checkForWinner()
                        self.showStatus()
                    }
                }
                
            }
        }
    }
    
    @objc func img8Clicked(){
         // This code is for testing the GUI, will change in real game code
        if(win == 0 && s8.image == nil){
            // check to see it is X's turn
            if(turn == humanPlayer){
                s8.image = #imageLiteral(resourceName: "x_img.png")
                playX()
                board[7] = humanPlayer
                turn = computerPlay
                whoseTurn.text = "Computer’s Turn"
                print("TTT_ACTIVITY: ")
                displayBoard()
                win = checkForWinner()
                showStatus()
                
                // check to see if game is over after X's move
                if(win == 0){
                    let when = DispatchTime.now() + .seconds(2) // Delay time
                    DispatchQueue.main.asyncAfter(deadline: when){
                        self.getComputerMove()
                        self.turn = self.humanPlayer
                    self.whoseTurn.text = "Human’s Turn"
                    print("TTT_ACTIVITY: ")
                        self.displayBoard()
                        self.win = self.checkForWinner()
                        self.showStatus()
                    }
                }
                
            }
        }
    }
    
    @objc func img9Clicked(){
         // This code is for testing the GUI, will change in real game code
        if(win == 0 && s9.image == nil){
            // check to see it is X's turn
            if(turn == humanPlayer){
                s9.image = #imageLiteral(resourceName: "x_img.png")
                playX()
                board[8] = humanPlayer
                turn = computerPlay
                whoseTurn.text = "Computer’s Turn"
                print("TTT_ACTIVITY: ")
                displayBoard()
                win = checkForWinner()
                showStatus()
                
                // check to see if game is over after X's move
                if(win == 0){
                    let when = DispatchTime.now() + .seconds(2) // Delay time
                    DispatchQueue.main.asyncAfter(deadline: when){
                        self.getComputerMove()
                        self.turn = self.humanPlayer
                    self.whoseTurn.text = "Human’s Turn"
                    print("TTT_ACTIVITY: ")
                        self.displayBoard()
                        self.win = self.checkForWinner()
                        self.showStatus()
                    }
                }
                
            }
        }
    }
    //-------------------------
    //Game level
    //-------------------------
    @IBAction func gameSettings(_ sender: Any) {
        let easy = "Easy"
        let medium = "Medium"
        let hard = "Hard"
        
        let ac = UIAlertController(title: "Game Settings", message: "Select the Difficulty Level", preferredStyle: .actionSheet)
        let easyAction = UIAlertAction(title: easy, style: .default, handler: { action in
        self.setDifficulty(difficulty: 1) })
        
        ac.addAction(easyAction)
        
        let mediumAction = UIAlertAction(title: medium, style: .default, handler: { action in
        self.setDifficulty(difficulty: 2) })
        
        ac.addAction(mediumAction)
        
        let hardAction = UIAlertAction(title: hard, style: .default, handler: { action in
        self.setDifficulty(difficulty: 3) })
        
        ac.addAction(hardAction)
        
        present(ac, animated: true, completion: nil)
    }
    
    
    //===========================================================================
    // This method will logically determine which player wins
    func  checkForWinner() -> Int {
            
            // Check horizontal wins
        for i in 0...6 where i%3 == 0  {
                if (board[i] == humanPlayer &&
                    board[i+1] == humanPlayer &&
                    board[i+2] == humanPlayer)
                {
                    return 2;
                }
                if (board[i] == computerPlay &&
                    board[i+1] == computerPlay &&
                    board[i+2] == computerPlay)
                {
                    return 3;
                    
                }
            }
            // Check vertical wins
        for i in 0...2 {
            
                if (board[i] == humanPlayer &&
                    board[i+3] == humanPlayer &&
                    board[i+6] == humanPlayer)
                {
                    return 2;
                }
                if (board[i] == computerPlay &&
                    board[i+3] == computerPlay &&
                    board[i+6] == computerPlay)
                {
                    return 3;
                }
            }
            // Check for diagonal wins
            if ((board[0] == humanPlayer &&
                 board[4] == humanPlayer &&
                 board[8] == humanPlayer) ||
                (board[2] == humanPlayer &&
                 board[4] == humanPlayer &&
                 board[6] == humanPlayer))
            {
                return 2;
            }
            if ((board[0] == computerPlay &&
                 board[4] == computerPlay &&
                 board[8] == computerPlay) ||
                (board[2] == computerPlay &&
                 board[4] == computerPlay &&
                 board[6] == computerPlay))
            {
                return 3
                
            }
            // Check for tie
            for i in board {
                // If we find a number, then no one has won yet
                if (i != humanPlayer && i != computerPlay)
                {
                    return 0
                }
            }
            // If we make it through the previous loop, all places are taken, so it's a tie
            return 1;
        }
    //=====================================================================================
    // This method will show us how the game being used at the back end
    // for debugging
    func displayBoard()
        {
        print()
        print(board[0] + " | " + board[1] + " | " + board[2])
        print("-----------");
        print(board[3] + " | " + board[4] + " | " + board[5]);
        print("-----------");
        print(board[6] + " | " + board[7] + " | " + board[8])
        print();
    }
    
    // This function will logical pick a move based on how the human play make
    // his or her moves.
    func getComputerMove(){
       if(gameDifficulty == 1)
       {
        easyPlay()
       }
       else if(gameDifficulty == 2){
        mediumPlay()
       }
       else if (gameDifficulty == 3){
        hardPlay()
       }
       else{
        print("There is an error with getComputerMove()")
       }
    }
    
    //===========================================================
    // Print to console which play wins to show debugging
    func showStatus(){
        
        if(win == 1){
            print("It's a tie")
            self.whoseTurn.text = "It's a tie!"
            ntie = ntie + 1
        }
        else if( win == 2){
            print(humanPlayer + " wins!")
            self.whoseTurn.text = "You won!"
            hwin = hwin + 1
        }
        else if(win == 3){
            print(computerPlay + " wins!")
            self.whoseTurn.text = "I won!"
            cwin = cwin + 1
        }
        else{
            print("There is a problem! or no one didn't win")
        }
    }
    
    // X sound function
    func playX(){
        let xUrl = URL(fileURLWithPath: xPath)
        do {
            xSound = try AVAudioPlayer(contentsOf:xUrl)
            xSound?.play()
        } catch {
            // couldn't load file :(
        }
    }
    
    // O sound function
    func playO(){
        let oUrl = URL(fileURLWithPath: oPath)
        do {
            oSound = try AVAudioPlayer(contentsOf:oUrl)
            oSound?.play()
        } catch {
            // couldn't load file :(
        }
    }
    
    // Game Difficulty Handler
    func setDifficulty(difficulty: Int){
        var level: String; gameDifficulty = difficulty; switch difficulty{
    case 1:
    level = "Easy"
    case 2:
    level = "Medium"
    case 3:
    level = "Expert"
    default:
    level = "Easy"
    }
    print("TTT_ACTIVITY: Game Difficulty Level Now Set To: " + level) }
    
    func easyPlay(){
        var move: Int
        // Generate random move
           repeat
           {
               move = Int.random(in: 0...8);
           } while (board[move] == humanPlayer || board[move] == computerPlay)
           board[move] = computerPlay
           mBoardArray[move].image = #imageLiteral(resourceName: "o_img.png")
           playO()
           print("Computer is moving to \(move + 1)")
           print("TTT Activity: Random Move")
    }
    
    func mediumPlay(){
        var move: Int
        // First see if there's a move O can make to win
        for i in 0...8{
            if (board[i] != humanPlayer && board[i] != computerPlay) {
                let curr = board[i]
                board[i]  = computerPlay
                    
                if (checkForWinner() == 3) {
                    mBoardArray[i].image = #imageLiteral(resourceName: "o_img.png")
                    playO()
                    print("Computer is moving to \(i + 1)")
                    print("TTT Activity: Winning Move")
                    return
                    }
                else{
                    board[i] = curr;
                }
            }
                
        }
        // Generate random move
           repeat
           {
               move = Int.random(in: 0...8);
           } while (board[move] == humanPlayer || board[move] == computerPlay)
           board[move] = computerPlay
           mBoardArray[move].image = #imageLiteral(resourceName: "o_img.png")
           playO()
           print("Computer is moving to \(move + 1)")
           print("TTT Activity: Random Move")
    }
    
    func hardPlay(){
        var move: Int
        // First see if there's a move O can make to win
        for i in 0...8{
            if (board[i] != humanPlayer && board[i] != computerPlay) {
                let curr = board[i]
                board[i]  = computerPlay
                    
                if (checkForWinner() == 3) {
                    mBoardArray[i].image = #imageLiteral(resourceName: "o_img.png")
                    playO()
                    print("Computer is moving to \(i + 1)")
                    print("TTT Activity: Winning Move")
                    return
                    }
                else{
                    board[i] = curr;
                }
            }
                
        }

        // See if there's a move O can make to block X from winning
        for i in 0...8 {
            if (board[i] != humanPlayer && board[i]  != computerPlay) {
                let curr = board[i]    // Save the current number
                board[i]  = humanPlayer
                if (checkForWinner() == 2) {
                    board[i]  = computerPlay
                    mBoardArray[i].image = #imageLiteral(resourceName: "o_img.png")
                    playO()
                    print("Computer is moving to \(i + 1)");
                    print("TTT Activity: Blocking Move")
                    return
                }
                else{
                    board[i] = curr;
            }
        }
    }
        // Generate random move
           repeat
           {
               move = Int.random(in: 0...8);
           } while (board[move] == humanPlayer || board[move] == computerPlay)
           board[move] = computerPlay
           mBoardArray[move].image = #imageLiteral(resourceName: "o_img.png")
           playO()
           print("Computer is moving to \(move + 1)")
           print("TTT Activity: Random Move")
    }
}

    
