//
//  ListListViewInput.swift
//  geoWeather
//
//  Created by sapgv on 01/02/2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

protocol ListViewInput: class {

    /**
        @author sapgv
        Setup initial state of the view
    */

    func setupInitialState()
    func didFoundListData(_ listData: [List])

}
