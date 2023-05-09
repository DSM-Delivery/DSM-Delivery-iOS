import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

class PasswordCertificationViewController: BaseViewController {
    //    private let viewMdoel = PasswordCertificationViewModel()
    //    var id: String = ""
    //    var number: String = ""
    //    var passwordText = PublishRelay<String>()
    //    var passwordValidText = PublishRelay<String>()
    private let signupLabel = UILabel().then {
        $0.setAuthLabel(text: "Sign up")
    }
    private let passwordTextField = UITextField().then {
        $0.setTextField(forTextField: $0, placeholder: "비밀번호")
        $0.addLeftPadding()
        $0.isSecureTextEntry = true
    }
    private let passwordValidTextField = UITextField().then {
        $0.setTextField(forTextField: $0, placeholder: "비밀번호 확인")
        $0.addLeftPadding()
        $0.isSecureTextEntry = true
    }
    private let errorLabel = UILabel()
    private let nextButton = UIButton(type: .system).then {
        $0.setAuthButton(title: "다음")
    }
    private func validpassword(mypassword: String) -> Bool {
        let passwordreg =  ("(?=.*[0-9])(?=.*[a-zA-Z]).{8,20}$")
        let passwordtesting = NSPredicate(format: "SELF MATCHES %@", passwordreg)
        return passwordtesting.evaluate(with: mypassword)
    }
    override func configureVC() {
        let viewController = NameSignupViewController()
        passwordTextField.rx.text.orEmpty
            .filter { !$0.isEmpty && $0 ==  self.passwordValidTextField.text}
            .map {self.validpassword(mypassword: $0)}
            .subscribe(onNext: { [unowned self] in
                self.nextButton.isEnabled = $0
                switch $0 {
                case true:
                    nextButton.backgroundColor = DSMDeliveryColor.green400.color
                    nextButton.rx.tap
                        .bind {
                            self.navigationController?.pushViewController(viewController, animated: true)
                        }.disposed(by: disposeBag)
                    viewController.password = passwordTextField.text!
                case false:
                    nextButton.backgroundColor = DSMDeliveryColor.gray100.color
                }
            }).disposed(by: disposeBag)
    }
    //    override func bind() {
    //        let mainViewController = MainViewController()
    //        let input = PasswordCertificationViewModel.Input( passwordText: passwordText,
    //                                                          idText: id,
    //                                                          numberText: number,
    //                                                          completeButtonDidTap: nextButton.rx.tap.asSignal(),
    //                                                          passwordValidText: passwordValidText)
    //        let output = viewMdoel.transform(input)
    //        output.result.subscribe(onNext: {
    //            switch $0 {
    //            case true:
    //                print("성공")
    //                self.navigationController?.pushViewController(mainViewController, animated: true)
    //            case false:
    //                print("실패")
    //            }
    //        }).disposed(by: disposeBag)
    //    }
    override func addView() {
        [
            signupLabel,
            passwordTextField,
            passwordValidTextField,
            nextButton
        ].forEach {view.addSubview($0)}
    }
    override func setLayout() {
        signupLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(125)
            $0.leading.equalToSuperview().inset(24)
        }
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(signupLabel.snp.bottom).offset(15)
            $0.leading.equalToSuperview().inset(24)
            $0.width.equalTo(345)
            $0.height.equalTo(49)
        }
        passwordValidTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(15)
            $0.leading.equalToSuperview().inset(24)
            $0.width.equalTo(345)
            $0.height.equalTo(49)
        }
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(45)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.width.equalTo(345)
            $0.height.equalTo(50)
        }
    }
}
