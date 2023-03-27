import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

class FirstSignUpViewController: BaseViewController {
    private let viewModel = FirstSignUpViewModel()
    private let signupLabel = UILabel().then {
        $0.setLabel(text: "Sign up")
    }
    private let idTextField = UITextField().then {
        $0.setTextField(forTextField: $0, placeholder: "아이디")
        $0.addLeftPadding()
    }
    private let numberTextField = UITextField().then {
        $0.setTextField(forTextField: $0, placeholder: "전화번호")
        $0.addLeftPadding()
    }
    private let nextButton = UIButton(type: .system).then {
        $0.setButton(title: "다음")
    }
    override func bind() {
        let viewController = NumberCertificationViewController()
        nextButton.rx.tap
            .bind {
                self.navigationController?.pushViewController(viewController, animated: true)
            }
            .disposed(by: disposeBag)
        let input = FirstSignUpViewModel.Input(idText: idTextField.rx.text.orEmpty.asDriver(),
                                              numberText: numberTextField.rx.text.orEmpty.asDriver(),
                                              nextButtonDidTaped: nextButton.rx.tap.asSignal())
        let output = viewModel.transform(input)
        output.result.subscribe(onNext: { [self] in
            switch $0 {
            case true:
                print("번호보냄")
                viewController.number = numberTextField.text!
                print(viewController.number)
                navigationController?.pushViewController(viewController, animated: true)
            case false:
                print("실패")
            }
        }).disposed(by: disposeBag)
    }
    override func addView() {
        [
         signupLabel,
         idTextField,
         numberTextField,
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
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(49)
        }
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(45)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(50)
        }
    }
}
