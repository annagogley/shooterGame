//
//  ViewController.swift
//  ShooterGame
//
//  Created by Аня Воронцова on 13.09.2023.
//

import UIKit
import SceneKit
import ARKit

class ShooterViewController: UIViewController, ARSCNViewDelegate {
    
    let gameSet = ShooterSettings.shared
    var player = AudioPlayer()
    var timer = Timer()

    private var shotCount: Int = 0
    private var userScore: Int = 0 {
        didSet {
            DispatchQueue.main.async {
                self.mainView.scoreLabel.text = String(self.userScore)
            }
        }
    }
    private var counter = 3
    private var timeRemaining = 60
    
    // swiftlint:disable force_cast
    var mainView: ShooterView { return self.view as! ShooterView}
    // swiftlint:enable force_cast
    override func loadView() {
        self.view = ShooterView(frame: UIScreen.main.bounds)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = SCNScene()
        mainView.sceneView.delegate = self
        mainView.sceneView.showsStatistics = true
        mainView.sceneView.scene = scene
        mainView.sceneView.scene.physicsWorld.contactDelegate = self
        mainView.onShootButtonTapped = { [weak self] in self?.shootButtonTapped()}
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        mainView.sceneView.session.delegate = self
        mainView.sceneView.session.run(configuration)
        countdown()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Pause the view's session
        mainView.sceneView.session.pause()
    }
    
    @objc private func shootButtonTapped() {
        guard gameSet.state == .inGame else {
            beginPlaying()
            return
        }
        shotCount += 1
        let bulletsNode = Bullet()
        player.playSound(Const.gunSoundURL)
        
        let (direction, position) = self.getUserVector()
        bulletsNode.position = position
        let bulletDirection = direction
        
        let impulseVector = SCNVector3(
            x: bulletDirection.x * Float(20),
            y: bulletDirection.y * Float(20),
            z: bulletDirection.z * Float(20)
        )
        
        bulletsNode.physicsBody?.applyForce(impulseVector, asImpulse: true)
        mainView.sceneView.scene.rootNode.addChildNode(bulletsNode)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            bulletsNode.removeFromParentNode()
        })
    }
}

// MARK: game logic
extension ShooterViewController {
    
    func beginPlaying() {
        gameSet.state = .inGame
        self.userScore = 0
        self.shotCount = 0
        self.counter = 3
        self.timeRemaining = 60
        self.countdown()
        self.addSphere()
    }
    
    func addSphere() {
        let node = Sphere()
        let posX = floatBetween(-0.5, and: 0.5)
        let posY = floatBetween(-0.5, and: 0.5)
        let posZ = -2
        node.position = SCNVector3(posX, posY, Float(posZ))
        DispatchQueue.main.async {
            self.mainView.sceneView.scene.rootNode.addChildNode(node)
        }
        gameSet.targets.append(node)
    }
    
    func getUserVector() -> (SCNVector3, SCNVector3) {
        if let frame = self.mainView.sceneView.session.currentFrame {
            let mat = SCNMatrix4(frame.camera.transform)
            let dir = SCNVector3(-1 * mat.m31, -1 * mat.m32, -1 * mat.m33)
            let pos = SCNVector3(mat.m41, mat.m42, mat.m43)
            return (dir, pos)
        }
        return (SCNVector3Zero, SCNVector3Zero)
    }
    
    func floatBetween(_ first: Float, and second: Float) -> Float {
        return (Float(arc4random()) / Float(UInt32.max)) * (first - second) + second
    }
    
    func removeNode(_ node: SCNNode) {
        if node is Sphere {
            // make explosion
            DispatchQueue.main.async {
                let scene = SCNScene(named: Const.particlesScene)
                let explosionNode = (scene?.rootNode.childNode(withName: Const.particles, recursively: true)!)!
                
                explosionNode.position = node.presentation.position
                self.mainView.sceneView.scene.rootNode.addChildNode(explosionNode)
                self.player.playSound(Const.blowSoundURL)
                
                if let sphere = node as? Sphere {
                    if let index = self.gameSet.targets.firstIndex(of: sphere) {
                        self.gameSet.targets.remove(at: index)
                    }
                }
            }
           
        }
        node.removeFromParentNode()
    }
    
    func endPlaying() {
        DispatchQueue.main.async { [self] in
            self.mainView.scoreLabel.text = "You've earned \(self.userScore) points. \n You've made \(self.shotCount) shots. \n Tap to continue."
            self.mainView.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
                node.removeFromParentNode()
            }
            let accuracyScore: Double = self.shotCount != 0 ? Double(self.userScore) / Double(self.shotCount) : 0.0
            CoreDataStack.shared.updateData(userScore: Double(self.userScore), shotScore: Double(self.shotCount), accuracyScore: accuracyScore, date: CurrentDate.shared.currentDate())
        }
        gameSet.state = .start
    }
}

extension ShooterViewController: SCNPhysicsContactDelegate, ARSessionDelegate {
    // bullet + sphere contact
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        if contact.nodeA.physicsBody?.categoryBitMask == CollisionCategory.target.rawValue && contact.nodeB.physicsBody?.categoryBitMask == CollisionCategory.bullets.rawValue {
            DispatchQueue.main.async {
                self.addSphere()
            }
            self.removeNode(contact.nodeA)
            self.removeNode(contact.nodeB)
            self.userScore += 1
        }
    }
}

// MARK: timer logic
extension ShooterViewController {
    
    func countdown() {
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(updateCounter),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc func updateCounter() {
        if gameSet.state == .start {
            if counter > 0 {
                counter -= 1
            } else {
                timer.invalidate()
                beginPlaying()
            }
            mainView.countdownLabel.text = String(counter)
        } else {
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer.invalidate()
                endPlaying()
            }
            mainView.timeRemainingLabel.text = String(timeRemaining)
        }
    }
}
