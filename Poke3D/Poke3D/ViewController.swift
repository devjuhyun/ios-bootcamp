//
//  ViewController.swift
//  Poke3D
//
//  Created by Juhyun Yun on 2023/02/16.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        sceneView.autoenablesDefaultLighting = true
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        // configuration에 포켓몬 카드를 추적하는 설정을 적용
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Pokemon Cards", bundle: Bundle.main) {
            configuration.trackingImages = imageToTrack
            
            configuration.maximumNumberOfTrackedImages = 2
            
            print("Images Successfully Added")
        }
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        // anchor = 우리가 찾고자 하는 대상, 이 앱의 경우 포켓몬 카드
        
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            
            if let pokemon = imageAnchor.referenceImage.name {
                
                let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
                
                plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.5)
                
                let planeNode = SCNNode(geometry: plane)
                
                planeNode.eulerAngles.x = -.pi / 2
                
                node.addChildNode(planeNode)
                
                if let pokeScene = SCNScene(named: "art.scnassets/\(pokemon).scn") {
                    
                    if let pokeNode = pokeScene.rootNode.childNodes.first {
                        
                        let light = SCNLight()
                        
                        light.type = .ambient
                        
                        pokeNode.light = light
                        
                        pokeNode.eulerAngles.x = .pi / 2
                        
                        planeNode.addChildNode(pokeNode)
                    }
                }
            }
            
            
            
            
            
            
        }
        
        
        return node
    }
    
}
