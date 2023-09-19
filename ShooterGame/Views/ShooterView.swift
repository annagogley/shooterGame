//
//  crossUIImageView.swift
//  ShooterGame
//
//  Created by Аня Воронцова on 19.09.2023.
//

import Foundation
import UIKit
import ARKit

final class ShooterView: UIView {
    var onShootButtonTapped: (() -> Void)?
    var crossImage = UIImageView()
    var countdownLabel = UILabel()
    var timeRemainingLabel = UILabel()
    var scoreLabel = UILabel()
    var shootButton = UIButton()
    var sceneView = ARSCNView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCrossImage()
        configureTimeLabel(label: countdownLabel)
        configureTimeLabel(label: timeRemainingLabel)
        configureScoreLabel()
        configureShootButton()
        setUpFirstConstraints()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            self.countdownLabel.removeFromSuperview()
            self.setUpConstraints()
        })
        addAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCrossImage() {
        crossImage.image = UIImage(named: Const.crossImage)
        crossImage.contentMode = .scaleAspectFit
        crossImage.image = crossImage.image?.withRenderingMode(.alwaysTemplate)
        crossImage.tintColor = .white
        crossImage.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureTimeLabel(label: UILabel) {
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureScoreLabel() {
        scoreLabel.font = .systemFont(ofSize: 20, weight: .bold)
        scoreLabel.textAlignment = .center
        scoreLabel.numberOfLines = 3
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureShootButton() {
        shootButton.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        shootButton.setTitle("Tap", for: .normal)
        shootButton.setTitleColor(.white, for: .normal)
        shootButton.layer.cornerRadius = 45
        shootButton.layer.masksToBounds = true
        shootButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setUpFirstConstraints() {
        addSubview(sceneView)
        addSubview(countdownLabel)
        sceneView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            sceneView.topAnchor.constraint(equalTo: topAnchor),
            sceneView.leftAnchor.constraint(equalTo: leftAnchor),
            sceneView.rightAnchor.constraint(equalTo: rightAnchor),
            sceneView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            countdownLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            countdownLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
    }
    
    private func setUpConstraints() {
        addSubview(crossImage)
        addSubview(timeRemainingLabel)
        addSubview(scoreLabel)
        addSubview(shootButton)
        
        NSLayoutConstraint.activate([
            
            timeRemainingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            timeRemainingLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 20),
            
            scoreLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            scoreLabel.topAnchor.constraint(equalTo: timeRemainingLabel.bottomAnchor, constant: 5),
            
            crossImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            crossImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            crossImage.widthAnchor.constraint(equalToConstant: 50),
            crossImage.heightAnchor.constraint(equalToConstant: 50),
            
            shootButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -20),
            shootButton.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -20),
            shootButton.widthAnchor.constraint(equalToConstant: 100),
            shootButton.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func addAction() {
        shootButton.addTarget(self, action: #selector(self.shootButtonTapped), for: .touchUpInside)
    }
    
    @objc func shootButtonTapped() {
        onShootButtonTapped?()
    }
}
