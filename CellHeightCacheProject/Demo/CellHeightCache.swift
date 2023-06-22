//
//  CellHeightCache.swift
//  CellHeightCacheProject
//
//  Created by Alex Thurston on 6/21/23.
//

import Foundation
import UIKit

class CellHeightCache {
    
    struct CacheKey: Hashable {
        // If the user increases dynamic font size we want to re-cache the view
        let contentSizeCategory: UIContentSizeCategory
        // If the view has a SecondLabel which will increase the height
        let hasSecondLabel: Bool
        // If the view has a Third Label which will increase the height
        let hasThirdLabel: Bool
    }
    
    private var cache: [CacheKey: CGFloat] = [:]
    
    func cacheHeight(for viewModel: ThreeLineCellView.ViewModel) {
        // Create a CacheKey for the cell
        let key = self.key(for: viewModel)
        
        // No need to cache the height again if we already have it cached
        guard cache[key] == nil else { return }
        
        let view = ThreeLineCellView()
        view.update(viewModel: viewModel)
        
        // Calculate the height for the cell
        let height = view.systemLayoutSizeFitting(
            UIView.layoutFittingCompressedSize,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        ).height
        
        cache[key] = height
    }
    
    func height(for viewModel: ThreeLineCellView.ViewModel) -> CGFloat? {
        cache[key(for: viewModel)]
    }
    
    private func key(for viewModel: ThreeLineCellView.ViewModel) -> CacheKey {
        CacheKey(contentSizeCategory: UITraitCollection.current.preferredContentSizeCategory,
                 hasSecondLabel: viewModel.secondLabelText != nil,
                 hasThirdLabel: viewModel.thirdLabelText != nil)
    }
}
