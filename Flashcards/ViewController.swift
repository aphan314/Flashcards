//
//  ViewController.swift
//  Flashcards
//
//  Created by Alice Phan on 10/13/18.
//  Copyright © 2018 Alice Phan. All rights reserved.
//

import UIKit

struct Flashcard{
    var question: String
    var answer: String
}
class ViewController: UIViewController {

    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var flashcards = [Flashcard]()
    var currentIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        updateFlashcard(question: "What's the capital of Brazil?", answer: "Brasilia", choiceOne: "Rio de Janeiro", choiceTwo: "Sao Paulo")
        readSavedFlashcards()
        
        if flashcards.count == 0{
            updateFlashcard(question: "What's the capital of Brazil?", answer: "Brasilia", choiceOne: "Rio de Janeiro", choiceTwo: "Sao Paulo")
        } else{
            updateLabels()
            updateNextPrevButtons()
        }
        card.layer.cornerRadius = 20.0;
        frontLabel.layer.cornerRadius = 20.0;
        backLabel.layer.cornerRadius = 20.0;
        card.layer.shadowRadius = 15.0;
        card.layer.shadowOpacity = 0.2;
        frontLabel.clipsToBounds = true;
        backLabel.clipsToBounds = true;
        btnOptionOne.layer.cornerRadius = 20.0;
        btnOptionOne.layer.borderWidth = 3.0;
        btnOptionOne.layer.borderColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        btnOptionTwo.layer.cornerRadius = 20.0;
        btnOptionTwo.layer.borderWidth = 3.0;
        btnOptionTwo.layer.borderColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        btnOptionThree.layer.cornerRadius = 20.0;
        btnOptionThree.layer.borderWidth = 3.0;
        btnOptionThree.layer.borderColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as!UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        if segue.identifier == "EditSegue"{
            creationController.initialQuestion = frontLabel.text
            creationController.initialAnswer = backLabel.text
        }
        
    creationController.flashcardsController = self
    }
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        flipFlashcard()
    }
    
    func flipFlashcard(){
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: {self.frontLabel.isHidden = true})

    }
    
    func animateCardOut(){
        UIView.animate(withDuration: 0.3, animations: {self.card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)}, completion: {finished in
            
            self.updateLabels()
            
            self.animateCardIn()
        })
    }
    
    func animateCardIn(){
        card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        UIView.animate(withDuration: 0.3){
           self.card.transform = CGAffineTransform.identity
        }
    }
    func animateCardBef(){
        UIView.animate(withDuration: 0.3, animations: {self.card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)}, completion: {finished in
            
            self.updateLabels()
            
            self.animateCardAft()
        })
    }
    
    func animateCardAft(){
        card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
        UIView.animate(withDuration: 0.3){
            self.card.transform = CGAffineTransform.identity
        }
    }
    
    func updateFlashcard(question: String, answer: String, choiceOne: String?, choiceTwo: String?){
        let flashcard = Flashcard(question: question, answer: answer)
        flashcards.append(flashcard)
        print("Added new flashcard")
        print("We now have \(flashcards.count) flashcards")
        currentIndex = flashcards.count - 1
        print("Our current index is \(currentIndex)")
        updateNextPrevButtons()
        updateLabels()
        frontLabel.text = flashcard.question;
        backLabel.text = flashcard.answer;
        btnOptionOne.setTitle(choiceOne, for: .normal)
        btnOptionTwo.setTitle(answer, for: .normal)
        btnOptionThree.setTitle(choiceTwo, for: .normal)
        saveAllFlashcardsToDisk()
    }
    
    func updateNextPrevButtons(){
        if currentIndex == flashcards.count - 1{
            nextButton.isEnabled = false
        }else{
            nextButton.isEnabled = true
        }
    }
    
    func updateLabels(){
        let currentFlashcard = flashcards[currentIndex]
        
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
    }
    
    func saveAllFlashcardsToDisk(){
        let dictionaryArray = flashcards.map{(card) -> [String: String] in return ["question": card.question, "answer": card.answer]
            
        }
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        print("Flashcards saved to UserDefaults")
    }
    
    func readSavedFlashcards(){
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String:String]]{
            
            let savedCards = dictionaryArray.map{dictionary -> Flashcard in return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)}
            
            flashcards.append(contentsOf: savedCards)
        }
    }
    @IBAction func didTapOnOptionOne(_ sender: Any) {
        frontLabel.isHidden = false;
    }
    
    @IBAction func didTapOnOptionTwo(_ sender: Any) {
        frontLabel.isHidden = true;
    }
    
    @IBAction func didTapOnOptionThree(_ sender: Any) {
        frontLabel.isHidden = false;
    }
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex = currentIndex - 1
        updateLabels()
        updateNextPrevButtons()
        animateCardBef()
    }
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex = currentIndex + 1
        updateLabels()
        updateNextPrevButtons()
        animateCardOut()
    }
}

