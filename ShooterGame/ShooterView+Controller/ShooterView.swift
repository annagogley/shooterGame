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
    var crossImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Const.crossImage)
        imageView.contentMode = .scaleAspectFit
        imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    var countdownLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var timeRemainingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var scoreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var shootButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        button.setTitle("Tap", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 45
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    var sceneView = ARSCNView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpFirstConstraints()
        setUpScheduledTimer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpScheduledTimer() {
        var runCount = 0
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            runCount += 1
            if runCount == 3 {
                timer.invalidate()
                self.countdownLabel.removeFromSuperview()
                self.setUpConstraints()
            }
        }
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
}
