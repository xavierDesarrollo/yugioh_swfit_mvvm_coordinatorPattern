//
//  CardsViewController.swift
//  Yugioh
//
//  Created by Xavier Sotomayor on 27/2/24.
//

import UIKit
import SnapKit
import Kingfisher

class CardDetailViewController: AppController {
    
    var viewModel: CardDetailViewModel
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "card-placeholder")
        return imageView
    }()

    required init(viewModel: CardDetailViewModel) {
        self.viewModel = viewModel
        super.init()
        self.viewModel.delegate = self
        navigationItem.largeTitleDisplayMode = .always
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        configureLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK: UI Setup
private extension CardDetailViewController {
    func setupNavigation() {
        self.view.backgroundColor = .white
        navigationItem.title = "\(viewModel.card.archetype ?? "") - Card Detail"
    }
    
    func configureLayout() {
        view.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.leading.equalTo(10)
            $0.trailing.equalTo(-10)
            $0.top.equalTo(10)
            $0.bottom.equalTo(10)
        }
        
        let imageURL = URL(string: viewModel.card.cardImages.first!.imageURL)
        self.imageView.kf.setImage(with: imageURL, placeholder: #imageLiteral(resourceName: "card-placeholder"))
        self.imageView.layer.cornerRadius = 20
    }
}

// MARK: RequestDelegate
extension CardDetailViewController: RequestDelegate {
    func didUpdate(with state: ViewState) {
        
    }
}
