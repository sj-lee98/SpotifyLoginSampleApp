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
    @IBOutlet weak var resetPasswordButton: UIButton!
    
    
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
        //이메일 로그인이 아닌 구글, 애플 로그인 시 비밀번호 변경 버튼 숨기기
        //아래 경로로 갔을때 "password"가 찍혀 있으면 이메일/비밀번호로 로그인 한 것
        let isEmailSignIn = Auth.auth().currentUser?.providerData[0].providerID == "password"
        resetPasswordButton.isHidden = !isEmailSignIn
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
    
    @IBAction func resetPasswordButtonTapped(_ sender: UIButton) {
        // 현재 사용자의 이메일로 사용자가 비밀번호를 리셋할 수 있는 이메일 보내게 된다.
        let email = Auth.auth().currentUser?.email ?? ""
        Auth.auth().sendPasswordReset(withEmail: email, completion: nil)
    }
    
    
    
}
