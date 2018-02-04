//
//  ListListInteractor.swift
//  geoWeather
//
//  Created by sapgv on 01/02/2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

class ListInteractor: ListInteractorInput {

    weak var output: ListInteractorOutput!
    var dataManager: ListDataManager!
    
    func fetchListForlocation(_ location: Location) {
        dataManager.findList(location) { listData in
            self.output.didFoundListData(listData)
        }
    }

}
