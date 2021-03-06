//
//  ViewController.swift
//  Silly Song
//
//  Created by Erica on 7/22/17.
//  Copyright © 2017 Erica Gutierrez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField.delegate = self
        lyricsView.text = String()
        
        
    }

  
    func shortNameFromName(name: String) -> String {
        
        
        let lowercaseName = name.lowercased()
        let vowelSet = CharacterSet(charactersIn: "aeiou")
        
        if let firstVowelRange = lowercaseName.rangeOfCharacter(from: vowelSet, options: .caseInsensitive) {
            return lowercaseName.substring(from: firstVowelRange.lowerBound)
        }
        
        // No vowels - return the fullname
        return lowercaseName
    }
    
    func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
        
     
        
        
       let shortName = shortNameFromName(name: fullName)
        
        let lyrics = lyricsTemplate
            .replacingOccurrences(of: "<FULL_NAME>", with: fullName)
            .replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
        
        
        self.lyricsView.text = lyrics
        
      
        return lyrics
    }
   
    
    
    @IBAction func reset(_ sender: Any) {
        self.nameField.text = String()
        self.lyricsView.text = String()
    }

    @IBAction func displayLyrics(_ sender: Any) {
        
        
        guard let fullName = nameField.text, fullName.characters.count > 0 else {
            lyricsView.text = ""
            let alertController = UIAlertController(title: "No Text", message: "Please Enter Valid Text In The Box", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
            {
                (result : UIAlertAction) -> Void in
                print("You pressed OK")
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)

            return
        }
      
        let sillyLyrics = "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME> \n" + "Banana Fana Fo F<SHORT_NAME> \n" + "Me My Mo M<SHORT_NAME> \n" + "<FULL_NAME>"
      
        
       print(lyricsForName(lyricsTemplate: sillyLyrics, fullName: (nameField.text)!))
        
     
        

    }
    
   

}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

    let characterSet = CharacterSet.letters
    
    if string.rangeOfCharacter(from: characterSet.inverted) != nil {
    return false
    }
    return true
}
}

