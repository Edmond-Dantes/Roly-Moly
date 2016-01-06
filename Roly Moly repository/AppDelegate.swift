//
//  AppDelegate.swift
//  Roly Moly Mac
//
//  Created by Future on 2/2/15.
//  Copyright (c) 2015 Future. All rights reserved.
//


import Cocoa
import SpriteKit

extension SKNode {
    class func unarchiveFromFile(file : NSString) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file as String, ofType: "sks") {
            let sceneData = try! NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe)
            let archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! SKNode //as! MazeScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}


let gameScene = GameScene.unarchiveFromFile("GameScene") as? GameScene
let mazeScene = MazeScene.unarchiveFromFile("MazeScene") as? MazeScene


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var skView: SKView!
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        /* Pick a size for the scene */
        //if let scene = MazeScene.unarchiveFromFile("MazeScene") as? MazeScene {
        //if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
        /* Set the scale mode to scale to fit the window */
        // scene.scaleMode = .AspectFit//*/ .AspectFill
        // scene.size = gameFrame.size
        
        gameScene!.scaleMode = .AspectFit//*/ .AspectFill
        //self.skView.frame.size = gameFrame.size
        gameScene!.size = gameFrame.size
        
        mazeScene!.scaleMode = .AspectFit
        mazeScene!.size = gameFrame.size
        
        self.skView!.presentScene(gameScene)
        self.skView!.presentScene(mazeScene)
        //self.skView!.presentScene(<#scene: SKScene?#>, transition: <#SKTransition?#>)
        
        //scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        self.skView!.ignoresSiblingOrder = true
        
        self.skView!.showsFPS = true
        self.skView!.showsNodeCount = true
    }
    
    
    func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
        return true
    }
}
