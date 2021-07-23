//
//  DetailViewController.swift
//  GhibliApps
//
//  Created by Gus Adi on 22/07/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    var items: Film?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        print(items?.release_date)
    }

}
