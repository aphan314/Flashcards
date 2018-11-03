//
//  ViewController.swift
//  Flashcards
//
//  Created by Alice Phan on 10/13/18.
//  Copyright © 2018 Alice Phan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        if(frontLabel.isHidden == true){
            frontLabel.isHidden = false;
        }
        else{
            frontLabel.isHidden = true;
        }
    }
    
    func updateFlashcard(question: String, answer: String, choiceOne: String?, choiceTwo: String?){
        frontLabel.text = question;
        backLabel.text = answer;
        
        btnOptionOne.setTitle(choiceOne, for: .normal)
        btnOptionTwo.setTitle(answer, for: .normal)
        btnOptionThree.setTitle(choiceTwo, for: .normal)
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
}

