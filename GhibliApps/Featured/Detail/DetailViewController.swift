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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
    }

    private func setUpViewModel() {
        print(viewModel.release)
    }
}
