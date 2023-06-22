//
//  ViewController.swift
//  CellHeightCacheProject
//
//  Created by Alex Thurston on 6/21/23.
//

import UIKit

class MainViewController: UITableViewController {
    
    private let dataSource: [ThreeLineCellView.ViewModel]
    
    private let cache = CellHeightCache()
    
    required init?(coder: NSCoder) {
        // Setup test dataSource
        self.dataSource = (1...100).map { index -> ThreeLineCellView.ViewModel in
            var secondLabelText: String? {
                index % 2 == 0 ? "Second \(index)" : nil
            }
            var thirdLabelText: String? {
                index % 4 == 0 ? "Third \(index)" : nil
            }
            return ThreeLineCellView.ViewModel(firstLabelText: "Main \(index)",
                                               secondLabelText: secondLabelText,
                                               thirdLabelText: thirdLabelText)
        }
        
        super.init(coder: coder)
    }
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.prefetchDataSource = self
        tableView.register(ThreeLineCell.self, forCellReuseIdentifier: "ThreeLineCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let visibleRowsIndexPaths = tableView.indexPathsForVisibleRows {
            cacheHeight(for: visibleRowsIndexPaths)
        }
    }
    
    // MARK: Cache Height
    private func cacheHeight(for indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            let viewModel = dataSource[indexPath.row]
            cache.cacheHeight(for: viewModel)
        }
    }

    // MARK: UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThreeLineCell") as! ThreeLineCell
        let viewModel = dataSource[indexPath.row]
        cell.update(viewModel: viewModel)
        return cell
    }
    
    // MARK: UITableViewDelegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let viewModel = dataSource[indexPath.row]
        if let height = cache.height(for: viewModel) {
            print("Returning cached height: \(height)")
            return height
        } else {
            print("Returning automaticDimension height")
            return UITableView.automaticDimension
        }
    }
}

// MARK: UITableViewDataSourcePrefetching
extension MainViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        cacheHeight(for: indexPaths)
    }
}
