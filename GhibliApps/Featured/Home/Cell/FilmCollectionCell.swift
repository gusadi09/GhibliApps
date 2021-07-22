//
//  FilmCollectionCell.swift
//  GhibliApps
//
//  Created by Gus Adi on 22/07/21.
//

import UIKit
import Combine

final class FilmCollectionCell: UICollectionViewCell {
    static let identifier = "FilmTableViewCell"
    
    var viewModel: FilmCellViewModel! {
        didSet { setUpViewModel() }
    }
    
    lazy var titleLabel = UILabel()
    lazy var releaseLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubiews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubiews() {
        let subviews = [titleLabel, releaseLabel]
        
        subviews.forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0),
            
            releaseLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            releaseLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 10.0),
            releaseLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.0),
            releaseLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor)
        ])
    }
    
    private func setUpViewModel() {
        titleLabel.text = viewModel.title
        releaseLabel.text = viewModel.release
    }
}
