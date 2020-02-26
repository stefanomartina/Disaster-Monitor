//
//  MainViewController.swift
//  Disaster Monitor
//
//  Created by Stefano Martina on 17/12/2019.
//  Copyright © 2019 Stefano Martina. All rights reserved.
//

import UIKit
import Katana
import Tempura
import PinLayout


// MARK: - View Controller
// Ha la responsabilità di passare alla view un nuovo viewmodel a ogni update
class MainViewController: ViewController<MainView> {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dispatch(GetEvent())

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Main Events"

        let rightButtonView = UIView.init(frame: CGRect(x: 0, y: 0, width: 70, height: 50))
        let rightButton = UIButton.init(type: .system)
        rightButton.backgroundColor = .clear
        rightButton.frame = rightButtonView.frame
        rightButton.setTitle("Filters", for: .normal)
        rightButton.titleLabel?.font = UIFont(name: "Futura", size: 20)
        rightButton.tintColor = .black
        rightButton.autoresizesSubviews = true
        rightButton.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        rightButton.addTarget(self, action: #selector(openFilter), for: .touchUpInside)
        rightButtonView.addSubview(rightButton)
        let leftBarButton = UIBarButtonItem.init(customView: rightButtonView)
        self.navigationItem.rightBarButtonItem = leftBarButton
        
        // TODO: Rivedere questo pezzo di codice perché molto dubbio
        
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = .systemGray6
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]

        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        
        //self.dispatch(GetEvent()) c'è già sopra
    }
    
    @objc override func setupInteraction() {
        //self.dispatch(GetEvent())
        //self.dispatch(FilterEvent())
        //print(store.state)
        
    }
    
    @objc func openFilter(){
        let vc = FilterViewController(store: store)
        self.present(vc, animated: true, completion: nil)
    }
    
}

enum Screen: String {
    case home
}
