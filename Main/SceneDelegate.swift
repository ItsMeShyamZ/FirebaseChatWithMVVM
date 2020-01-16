//
//  SceneDelegate.swift
//  FireBaseChat
//
//  Created by Abservetech on 07/01/20.
//  Copyright © 2020 Abservetech. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    var FBConnet : FireBaseconnection?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        guard let _ = (scene as? UIWindowScene) else { return }
        
        
        FBConnet = FireBaseconnection.instanse


        if let windowScene = scene as? UIWindowScene {

        self.window = UIWindow(windowScene: windowScene)

            self.window!.makeKeyAndVisible()
            let userid : String = UserDefaults.standard.value(forKey: R.userDefaultsKey.myid.rawValue) as? String ?? ""
            if userid.isEmpty{
                let root = UserVC.initWithStoryBoard()
                 let Navi = UINavigationController(rootViewController: root)
                 self.window?.rootViewController = Navi
            }else{

                let root = PetDatingVC.initWithStoryBoard()
                 let Navi = UINavigationController(rootViewController: root)
                 self.window?.rootViewController = Navi
            }
        
        }


        }
    

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        self.FBConnet?.updateOnline(online: "online")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        self.FBConnet?.updateOnline(online: "offline")
    }


}

