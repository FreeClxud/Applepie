//
//  ViewController.swift
//  ApplePie
//
//  Created by Manuel Romero on 12/8/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var TreeImageview: UIImageView!
    @IBOutlet weak var CorrectWordLabel: UILabel!
    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet var LetterButton: [UIButton]!
    
    var currentGame: Game!
    
    
    var listOfWords = ["buccaneer", "swift", "glorious", "incandescent", "bug", "program"]
    let incorrectMovesAllowed = 7
    
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        newRound()
    }
    
    func newRound() {
        if !listOfWords.isEmpty {
               let newWord = listOfWords.removeFirst()
               currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
               enableLetterButtons(true)
               updateUI()
           } else {
               enableLetterButtons(false)
           }
       }
    func enableLetterButtons(_ enable: Bool) {
      for button in LetterButton {
        button.isEnabled = enable
      }
    }

    
    func updateUI() {
        var letters = [String]()
           for letter in currentGame.formattedWord {
               letters.append(String(letter))
           }
           let wordWithSpacing = letters.joined(separator: " ")
           CorrectWordLabel.text = wordWithSpacing
           ScoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
           TreeImageview.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
       }
    
    func updateGameState() {
      if currentGame.incorrectMovesRemaining == 0 {
        totalLosses += 1
      } else if currentGame.word == currentGame.formattedWord {
        totalWins += 1
      } else {
        updateUI()
      }
    }
    
    
    @IBAction func ButttonPressed(_ sender: UIButton) {sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }

    func UpdateGameState() {

    }
}
