//
//  DetailViewController.swift
//  GhibliApps
//
//  Created by Gus Adi on 22/07/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    var viewModel: DetailViewModel! {
        didSet { setUpViewModel() }
    }
    
    private lazy var contentView = DetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view = contentView
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setUpViewModel() {
        contentView.titleLabel.text = viewModel.title
        contentView.desc.text = "Description : \n\(viewModel.description)"
        contentView.directorLabel.text = "Director: \n\(viewModel.director)"
        contentView.releaseLabel.text = "Release Year: \n\(viewModel.release)"
    }
}
