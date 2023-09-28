//
//  StatisticsViewController.swift
//  ShooterGame
//
//  Created by Аня Воронцова on 19.09.2023.
//

import UIKit

class StatisticsViewController: UIViewController {
    var stats = [Statistics]()
    var statView = UITableView()
    override func loadView() {
        self.view = statView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stats = CoreDataStack.shared.getAllStat()
        statView.register(StatisticsTableViewCell.self, forCellReuseIdentifier: StatisticsTableViewCell.identifier)
        statView.delegate = self
        statView.dataSource = self
        statView.rowHeight = UITableView.automaticDimension
    }
}

extension StatisticsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if stats.count == 0 {
            tableView.setEmptyMessage(Const.noStatMessage)
        } else {
            tableView.restore()
        }
        return stats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = statView.dequeueReusableCell(withIdentifier: StatisticsTableViewCell.identifier, for: indexPath) as? StatisticsTableViewCell else {
            fatalError("TableView couldn't make CustomCell")
        }
        let stat = stats[indexPath.row]
        cell.configureCellWith(date: stat.date ?? "no date", userScore: stat.userScore, shotScore: stat.shotScore, accuracy: stat.accuracyScore)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        statView.deselectRow(at: indexPath, animated: true)
    }
}
