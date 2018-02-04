//
//  ApplicationAssembler.swift
//  geoWeather
//
//  Created by Гриша on 04.02.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation
import Swinject

final class ApplicationAssembly {
    
    //Use default dependency
    class var assembler: Assembler {
        return try! Assembler(assemblies: [
            ServiceComponentsAssembly()
            ])
    }
    
    var assembler: Assembler
    
    //If you want use custom Assembler
    init(with assemblies: [Assembly]) {
        assembler = try! Assembler(assemblies: assemblies)
    }
    
}
