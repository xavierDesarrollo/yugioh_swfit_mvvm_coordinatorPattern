//
//  CardDetailViewModel.swift
//  Yugioh
//
//  Created by Xavier Sotomayor on 27/2/24.
//

import Foundation

final class CardDetailViewModel {
    weak var delegate: RequestDelegate?
    weak var coordinator: AppCoordinator!
    var card: Card!
    
    private var state: ViewState {
        didSet {
            self.delegate?.didUpdate(with: state)
        }
    }

    init() {
        self.state = .success
    }
}
