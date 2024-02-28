//
//  AppCoordinator.swift
//  Yugioh
//
//  Created by Xavier Sotomayor on 27/2/24.
//

import UIKit

class AppCoordinator : Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        goToCards()
    }
    
    let storyboard = UIStoryboard.init(name: "LaunchScreen", bundle: .main)
    func goToCards() {
        let cardsViewModel = CardsViewModel.init()
        cardsViewModel.coordinator = self
        navigationController.pushViewController(CardsViewController(viewModel: cardsViewModel), animated: true)
    }
    
    func goToCardDetail(card: Card) {
        let cardDetailViewModel = CardDetailViewModel.init()
        cardDetailViewModel.coordinator = self
        cardDetailViewModel.card = card
        navigationController.pushViewController(CardDetailViewController(viewModel: cardDetailViewModel), animated: true)
    }
}
