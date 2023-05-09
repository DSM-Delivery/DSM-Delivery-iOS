import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

class FirstSignUpViewController: BaseViewController {
    private let viewModel = FirstSignUpViewModel()
    private let signupLabel = UILabel().then {
        $0.setAuthLabel(text: "Sign up")
    }
    private let idTextField = UITextField().then {
        $0.setTextField(forTextField: $0, placeholder: "아이디")
        $0.addLeftPadding()
    }
    private let numberTextField = UITextField().then {
        $0.setTextField(forTextField: $0, placeholder: "전화번호")
        $0.addLeftPadding()
    }
    private let certificationButton = UIButton(type: .system).then {
        $0.setAuthButton(title: "인증")
    }
    private let nextButton = UIButton(type: .system).then {
        $0.setAuthButton(title: "다음")
    }
    override func bind() {
        let viewController = NumberCertificationViewController()
        let nameViewController = NameSignupViewController()
        let input = FirstSignUpViewModel.Input(idText: idTextField.rx.text.orEmpty.asDriver(),
                                               numberText: numberTextField.rx.text.orEmpty.asDriver(),
                                               certificationButtonDidTaped: certificationButton.rx.tap.asSignal())
        let output = viewModel.transform(input)
        output.result.subscribe(onNext: { [unowned self] in
            switch $0 {
            case true:
                print("번호보냄")
                nameViewController.number = numberTextField.text!
                nameViewController.userId = idTextField.text!
                navigationController?.pushViewController(viewController, animated: true)
            case false:
                print("실패")
            }
        }).disposed(by: disposeBag)
        output.codeNumber.subscribe(onNext: {
            print($0)
            viewController.code = $0
        }).disposed(by: disposeBag)
    }
    override func configureVC() {
        nextButton.rx.tap.bind {
            let viewController = NumberCertificationViewController()
            viewController.code = "1234"
            self.navigationController?.pushViewController(viewController, animated: true)
        }.disposed(by: disposeBag)
    }
    override func addView() {
        [
         signupLabel,
         idTextField,
         numberTextField,
         certificationButton,
         nextButton
        ].forEach { view.addSubview($0) }
    }
    override func setLayout() {
        signupLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(125)
            $0.leading.equalToSuperview().inset(24)
        }
        idTextField.snp.makeConstraints {
            $0.top.equalTo(signupLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(49)
        }
        numberTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(15)
            $0.leading.equalToSuperview().inset(24)
            $0.height.equalTo(49)
        }
        certificationButton.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(15)
            $0.leading.equalTo(numberTextField.snp.trailing).offset(9)
            $0.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(49)
            $0.width.equalTo(76)
        }
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(45)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(50)
        }
    }
}
