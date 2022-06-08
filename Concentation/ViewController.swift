//
//  ViewController.swift
//  Concentation
//
//  Created by Aleksandr on 05.04.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private var buttonCollection: [UIButton]!
    @IBOutlet private weak var touchesLable: UILabel!
    
    private var emojiCollection = ["🐰", "🐵", "🐻", "🦊", "🐭", "🐸"]
    private var emojiDictionary = [Int: String]()
    private lazy var game = ConcentrationGame(numberOfCardPairs: (buttonCollection.count + 1) / 2)
    private(set) var touches = 0 {
        didSet {
            touchesLable.text = "Touches: \(touches)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for button in buttonCollection {
            button.backgroundColor = .blue
            button.setTitle("", for: .normal)
        }
    }

    @IBAction private func buttonAction(_ sender: UIButton) {
        if let buttonIndex = buttonCollection.firstIndex(of: sender) {
            if !game.cards[buttonIndex].isFaceUp {
                touches += 1
            }
            game.chooseCard(at: buttonIndex)
        }
        updateViewFromModel()
    }
    
    private func emojiIdentifier(for card: Card) -> String {
        if emojiDictionary[card.identifier] == nil {
            emojiDictionary[card.identifier] = emojiCollection.remove(at: emojiCollection.count.arc4random_uniformExtension)
        }
        return emojiDictionary[card.identifier] ?? ""
    }
    
    private func updateViewFromModel() {
        for index in buttonCollection.indices {
            let button = buttonCollection[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emojiIdentifier(for: card), for: .normal)
                button.backgroundColor = .white
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? .clear : .blue
            }
        }
    }
}

extension Int {
    var arc4random_uniformExtension: Int {
        return Int(Darwin.arc4random_uniform(UInt32(self)))
    }
}
