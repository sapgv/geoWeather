//
//  ListListRouter.swift
//  geoWeather
//
//  Created by sapgv on 01/02/2018.
//  Copyright © 2018 sapgv. All rights reserved.
//
import Swinject
import SwinjectStoryboard

class ListRouter: ListRouterInput {

    weak var weatherRouter: WeatherRouterInput!
    
    func presentListInterfaceForLocation(_ location: Location?, fromViewController viewController: UIViewController) {
        
        let container = ApplicationAssembly.assembler.resolver as! Container
        let storyboard = SwinjectStoryboard.create(name: "Main", bundle: nil, container: container)
        
        let listViewController = storyboard.instantiateViewController(withIdentifier: "listViewController") as! ListViewController
        listViewController.location = location
        ListModuleConfigurator().configureModuleForViewInput(viewInput: listViewController)
        
        viewController.navigationController?.pushViewController(listViewController, animated: true)
    }
    
}
