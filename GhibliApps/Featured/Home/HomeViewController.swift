//
//  ViewController.swift
//  GhibliApps
//
//  Created by Gus Adi on 22/07/21.
//

import UIKit
import Combine

final class HomeViewController: UIViewController {
    
    private typealias DataSource = UICollectionViewDiffableDataSource<HomeViewModel.Section, Film>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<HomeViewModel.Section, Film>
    
    private lazy var contentView = HomeView()
    
    private let viewModel: HomeViewModel
    private var bindings = Set<AnyCancellable>()
    
    private var dataSource: DataSource?
    
    init(viewModel: HomeViewModel = HomeViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        navigationController?.navigationBar.topItem?.title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setUpTableView()
        configureDataSource()
        setUpBindings()
        
        
    }
    
    private func setUpTableView() {
        contentView.collectionView.register(
            FilmCollectionCell.self,
            forCellWithReuseIdentifier: FilmCollectionCell.identifier)
    }
    
    private func setUpBindings() {
        
        func bindViewModelToView() {
            viewModel.$films
                .receive(on: RunLoop.main)
                .sink(receiveValue: { [weak self] _ in
                    self?.updateSections()
                })
                .store(in: &bindings)
            
            let stateValueHandler: (HomeViewModelState) -> Void = { [weak self] state in
                switch state {
                case .loading:
                    self?.contentView.startLoading()
                case .finishedLoading:
                    self?.contentView.finishLoading()
                case .error(let error):
                    self?.contentView.finishLoading()
                    self?.showError(error)
                }
            }
            
            viewModel.$state
                .receive(on: RunLoop.main)
                .sink(receiveValue: stateValueHandler)
                .store(in: &bindings)
        }
        
        bindViewModelToView()
    }
    
    func showError(_ error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func updateSections() {
        var snapshot = Snapshot()
        
        snapshot.appendSections([.film])
        snapshot.appendItems(viewModel.films)
        
        print(snapshot.itemIdentifiers)
        
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

extension HomeViewController {
    private func configureDataSource() {
        dataSource = DataSource(
            collectionView: contentView.collectionView,
            cellProvider: { (collectionView, indexPath, film) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FilmCollectionCell.identifier,
                    for: indexPath) as? FilmCollectionCell
                cell?.viewModel = FilmCellViewModel(films: film)
                return cell
            })
    }
}
