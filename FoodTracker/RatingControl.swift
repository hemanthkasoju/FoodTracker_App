//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Hemanth Kasoju on 2018-09-24.
//  Copyright © 2018 Hemanth Kasoju. All rights reserved.
//

import UIKit

// This class is a subclass of UIStackView. This class is used for rating a meal.
@IBDesignable class RatingControl: UIStackView {
    
    //MARK: Properties
    
    private var ratingButtons = [UIButton]()
    
    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }

    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    
    //MARK: Initialization
    
    //Initializer is a method that prepares an instance of a class for use, which involves setting an initial value for each property
    
    //This function is called for programatically initializing the view
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    //This function is called for loading the view from the storyboard
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    //MARK: Button Action
    
    // This function is called when a star is pressed while rating a meal
    @objc func ratingButtonTapped(button: UIButton) {
        // For the index of the pressed button
        guard let index = ratingButtons.index(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        
        // Calculate the rating of the selected button
        let selectedRating = index + 1
        
        if selectedRating == rating {
            // If the selected star represents the current rating, reset the rating to 0.
            rating = 0
        } else {
            // Otherwise set the rating to the selected star
            rating = selectedRating
        }
    }
    
    
    //MARK: Private Methods
    
    //This function evaluates the stars that have to be shown depending on the rating of the meal.
    private func setupButtons() {
        
        // Clear any existing buttons
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        // Load Button Images
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named:"emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named:"highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        for index in 0..<starCount {
            // Create the button
            let button = UIButton()
            
            // Set the button images
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            
            // Add constraints
            button.translatesAutoresizingMaskIntoConstraints = false // Disables the button’s automatically generated constraints
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true // Activates height constraint for the button
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true // Activates width constraint for the button
            
            // Set the accessibility label
            button.accessibilityLabel = "Set \(index + 1) star rating"
            
            // Setup the button action
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            // Add the button to the rating control stack view
            addArrangedSubview(button)
            
            // Add the new button to the rating button array
            ratingButtons.append(button)
        }
        
        updateButtonSelectionStates()
    }
    
    //This function iterates through the buttons and sets each one’s selected state based on its position and the rating.
    private func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            
            // If the index of a button is less than the rating, that button should be selected.
            button.isSelected = index < rating
            
            // Set accessibility hint and value
            let hintString: String?
            if rating == index + 1 {
                hintString = "Tap to reset the rating to zero."
            } else {
                hintString = nil
            }

            let valueString: String
            switch (rating) {
            case 0:
                valueString = "No rating set."
            case 1:
                valueString = "1 star set."
            default:
                valueString = "\(rating) stars set."
            }
            
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }
}
