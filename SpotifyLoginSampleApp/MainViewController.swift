//
//  MainViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by 이성주 on 2021/09/26.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController {
    @IBOutlet weak var welcomeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //pop gesture 막을 수 있는..
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //네비게이션 숨기기
        navigationController?.navigationBar.isHidden = true
        
        let email = Auth.auth().currentUser?.email ?? "고객"
        welcomeLabel.text = """
            환영합니다.
            \(email)님
            """
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        //Logout

        let firebaseAuth = Auth.auth()
    
        do {
            try firebaseAuth.signOut()
            self.navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("ERROR: signout \(signOutError.description)")
        }
        
        
    }
    
}
