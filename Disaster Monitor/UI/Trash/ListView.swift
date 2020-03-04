//
//  ListView.swift
//
//
//  Created on 28/11/2019
//

import UIKit
import Tempura
import PinLayout
import GoogleMaps
import GooglePlaces

struct ListViewModel: ViewModel {
    var list : [Event]
    var filteringValue : Float
    init(state: AppState) {
        self.list = state.events
        self.filteringValue = state.filteringValue ?? 0
    }
}


class ListView: UIView, ModellableView {
    var scrollView = UIScrollView()
    var eventsListView: CollectionView<EventCell, SimpleSource<EventCellViewModel>>!
    
    // MARK: - Interactions
    var animate: Interaction?
        
    func setup(){
        self.scrollView.isPagingEnabled = true
        self.scrollView.isScrollEnabled = false
        let eventsLayout = EventsFlowLayout()
        self.eventsListView = CollectionView<EventCell, SimpleSource<EventCellViewModel>>(frame: .zero, layout: eventsLayout)
        self.eventsListView.useDiffs = true
        self.scrollView.addSubview(self.eventsListView)
        self.addSubview(self.scrollView)
    }
    
    func style() {
        self.backgroundColor = .systemBackground
        self.eventsListView.backgroundColor = .systemBackground
        self.scrollView.backgroundColor = .systemBackground
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.scrollView.pin.all()
        self.eventsListView.frame = self.scrollView.frame.bounds
    }
    
    func update(oldModel: ListViewModel?) {
        guard let model = self.model else { return }

        let events = model.list.filter{$0.magnitudo > model.filteringValue}.map{EventCellViewModel(id: $0.id, name: $0.name, magnitudo:$0.magnitudo, description: $0.description, coord:$0.coordinates )}
        
        if events.count != 0{
            self.eventsListView.source = SimpleSource<EventCellViewModel>(events)
        }else{
            self.eventsListView.source = SimpleSource<EventCellViewModel>([EventCellViewModel(id: "NONE", name: "Nothing to show", magnitudo: 0, description: "Change filters", coord:[0, 0] )])
        }
        self.setNeedsLayout()
    }
    
    @objc func segmentedValueChanged(_ sender:UISegmentedControl!) {
        // TODO: change source of attractionListView
        print("Selected Segment Index is : \(sender.selectedSegmentIndex)")
    }
}
