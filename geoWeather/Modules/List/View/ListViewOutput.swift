//
//  ListListViewOutput.swift
//  geoWeather
//
//  Created by sapgv on 01/02/2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

protocol ListViewOutput {

    /**
        @author sapgv
        Notify presenter that view is ready
    */

    func viewIsReady()
    func fetchListForLocation(_ location: Location)
}
