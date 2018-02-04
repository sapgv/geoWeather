//
//  ListListPresenter.swift
//  geoWeather
//
//  Created by sapgv on 01/02/2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

class ListPresenter: ListModuleInput, ListViewOutput, ListInteractorOutput {
    
    weak var view: ListViewInput!
    var interactor: ListInteractorInput!
    var router: ListRouterInput!

    func viewIsReady() {

    }
    
    func fetchListForLocation(_ location: Location) {
        interactor.fetchListForlocation(location)
    }
    
    func didFoundListData(_ listData: [List]) {
        view.didFoundListData(listData)
    }
    
    
}
