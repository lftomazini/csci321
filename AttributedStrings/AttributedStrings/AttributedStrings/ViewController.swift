//
//  ViewController.swift
//  AttributedStrings
//
//  Created by Luís Felipe on 2/12/16.
//  Copyright © 2016 Luís Felipe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var sentenceLabel: UILabel!
    @IBOutlet weak var selectedWordStepper: UIStepper!
    @IBOutlet weak var selectedWordLabel: UILabel!
    var wordArray: [String]?

    override func viewDidLoad() {
        super.viewDidLoad()
        createWordArray()
        selectedWordStepper.maximumValue = Double(wordArray!.count - 1)
        updateSelectedWord()
    }
    
    ///
    /// Responds to a tap on the Underline button by underlining the selected
    /// word.
    ///
    @IBAction func underline() {
        let attributes = [NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue]
        addAttributesToSelectedWord(attributes)
    }
    
    ///
    /// Responds to a tap on the NoUnderline button by removing the underlining 
    /// from the selected word.
    ///
    @IBAction func noUnderline() {
        addAttributesToSelectedWord([NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleNone.rawValue])
    }
    
    ///
    /// Responds to a tap on the Outline button by outlining the selected
    /// word.
    ///
    @IBAction func outline() {
        let attributes = [NSStrokeWidthAttributeName: NSNumber (double: 3.0)]
        addAttributesToSelectedWord(attributes)
    }
    
    ///
    /// Responds to a tap on the NoOutline button by removing the outlining
    /// from the selected word.
    ///
    @IBAction func noOutline() {
        addAttributesToSelectedWord([NSStrokeWidthAttributeName: NSNumber (double: 0.0)])
    }
    
    ///
    /// Responds to a tap on any of the color buttons. Changes the selected
    /// text to have the same color as the background of the button.
    ///
    @IBAction func changeColor(sender: UIButton) {
        addAttributesToSelectedWord([NSForegroundColorAttributeName: sender.backgroundColor!])
    }
    
    ///
    /// Creates an array of words that appear in sentenceLabel. There should
    /// always be words in the label, but to be safe, create an array with a
    /// single empty string if there are no words.
    ///
    func createWordArray() {
        let text = sentenceLabel.attributedText!.string
        let wordList = text.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        wordArray = wordList.count > 0 ? wordList : [""]
    }

    ///
    /// Returns the selected word chosen by the stepper. Note that the stepper
    /// value is a double. Convert it to an Int before using it is an array
    /// subscript.
    ///
    /// - returns: the selected word
    ///
    func selectedWord() -> String {
        return wordArray![Int(selectedWordStepper.value)]
    }
    
    ///
    /// Responds to a tap on the stepper by updating the selected word label.
    ///
    @IBAction func updateSelectedWord() {
        selectedWordLabel.text = selectedWord()
    }
    
    ///
    /// Determines the range of the currently selected word.
    ///
    /// - returns: a range that specifies the location of the current word
    ///
    func rangeOfSelectedWord() -> NSRange {
        let labelText = sentenceLabel.attributedText!.string as NSString
        return labelText.rangeOfString(selectedWord())
    }
    
    ///
    /// Adds attributes to the selected word.
    ///
    /// - parameter attributes: a dictionary of attributes to add.
    ///
    func addAttributesToSelectedWord(attributes: [String: AnyObject]) {
        let range = rangeOfSelectedWord()
        addAttributes(attributes, toRange: range)
    }
    
    ///
    /// Adds attributes to a range of characters in the sentence
    ///
    /// - parameter attributes: the attributes to be added
    ///
    /// - parameter toRange: the range of characters that will get the new attributes
    ///
    func addAttributes(attributes: [String: AnyObject], toRange range: NSRange) {
        if range.location != NSNotFound {
            let mutableString = NSMutableAttributedString(attributedString: sentenceLabel.attributedText!)
            mutableString.addAttributes(attributes, range: range)
            sentenceLabel.attributedText = mutableString
        }
    }
    
    ///
    /// Responds to a tap on one of the font buttons by changing the font of
    /// the selected word to be the same as the font of the button.
    ///
    /// - parameter sender: is the button that was passed
    ///
    @IBAction func changeFont(sender: UIButton) {
        let range = rangeOfSelectedWord()
        if range.location == NSNotFound {
            return
        }
        let attributes = sentenceLabel.attributedText!.attributesAtIndex(range.location, effectiveRange: nil)
        let existingFont = attributes[NSFontAttributeName] as! UIFont
        let fontSize = existingFont.pointSize
        let font = sender.titleLabel!.font.fontWithSize(fontSize)
        addAttributesToSelectedWord([NSFontAttributeName: font])
    }
    
    ///
    /// Disposes of any resources that can be recreated
    ///
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

