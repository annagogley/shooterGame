//
//  StartView.swift
//  ShooterGame
//
//  Created by Аня Воронцова on 19.09.2023.
//

import Foundation
import UIKit

final class StartView: UIView {
    var startGameButton: UIButton = {
        let button = UIButton()
        button.setupStartScreenButton(button: button, title: "Start Game", color: .red)
        return button
    }()
    var showStatsButton: UIButton = {
        let button = UIButton()
        button.setupStartScreenButton(button: button, title: "Show Stats", color: .blue)
        return button
    }()
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20.0
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Const.trophy)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraints() {
        stackView.addArrangedSubview(startGameButton)
        stackView.addArrangedSubview(showStatsButton)
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
}
