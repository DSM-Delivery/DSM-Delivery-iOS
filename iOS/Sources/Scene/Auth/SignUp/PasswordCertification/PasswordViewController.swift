import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

class PasswordCertificationViewController: BaseViewController {
    private let viewMdoel = PasswordCertificationViewModel()
    var id: String = ""
    var number: String = ""
    var passwordText = PublishRelay<String>()
    private let signupLabel = UILabel().then {
        $0.setLabel(text: "Sign up")
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
    private let completeButton = UIButton(type: .system).then {
        $0.setButton(title: "완료")
    }
    override func configureVC() {
        let mainViewController = MainViewController()
        completeButton.rx.tap
            .bind {
                self.navigationController?.pushViewController(mainViewController, animated: true)
            }.disposed(by: disposeBag)
    }
    override func bind() {
        let input = PasswordCertificationViewModel.Input( passwordText: passwordText,
                                                          idText: id,
                                                          numberText: number,
                                                          completeButtonDidTap: completeButton.rx.tap.asSignal())
        let output = viewMdoel.transform(input)
        output.result.subscribe(onNext: {
            switch $0 {
            case true:
                print("성공")
                self.dismiss(animated: true)
            case false:
                print("실패")
            }
        }).disposed(by: disposeBag)
    }
    override func addView() {
        [
            signupLabel,
            passwordTextField,
            passwordValidTextField,
            completeButton
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
        completeButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(45)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.width.equalTo(345)
            $0.height.equalTo(50)
        }
    }
}
