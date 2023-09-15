//
//  Bullet.swift
//  ShooterGame
//
//  Created by Аня Воронцова on 14.09.2023.
//

import Foundation
import SceneKit

class Bullet: SCNNode {
    override init () {
        super.init()
        let sphere = SCNSphere(radius: 0.025)
        self.geometry = sphere
        let shape = SCNPhysicsShape(geometry: sphere, options: nil)
        self.physicsBody = SCNPhysicsBody(type: .dynamic, shape: shape)
        self.physicsBody?.isAffectedByGravity = false
        self.physicsBody?.categoryBitMask = CollisionCategory.bullets.rawValue
        self.physicsBody?.contactTestBitMask = CollisionCategory.target.rawValue
        
        self.geometry?.materials.first?.diffuse.contents = UIColor.yellow
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
