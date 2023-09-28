//
//  StartViewController.swift
//  ShooterGame
//
//  Created by Аня Воронцова on 19.09.2023.
//

import UIKit

class StartViewController: UIViewController {
    
    var startView = StartView()
    override func loadView() {
        self.view = startView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startView.startGameButton.addTarget(self, action: #selector(self.startButtonTapped), for: .touchUpInside)
        startView.showStatsButton.addTarget(self, action: #selector(self.showStatistics), for: .touchUpInside)
    }
    
    @objc func startButtonTapped() {
        navigationController?.pushViewController(ShooterViewController(), animated: true)
    }
    
    @objc func showStatistics() {
        navigationController?.pushViewController(StatisticsViewController(), animated: true)
    }
}
