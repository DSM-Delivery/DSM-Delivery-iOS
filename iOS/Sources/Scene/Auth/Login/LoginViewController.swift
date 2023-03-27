import UIKit
import Then
import SnapKit
import Moya
import RxCocoa
import RxSwift

class LoginViewController: BaseViewController {
    private let viewModel = LoginViewModel()
    private let signinLabel = UILabel().then {
        $0.setLabel(text: "Sign in")
    }
    private let idTextField = UITextField().then {
        $0.setTextField(forTextField: $0, placeholder: "아이디")
        $0.addLeftPadding()
    }
    private let passwordTextField = UITextField().then {
        $0.setTextField(forTextField: $0, placeholder: "비밀번호")
        $0.addLeftPadding()
        $0.isSecureTextEntry = true
    }
    private let loginButton = UIButton(type: .system).then {
        $0.setButton(title: "완료")
    }
    private let signupLabel = UILabel().then {
        $0.text = "회원이 아니신가요?"
        $0.textColor = DSMDeliveryColor.gray500.color
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    private let signUpButton = UIButton(type: .system).then {
        $0.setTitle("회원가입", for: .normal)
        $0.setUnderline(start: 0)
        $0.setTitleColor(DSMDeliveryAsset.Color.gray400.color, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    override func configureVC() {
        let signUpViewController = FirstSignUpViewController()
        signUpButton.rx.tap
            .bind {
                self.navigationController?.pushViewController(signUpViewController, animated: true)
            }.disposed(by: disposeBag)
    }
    override func bind() {
        let input = LoginViewModel.Input(
            idText: idTextField.rx.text.orEmpty.asDriver(),
            passwordText: passwordTextField.rx.text.orEmpty.asDriver(),
            loginButtonDidTap: loginButton.rx.tap.asSignal())

        let output = viewModel.transform(input)
        output.result.subscribe(onNext: {
            switch $0 {
            case true:
                self.dismiss(animated: true)
                print("성공")
            case false:
                print("실패")
            }
        }).disposed(by: disposeBag)
    }
    override func addView() {
        [signinLabel,
         idTextField,
         passwordTextField,
         loginButton,
         signupLabel,
         signUpButton
        ].forEach { view.addSubview($0) }
    }
    override func setLayout() {
        signinLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(125)
            $0.leading.equalToSuperview().inset(24)
        }
        idTextField.snp.makeConstraints {
            $0.top.equalTo(signinLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(49)
        }
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(49)
        }
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(50)
        }
        signupLabel.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(15)
            $0.centerX.equalToSuperview().offset(-33)
            $0.height.equalTo(17)
        }
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(signupLabel.snp.top)
            $0.leading.equalTo(signupLabel.snp.trailing).offset(3)
            $0.height.equalTo(17)
        }
    }
}
