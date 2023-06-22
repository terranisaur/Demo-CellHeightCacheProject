//
//  ThreeLineCellView.swift
//  CellHeightCacheProject
//
//  Created by Alex Thurston on 6/22/23.
//

import Foundation
import UIKit

// MARK: ThreeLineCell

/// Cell for the `ThreeLineCellView`
class ThreeLineCell: UITableViewCell {
    
    private lazy var threeLineCellView = ThreeLineCellView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        threeLineCellView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(threeLineCellView)
        
        NSLayoutConstraint.activate([
            threeLineCellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            threeLineCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            threeLineCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            threeLineCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(viewModel: ThreeLineCellView.ViewModel) {
        threeLineCellView.update(viewModel: viewModel)
    }
}

// MARK: ThreeLineCellView

/// View that has up to 3 labels with different font sizes in a vertical stackView
class ThreeLineCellView: UIView {
    
    struct ViewModel {
        let firstLabelText: String
        let secondLabelText: String?
        let thirdLabelText: String?
    }
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var firstLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        
        return label
    }()
    
    private lazy var secondLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.preferredFont(forTextStyle: .body)
        
        return label
    }()
    
    private lazy var thirdLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        let bottomConstraint = stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        bottomConstraint.priority = .defaultHigh
        bottomConstraint.isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(viewModel: ViewModel) {
        stackView.arrangedSubviews.forEach { subview in
            stackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
        
        stackView.addArrangedSubview(firstLabel)
        firstLabel.text = viewModel.firstLabelText
        
        if let secondLabelText = viewModel.secondLabelText {
            stackView.addArrangedSubview(secondLabel)
            secondLabel.text = secondLabelText
        }
        
        if let thirdLabelText = viewModel.thirdLabelText {
            stackView.addArrangedSubview(thirdLabel)
            thirdLabel.text = thirdLabelText
        }
    }
}
