//
//  KeyboardViewController.swift
//  BondKeyboard
//
//  Created by Siva Mouniker on 07/07/23.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    
    var capButton: KeyboardButton!
    var numericButton: KeyboardButton!
    var deleteButton: KeyboardButton!
    var nextKeyboardButton: KeyboardButton!
    var returnButton: KeyboardButton!
    var spacekey: KeyboardButton!
    var isCapitalsShowing = false
    
    
    
    var allTextButtons = [KeyboardButton]()
    
    var keyboardHeight: CGFloat = 225
    var KeyboardVCHeightConstraint: NSLayoutConstraint!
    var containerViewHeight: CGFloat = 0
        

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addKeyboardButtons()
        self.setNextKeyboardVisible(needsInputModeSwitchKey)
        self.KeyboardVCHeightConstraint = NSLayoutConstraint(item: self.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: keyboardHeight+containerViewHeight)
        self.view.addConstraint(self.KeyboardVCHeightConstraint)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.removeConstraint(KeyboardVCHeightConstraint)
        self.view.addConstraint(self.KeyboardVCHeightConstraint)
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        // Add custom view sizing constraints here
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        let colorScheme: KBColorScheme
        if textDocumentProxy.keyboardAppearance == .dark {
            colorScheme = .dark
        } else {
            colorScheme = .light
        }
        self.setColorScheme(colorScheme)
    }
    
    //Handles NextKeyBoard Button Appearance..
    
    func setNextKeyboardVisible(_ visible: Bool) {
        //nextKeyboardButton.isHidden = !visible
    }
    
    //Set color scheme For keyboard appearance...
    func setColorScheme(_ colorScheme: KBColorScheme) {
        
        let themeColor = KBColors(colorScheme: colorScheme)
    
        self.capButton.defaultBackgroundColor = themeColor.buttonBackgroundColor
        self.deleteButton.defaultBackgroundColor = themeColor.buttonBackgroundColor
        self.returnButton.defaultBackgroundColor = themeColor.buttonBackgroundColor
        self.spacekey.defaultBackgroundColor = themeColor.buttonBackgroundColor
        
        
        self.capButton.highlightBackgroundColor = themeColor.buttonBackgroundColor
        self.deleteButton.highlightBackgroundColor = themeColor.buttonBackgroundColor
        self.returnButton.highlightBackgroundColor = themeColor.buttonBackgroundColor
        self.spacekey.setTitleColor(themeColor.buttonTextColor, for: .normal)
        self.returnButton.setTitleColor(themeColor.buttonTextColor, for: .normal)
        
        for button in allTextButtons {
            button.tintColor = themeColor.buttonTintColor
            button.defaultBackgroundColor = themeColor.buttonBackgroundColor
            button.highlightBackgroundColor = themeColor.buttonHighlightColor
            button.setTitleColor(themeColor.buttonTextColor, for: .normal)
            
        }
    
    }
    
    var mainStackView: UIStackView!
    
    private func addKeyboardButtons() {
        //My Custom Keys...
        
        let firstRowView = addRowsOnKeyboard(kbKeys: ["q","w","e","r","t","y","u","i","o","p"])
        let secondRowView = addRowsOnKeyboard(kbKeys: ["a","s","d","f","g","h","j","k","l"])
        
        let thirdRowkeysView = addRowsOnKeyboard(kbKeys: ["z","x","c","v","b","n","m"])
        
        let (thirdRowSV,fourthRowSV) = serveiceKeys(midRow: thirdRowkeysView)
        
        // Add Row Views on Keyboard View... With a Single Stack View..
        
        self.mainStackView = UIStackView(arrangedSubviews: [firstRowView,secondRowView,thirdRowSV,fourthRowSV])
        mainStackView.axis = .vertical
        mainStackView.spacing = 3.0
        mainStackView.distribution = .fillEqually
        mainStackView.alignment = .fill
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainStackView)
        
        mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 2).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2).isActive = true
        mainStackView.heightAnchor.constraint(equalToConstant: keyboardHeight).isActive = true
        

    }
    
    func serveiceKeys(midRow: UIView)->(UIStackView, UIStackView) {
        self.capButton = accessoryButtons(title: nil, img: #imageLiteral(resourceName: "captial1"), tag: 1)
        self.deleteButton = accessoryButtons(title: nil, img: #imageLiteral(resourceName: "backspace"), tag: 2)
        
        let thirdRowSV = UIStackView(arrangedSubviews: [self.capButton,midRow,self.deleteButton])
        thirdRowSV.distribution = .fillProportionally
        thirdRowSV.spacing = 5
        
        self.spacekey = accessoryButtons(title: "space", img: nil, tag: 6)
        self.returnButton = accessoryButtons(title: "return", img: nil, tag: 7)
        
        let fourthRowSV = UIStackView(arrangedSubviews: [self.spacekey,self.returnButton])
        fourthRowSV.distribution = .fillEqually
        fourthRowSV.spacing = 5
        
        return (thirdRowSV,fourthRowSV)
    }
    
    
    // Adding Keys on UIView with UIStack View..
    func addRowsOnKeyboard(kbKeys: [String]) -> UIView {
        
        let RowStackView = UIStackView.init()
        RowStackView.spacing = 5
        RowStackView.axis = .horizontal
        RowStackView.alignment = .fill
        RowStackView.distribution = .fillEqually
        
        for key in kbKeys {
            RowStackView.addArrangedSubview(createButtonWithTitle(title: key))
        }
        
        let keysView = UIView()
        keysView.backgroundColor = .clear
        keysView.addSubview(RowStackView)
        keysView.addConstraintsWithFormatString(formate: "H:|[v0]|", views: RowStackView)
        keysView.addConstraintsWithFormatString(formate: "V:|[v0]|", views: RowStackView)
        return keysView
    }

    // Creates Buttons on Keyboard...
    func createButtonWithTitle(title: String) -> KeyboardButton {
        
        let button = KeyboardButton(type: .system)
        button.setTitle(title, for: .normal)
        button.sizeToFit()
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(didTapButton(sender:)), for: .touchUpInside)
        allTextButtons.append(button)
        
        return button
    }
    
    @objc func didTapButton(sender: UIButton) {
        
        let button = sender as UIButton
        guard let title = button.titleLabel?.text else { return }
        let proxy = self.textDocumentProxy
        
        UIView.animate(withDuration: 0.25, animations: {
            button.transform = CGAffineTransform(scaleX: 1.20, y: 1.20)
                    proxy.insertText(title)
            
        }) { (_) in
            UIView.animate(withDuration: 0.10, animations: {
                button.transform = CGAffineTransform.identity
            })
        }
        
    }
    
    // Accesory Buttons On Keyboard...
    
    func accessoryButtons(title: String?, img: UIImage?, tag: Int) -> KeyboardButton {
        
        let button = KeyboardButton.init(type: .system)
        
        if let buttonTitle = title {
            button.setTitle(buttonTitle, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        }
        
        if let buttonImage = img {
            button.setImage(buttonImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
       
        button.sizeToFit()
        button.tag = tag
        
        //For Capitals...
        if button.tag == 1 {
            button.addTarget(self, action: #selector(handleCapitalsAndLowerCase(sender:)), for: .touchUpInside)
            button.widthAnchor.constraint(equalToConstant: 45).isActive = true
            return button
        }
        //For BackDelete Key
        if button.tag == 2 {
            button.addTarget(self, action: #selector(manualAction(sender:)), for: .touchUpInside)
            button.widthAnchor.constraint(equalToConstant: 45).isActive = true
            return button
        }

        //White Space Button...
        if button.tag == 6 {

            button.addTarget(self, action: #selector(insertWhiteSpace), for: .touchUpInside)
            button.widthAnchor.constraint(equalToConstant: 100).isActive = true

            return button
        }
        //Handle return Button...//Usually depends on Texyfiled'd return Type...
        if button.tag == 7 {
            button.addTarget(self, action: #selector(handleReturnKey(sender:)), for: .touchUpInside)
            return button
        }
        //Else Case... For Others
        button.addTarget(self, action: #selector(manualAction(sender:)), for: .touchUpInside)
        return button
        
    }
    
    
    @objc func handleCapitalsAndLowerCase(sender: UIButton) {
        for button in allTextButtons {
            
            if let title = button.currentTitle {
                button.setTitle(isCapitalsShowing ? title.lowercased() : title.uppercased(), for: .normal)
            }
        }
        isCapitalsShowing = !isCapitalsShowing
    }
        
    @objc func insertWhiteSpace() {

        let proxy = self.textDocumentProxy
        proxy.insertText(" ")
        print("white space")
    }
    
    @objc func handleReturnKey(sender: UIButton) {
             self.textDocumentProxy.insertText("\n")
    }
 
    @objc func manualAction(sender: UIButton) {
        let proxy = self.textDocumentProxy
        
            proxy.deleteBackward()
        print("Else Case... Remaining Keys")
    }

}
