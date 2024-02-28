//
//  CardsViewModel.swift
//  Yugioh
//
//  Created by Xavier Sotomayor on 27/2/24.
//

import UIKit

enum Types: Int, CaseIterable {
    case all
    case crystron
    case destinyhero
    case sixsamurai

    var name: String {
        switch self {
            case .all: return "All"
            case .crystron: return "Crystron"
            case .destinyhero: return "Destiny HERO"
            case .sixsamurai: return "Six Samurai"
        }
    }
    
}

final class CardsViewModel {
    weak var delegate: RequestDelegate?
    weak var coordinator : AppCoordinator!
    
    private var state: ViewState {
        didSet {
            self.delegate?.didUpdate(with: state)
        }
    }

    private var cards: [Card] = []
    private var filteredCards: [Card] = []
    private var selectedType: Types = .all {
        didSet {
            self.filterData()
        }
    }

    init() {
        self.state = .idle
    }
}

// MARK: - DataSource
extension CardsViewModel {
    var numberOfItems: Int {
        filteredCards.count
    }

    func getInfo(for indexPath: IndexPath) -> (name: String, archetype: String?, type: String, desc: String, imageURL: String?) {
        let card = filteredCards[indexPath.row]
        return (name: card.name, archetype: card.archetype, type: card.type, desc: card.desc, imageURL: card.cardImages.first?.imageURL)
    }
}

// MARK: - Service
extension CardsViewModel {
    func loadData() {
        self.state = .loading
        CardService.getAllCards { result in
            switch result {
            case let .success(cards):
                self.cards = cards
                self.filteredCards = cards
                self.state = .success
            case let .failure(error):
                self.cards = []
                self.filteredCards = []
                self.state = .error(error)
            }
        }
    }

    func filterByType(type: Types) {
        self.selectedType = type
    }

    func selectedTypeName() -> String {
        self.selectedType.name
    }
}

// MARK: - Filter Data
private extension CardsViewModel {
    func filterData() {
        if selectedType == .all {
            self.filteredCards = cards
            self.state = .success
            return
        }
        if selectedType == .crystron {
            self.filteredCards = self.cards.filter {($0.archetype?.lowercased().contains(Types.crystron.name.lowercased()) ?? false)}
            self.state = .success
            return
        }
        if selectedType == .destinyhero {
            self.filteredCards = self.cards.filter {($0.archetype?.lowercased().contains(Types.destinyhero.name.lowercased()) ?? false)}
            self.state = .success
            return
        }
        if selectedType == .sixsamurai {
            self.filteredCards = self.cards.filter {($0.archetype?.lowercased().contains(Types.sixsamurai.name.lowercased()) ?? false)}
            self.state = .success
            return
        }
        self.filteredCards = self.cards.filter { $0.archetype?.lowercased().contains(self.selectedType.name.lowercased()) ?? false}
        self.state = .success
    }
}

// MARK: - Coordinator
extension CardsViewModel {
    func showDetail(indexPath: IndexPath) {
        coordinator.goToCardDetail(card: filteredCards[indexPath.row])
    }
}
