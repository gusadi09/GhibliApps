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
        setupView()
        
        contentView.layer.backgroundColor = UIColor.white.cgColor
        
        contentView.layer.cornerRadius = 20
        contentView.layer.shadowOffset = CGSize(width: 0,
                                          height: 4)
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowOpacity = 0.2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        titleLabel.contentHuggingPriority(for: .horizontal)
        releaseLabel.contentHuggingPriority(for: .horizontal)
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
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15.0),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
            
            releaseLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
            releaseLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15.0),
            releaseLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20.0),
            releaseLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor)
        ])
    }
    
    private func setUpViewModel() {
        titleLabel.text = viewModel.title
        releaseLabel.text = "release: \(viewModel.release)"
    }
}
