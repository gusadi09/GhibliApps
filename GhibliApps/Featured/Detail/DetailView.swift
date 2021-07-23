//
//  DetailView.swift
//  GhibliApps
//
//  Created by Gus Adi on 22/07/21.
//

import Foundation
import UIKit

final class DetailView: UIView {
    lazy var activityIndicationView = ActivityIndicatorView(style: .medium)
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var desc: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var releaseLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var directorLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        return v
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.spacing = 25
        
        return stack
    }()
    
    lazy var secStackView: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.spacing = 10
        
        return stack
    }()
    
    lazy var statStackView: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .horizontal
        stack.spacing = 15
        
        return stack
    }()
    
    lazy var contentView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    
    init() {
        super.init(frame: .zero)
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        addSubview(activityIndicationView)
        
        addSubviews()
        setUpConstraints()
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        [
            directorLabel,
            releaseLabel,
        ].forEach { (view) in
            statStackView.addArrangedSubview(view)
        }
        
        [
            titleLabel,
            statStackView,
        ].forEach { (view) in
            secStackView.addArrangedSubview(view)
        }
        
        [
            secStackView,
            desc,
        ].forEach { (view) in
            stackView.addArrangedSubview(view)
        }
    }
    
    func startLoading() {
        
        activityIndicationView.isHidden = false
        activityIndicationView.startAnimating()
    }
    
    func finishLoading() {
        
        activityIndicationView.stopAnimating()
    }
    
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            activityIndicationView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicationView.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicationView.heightAnchor.constraint(equalToConstant: 50),
            activityIndicationView.widthAnchor.constraint(equalToConstant: 50.0)
        ])
    }
    
    private func setUpViews() {
        
    }
}
