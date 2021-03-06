//
//  FilterViewController.swift
//  Disaster Monitor
//
//  Created by Stefano Martina on 25/02/2020.
//  Copyright © 2020 Stefano Martina. All rights reserved.
//

import Tempura

// MARK: - ViewController
class FilterViewController: ViewController<FilterView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupInteraction() {
        
        rootView.didTapClose = {
            self.dismiss(animated: true, completion: nil)
        }
        
        rootView.didSlide = { [unowned self] v in
            self.dispatch(SetThreshold(value: v))
        }
        
        rootView.didTapSegmented = { [unowned self] v in
            self.dispatch(SetSegmented(value: v))
        }
        
        rootView.didTapSwitchINGV = { [unowned self] v in
            self.dispatch(SetINGVPreference(value: v))
        }
        
        rootView.didTapSwitchUSGS = { [unowned self] v in
            self.dispatch(SetUSGSPreference(value: v))
        }
    }
    
}
