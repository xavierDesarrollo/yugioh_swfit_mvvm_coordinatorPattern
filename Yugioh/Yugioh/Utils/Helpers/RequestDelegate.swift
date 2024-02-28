//
//  RequestDelegate.swift
//  Yugioh
//
//  Created by Xavier Sotomayor on 27/2/24.
//

import Foundation

protocol RequestDelegate: AnyObject {
    func didUpdate(with state: ViewState)
}
