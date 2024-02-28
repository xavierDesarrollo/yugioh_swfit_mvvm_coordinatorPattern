//
//  CardsViewController.swift
//  Yugioh
//
//  Created by Xavier Sotomayor on 27/2/24.
//

import UIKit
import SnapKit

class CardsViewController: AppController {
    
    var viewModel: CardsViewModel
    
    private lazy var filterSegment: UISegmentedControl = {
        let segmented = UISegmentedControl(items: Types.allCases.map { $0.name })
        segmented.selectedSegmentIndex = 0
        segmented.addTarget(self, action: #selector(didSelectItem(_:)), for: .valueChanged)
        return segmented
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.registerCell(cellClass: CardListCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        return tableView
    }()

    required init(viewModel: CardsViewModel) {
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
        viewModel.loadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK: UI Setup
private extension CardsViewController {

    func setupNavigation() {
        navigationItem.titleView = filterSegment
    }

    func configureLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: Actions
private extension CardsViewController {
    @objc func didSelectItem(_ selector: UISegmentedControl) {
        self.viewModel.filterByType(type: Types(rawValue: selector.selectedSegmentIndex) ?? .all)
    }
}

// MARK: UITableViewDataSource & UITableViewDelegate
extension CardsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cellClass: CardListCell.self, indexPath: indexPath)
        cell.configure(info: viewModel.getInfo(for: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.showDetail(indexPath: indexPath)
    }
}

// MARK: RequestDelegate
extension CardsViewController: RequestDelegate {
    func didUpdate(with state: ViewState) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            switch state {
            case .idle:
                break
            case .loading:
                self.startLoading()
            case .success:
                self.tableView.setContentOffset(.zero, animated: true)
                self.tableView.reloadData()
                self.stopLoading()
            case .error(let error):
                self.stopLoading()
                self.present(error: error, customAction: UIAlertAction(title: "Try Again", style: .default, handler: { [weak self] _ in
                    guard let self = self else { return }
                    self.viewModel.loadData()
                }))
            }
        }
    }
}
