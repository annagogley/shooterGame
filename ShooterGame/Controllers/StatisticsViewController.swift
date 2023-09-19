//
//  StatisticsViewController.swift
//  ShooterGame
//
//  Created by Аня Воронцова on 19.09.2023.
//

import UIKit

class StatisticsViewController: UIViewController {
    var stats = [Statistics]()
    // swiftlint:disable force_cast
    var statView: StatisticsView { return self.view as! StatisticsView}
    // swiftlint:enable force_cast
    override func loadView() {
        self.view = StatisticsView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stats = CoreDataStack.shared.getAllStat()
        statView.tableView.register(StatTableViewCell.self, forCellReuseIdentifier: StatTableViewCell.identifier)
        statView.tableView.delegate = self
        statView.tableView.dataSource = self
        statView.tableView.rowHeight = UITableView.automaticDimension
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
        guard let cell = statView.tableView.dequeueReusableCell(withIdentifier: StatTableViewCell.identifier, for: indexPath) as? StatTableViewCell else {
            fatalError("TableView couldn't make CustomCell")
        }
        let stat = stats[indexPath.row]
        cell.configureCellWith(date: stat.date ?? "no date", userScore: stat.userScore, shotScore: stat.shotScore, accuracy: stat.accuracyScore)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        statView.tableView.deselectRow(at: indexPath, animated: true)
    }
}
