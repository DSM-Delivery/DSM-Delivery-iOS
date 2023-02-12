import UIKit
import Then
import SnapKit
import Moya


class LoginViewController: BaseViewController {
    
    let signinLabel = UILabel().then {
        $0.text = "Sign in"
        $0.textColor = DSMDeliveryAsset.Color.green600.color
        $0.font = UIFont.systemFont(ofSize: 30, weight: .bold)
    }
    let idTextField = UITextField().then {
        $0.placeholder = "  아이디"
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = DSMDeliveryAsset.Color.gray200.color.cgColor
    }
    let passwordTextField = UITextField().then {
        $0.placeholder = "  비밀번호"
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = DSMDeliveryAsset.Color.gray200.color.cgColor
    }
    let loginButton = UIButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.backgroundColor = DSMDeliveryAsset.Color.green400.color
        $0.layer.cornerRadius = 10
        $0.addTarget(self,
                     action: #selector(didLoginButtonTaped),
                     for: .touchUpInside)
    }
    let signupLabel = UILabel().then {
        $0.text = "회원이 아니신가요? 회원가입"
        
    }
    
    @objc func didLoginButtonTaped() {
        guard let userId = idTextField.text, userId.isEmpty == false else { return }
        guard let userPw = passwordTextField.text, userPw.isEmpty == false else { return }
        MY.request(.login(id: userId, password: userPw)){res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200:
                    let decoder = JSONDecoder()
                    if let data = try? decoder.decode(LoginDataModel.self, from: result.data) {
                        Token._accessToken = data.accessToken
                        DispatchQueue.main.async {
                            self.navigationController?.pushViewController(MainViewController(), animated: true)
                        }
                    } else {
                        print("Login: decoder error")
                    }
                default:
                    print("Login: status \(result.statusCode)")
                }
                
            case .failure(let err):
                print("Login respons fail: \(err.localizedDescription)")
            }
        }
        
        
    }
    
    
    override func addView() {
        [signinLabel,
         idTextField,
         passwordTextField,
         loginButton,
         signupLabel
        ].forEach{ view.addSubview($0) }
    }
    override func setLayout() {
        signinLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(125)
            $0.leading.equalToSuperview().inset(24)
            $0.height.equalTo(32)
        }
        idTextField.snp.makeConstraints {
            $0.top.equalTo(signinLabel.snp.bottom).offset(15)
            $0.leading.equalToSuperview().inset(24)
            $0.height.equalTo(49)
            $0.width.equalTo(345)
        }
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(15)
            $0.leading.equalToSuperview().inset(24)
            $0.height.equalTo(49)
            $0.width.equalTo(345)
        }
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(24)
            $0.height.equalTo(50)
            $0.width.equalTo(345)
        }
        signupLabel.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(15)
            $0.leading.equalToSuperview().inset(111)
            $0.height.equalTo(17)
        }
        
    }
    
    
}







