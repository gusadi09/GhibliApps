//
//  ViewController.swift
//  GhibliApps
//
//  Created by Gus Adi on 22/07/21.
//

import UIKit
import Combine

final class HomeViewController: UIViewController {
    
    private lazy var contentView = HomeView()
    
    
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
    }
    
    private func setUpBindings() {
        func bindViewToViewModel() {
            
        }
        
        func bindViewModelToView() {
            
        }
        
        bindViewToViewModel()
        bindViewModelToView()
    }
    
    private func showError(_ error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func updateSections() {
       
    }

}

extension HomeViewController {
    private func configureDataSource() {
        
    }
}
