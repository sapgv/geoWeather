//
//  ListListConfigurator.swift
//  geoWeather
//
//  Created by sapgv on 01/02/2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import UIKit
import Swinject

class ListModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? ListViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: ListViewController) {

        let r = ApplicationAssembly.assembler.resolver as! Container
        
        let router = ListRouter()

        let presenter = ListPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = ListInteractor()
        interactor.dataManager = r.resolve(ListDataManager.self)
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
