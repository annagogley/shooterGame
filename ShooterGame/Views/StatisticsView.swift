//
//  StatisticView.swift
//  ShooterGame
//
//  Created by Аня Воронцова on 19.09.2023.
//

import UIKit

final class StatisticsView: UIView {
    
    var tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTableView() {
        addSubview(tableView)
        tableView.frame = self.bounds
    }
}
