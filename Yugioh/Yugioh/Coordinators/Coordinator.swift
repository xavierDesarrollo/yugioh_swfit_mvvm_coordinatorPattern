//
//  Coordinator.swift
//  Yugioh
//
//  Created by Xavier Sotomayor on 27/2/24
//

import Foundation
import UIKit

protocol Coordinator {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController : UINavigationController { get set }
    
    func start()
}
