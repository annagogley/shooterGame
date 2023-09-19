//
//  StartViewController.swift
//  ShooterGame
//
//  Created by Аня Воронцова on 19.09.2023.
//

import UIKit

class StartViewController: UIViewController {
    
    // swiftlint:disable force_cast
    var startView: StartView { return self.view as! StartView}
    // swiftlint:enable force_cast
    override func loadView() {
        self.view = StartView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startView.onStartBtnTppd = { [weak self] in self?.startButtonTapped()}
        startView.onShwStatsBtnTppd = { [weak self] in self?.showStatistics()}
    }
    
    @objc func startButtonTapped() {
        navigationController?.pushViewController(ShooterViewController(), animated: true)
    }
    
    @objc func showStatistics() {
        navigationController?.pushViewController(StatisticsViewController(), animated: true)
    }
}
