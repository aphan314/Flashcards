//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Alice Phan on 10/27/18.
//  Copyright © 2018 Alice Phan. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {
    
    var flashcardsController: ViewController!
    
    @IBOutlet weak var questionTextField: UITextField!
    
    @IBOutlet weak var answerTextField: UITextField!
    
    @IBOutlet weak var choiceOne: UITextField!
    
    @IBOutlet weak var choiceTwo: UITextField!
    
    var initialQuestion: String?
    var initialAnswer: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        let questionText = questionTextField.text
        let answerText = answerTextField.text
        let choice1 = choiceOne.text
        let choice2 = choiceTwo.text
        
        if questionText == nil || answerText == nil || questionText!.isEmpty || answerText!.isEmpty{
            let alert = UIAlertController(title: "Missing Text", message: "You need to enter both a question and an answer", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
            present(alert, animated: true)
        }
        else{
            flashcardsController.updateFlashcard(question: questionText!, answer: answerText!, choiceOne: choice1!, choiceTwo: choice2!)
        }
        
        dismiss(animated: true)
    }
    
}
