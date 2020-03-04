//
//  FilterView.swift
//  Disaster Monitor
//
//  Created by Stefano Martina on 25/02/2020.
//  Copyright © 2020 Stefano Martina. All rights reserved.
//

import Foundation
import Katana
import Tempura
import PinLayout

// MARK: - ViewModel
struct FilterViewModel: ViewModelWithState {
    var state: AppState
    init?(state: AppState) {
        self.state = state
    }
}

// MARK: - View
class FilterView: UIView, ViewControllerModellableView {
    var slider = UISlider()
    var sliderLabel = UILabel()
    var sliderLabelComment = UILabel()
    
    var sortingLabel = UILabel()
    var sortingLabelComment = UILabel()
    
    var segmentedLabel = UILabel()
    var segmentedLabelComment = UILabel()
    
    let segmentedControl = UISegmentedControl(items: ["1", "3", "5", "7"])
    
    var didTapSlider: ((Float) -> ())?
    var didTapSegmented: ((Int) -> ())?
    var didTapClose: (() -> ())?
    
    @objc func didTapSliderFunc(sender: UISlider) {
        didTapSlider?(sender.value)
    }
    @objc func didTapCloseFunc() {
        didTapClose?()
    }
    @objc func didTapSegmentedFunc(sender: UISegmentedControl){
        didTapSegmented?(Int(sender.titleForSegment(at: sender.selectedSegmentIndex) ?? "") ?? 0)
    }
    
    func setup() {
        backgroundColor = .white
        self.addSubview(slider)
        self.addSubview(sliderLabel)
        self.addSubview(sliderLabelComment)
        self.addSubview(sortingLabel)
        self.addSubview(sortingLabelComment)
        self.addSubview(segmentedLabel)
        self.addSubview(segmentedLabelComment)
        self.addSubview(segmentedControl)
        
        self.sliderLabel.text = "Magnitudo"
        self.sliderLabelComment.text = "You can set here the desidered threshold"
        
        self.slider.isContinuous = false
        self.slider.maximumValue = 5
        self.slider.minimumValue = 0
        self.slider.frame = CGRect(x: 0, y: 0, width: 400, height: 35)
        self.slider.minimumTrackTintColor = .black
        self.slider.maximumTrackTintColor = .lightGray
        self.slider.thumbTintColor = .black
        
        slider.addTarget(self, action: #selector(didTapSliderFunc), for: .valueChanged)
        
        self.sortingLabel.text = "Sorting Preferences"
        self.sortingLabelComment.text = "You can set here the desidered ordering"
        
        self.segmentedLabel.text = "Time Period"
        self.segmentedLabelComment.text = "You can set the time period in days"
        self.segmentedControl.selectedSegmentIndex = 0
        self.segmentedControl.addTarget(self, action: #selector(didTapSegmentedFunc), for: .valueChanged)

        segmentedControl.layer.cornerRadius = 5.0
        segmentedControl.backgroundColor = .lightGray
        segmentedControl.tintColor = .systemGray6
    }
    
    func style() {
        backgroundColor = .systemBackground
        navigationItem?.title = "Filters"
        navigationItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapCloseFunc))
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.label] // cambia aspetto del titolo
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label] // cambia aspetto del titolo (con prefersLargeTitles = true)
            navigationBar?.tintColor = .systemBlue // tintColor changes the color of the UIBarButtonItem
            navBarAppearance.backgroundColor = .systemGray6 // cambia il colore dello sfondo della navigation bar
            // navigationBar?.isTranslucent = false // da provare la differenza tra true/false solo con colori vivi
            navigationBar?.standardAppearance = navBarAppearance
            navigationBar?.scrollEdgeAppearance = navBarAppearance
        } else {
            navigationBar?.tintColor = .systemBlue
            navigationBar?.barTintColor = .systemGray6
            // navigationBar?.isTranslucent = false
        }
        
        let h2title = UIFont(name: "Futura", size: 20)
        let h3title = UIFont(name: "Futura", size: 15)
                
        self.sliderLabel.font = h2title
        self.sliderLabelComment.font = h3title
        self.sliderLabelComment.textColor = .systemGray
        
        self.sortingLabel.font = h2title
        self.sortingLabelComment.font = h3title
        self.sortingLabelComment.textColor = .systemGray
        
        self.segmentedLabel.font = h2title
        self.segmentedLabelComment.font = h3title
        self.segmentedLabelComment.textColor = .systemGray
    }

    func update(oldModel: FilterViewModel?) {
        guard let model = self.model else {return}

        self.slider.setValue(model.state.filteringValue ?? 0, animated: true)
        self.segmentedControl.selectedSegmentIndex = ["1", "3", "5", "7"].index(of: String(model.state.segmentedDays) ?? "") ?? 0
        self.setNeedsLayout()
    }

    // layout
    override func layoutSubviews() {
        super.layoutSubviews()
                
        self.sliderLabel.pin.top(55).sizeToFit().marginTop(CGFloat(10)).left(30)
        self.sliderLabelComment.pin.below(of: sliderLabel).left(30).sizeToFit()
        self.slider.pin.below(of: sliderLabelComment).hCenter().width(80%).marginTop(10)
        
        self.sortingLabel.pin.below(of: slider).sizeToFit().marginTop(CGFloat(10)).left(30)
        self.sortingLabelComment.pin.below(of: sortingLabel).left(30).sizeToFit()
        
        self.segmentedLabel.pin.below(of: sortingLabelComment).left(30).marginTop(CGFloat(40)).sizeToFit()
        self.segmentedLabelComment.pin.below(of: segmentedLabel).left(30).sizeToFit()
        self.segmentedControl.pin.below(of: segmentedLabelComment).hCenter().width(80%).marginTop(10)
    }
    
    @objc func appo(){
        
    }
  
}