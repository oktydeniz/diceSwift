//
//  ViewController.swift
//  dice
//
//  Created by oktay on 3.07.2022.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var player2Score: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    
    @IBOutlet weak var dice2: UIImageView!
    @IBOutlet weak var dice1: UIImageView!
    @IBOutlet weak var player2Status: UIImageView!
    @IBOutlet weak var player1Status: UIImageView!
    
    @IBOutlet weak var player2All: UILabel!
    @IBOutlet weak var player1All: UILabel!
    @IBOutlet weak var player1Score: UILabel!
    
    var playerScores = (player1:0, player2:0)
    var playerAllScores = (player1:0, player2:0)
    
    var rowOfPlayers:Int = 1;
    
    var maxSet :Int = 5;
    var currentSet = 1;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let bgImage = UIImage(named: "bg"){
            self.view.backgroundColor = UIColor(patternImage: bgImage)
        }
        resultLabel.text = nil
        
    }
    
    //shake
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if (currentSet > maxSet){
            return
        }
        randomDiceValues()
    }
    
    func randomDiceValues(){
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3 , execute: {
            
            let dice1_r = arc4random_uniform(6) + 1
            let dice2_r = arc4random_uniform(6) + 1
            
            self.dice1.image = UIImage(named: String(dice1_r))
            self.dice2.image  = UIImage(named: String(dice2_r))
            self.setResult(dice1: Int(dice1_r), dice2: Int(dice2_r))
            
            if(self.currentSet > self.maxSet) {
                
                if(self.playerScores.player1 > self.playerScores.player2){
                    self.resultLabel.text = "Winner : Player 1 "

                }else {
                    self.resultLabel.text = "Winner : Player 2"

                }
            }
        })
        
        self.resultLabel.text = "Playing Dice ..."
        self.dice1.image = UIImage(named: "unknowndice")
        self.dice2.image = UIImage(named: "unknowndice")
        
    }
    
    func setResult(dice1:Int, dice2:Int){
        if(rowOfPlayers == 1){
            playerScores.player1 = dice1 + dice2
            player1All.text = String(playerScores.player1)
            player1Status.image = UIImage(named: "wait")
            player2Status.image = UIImage(named: "ok")
            resultLabel.text = "Game on : Player 2"
            rowOfPlayers = 2;
            player2All.text = "0"

        } else {
            playerScores.player2 = dice1 + dice2
            player2All.text  = String(playerScores.player2)
            player2Status.image = UIImage(named: "wait")
            player1Status.image = UIImage(named: "ok")
            resultLabel.text = "Game on : Player 1"
            rowOfPlayers = 1;
            isSetDone()
        }
    }
    
    func isSetDone(){
        
        if(playerScores.player1 > playerScores.player2){
            playerAllScores.player1 += 1
            resultLabel.text = "Winner Player 1 set : \(currentSet)"
            currentSet += 1
            player1Score.text = String(playerAllScores.player1)

        } else if (playerScores.player1 < playerScores.player2){
            playerAllScores.player2 += 1
            resultLabel.text = "Winner Player 2 set : \(currentSet)"
            currentSet += 1
            player2Score.text = String(playerAllScores.player2)
            
        }else {
            resultLabel.text = " We have no Winner for set : \(currentSet)"
        }
        
    }
}

