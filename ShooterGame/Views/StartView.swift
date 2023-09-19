//
//  StartView.swift
//  ShooterGame
//
//  Created by Аня Воронцова on 19.09.2023.
//

import Foundation
import UIKit

final class StartView: UIView {
    var onStartBtnTppd: (() -> Void)?
    var onShwStatsBtnTppd: (() -> Void)?
    var startGameButton = UIButton()
    var showStatsButton = UIButton()
    var stackView = UIStackView()
    var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupStackView()
        setupImageView()
        setUpConstraints()
        addAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupImageView() {
        imageView.image = UIImage(named: Const.trophy)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setUpButton(button: UIButton, title: String, color: UIColor) {
        button.backgroundColor = color
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupStackView() {
        setUpButton(button: startGameButton, title: "Start Game", color: .red)
        setUpButton(button: showStatsButton, title: "Show Stats", color: .blue)
        stackView.addArrangedSubview(startGameButton)
        stackView.addArrangedSubview(showStatsButton)
        stackView.axis = .vertical
        stackView.spacing = 20.0
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setUpConstraints() {
        addSubview(imageView)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 40),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100),
            stackView.heightAnchor.constraint(equalToConstant: 160)
        ])
    }
    
    func addAction() {
        startGameButton.addTarget(self, action: #selector(self.startButtonTapped), for: .touchUpInside)
        showStatsButton.addTarget(self, action: #selector(self.showStatistics), for: .touchUpInside)
    }
    
    @objc func startButtonTapped() {
        onStartBtnTppd?()
    }
    
    @objc func showStatistics() {
        onShwStatsBtnTppd?()
    }
}
