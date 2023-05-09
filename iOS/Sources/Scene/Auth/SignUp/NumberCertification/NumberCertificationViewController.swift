import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

class NumberCertificationViewController: BaseViewController {
    var code = ""
    var id = ""
    var number = ""
    private let viewModel = NumberCertificationViewModel()
    private let signUpLabel = UILabel().then {
        $0.setAuthLabel(text: "Sign up")
    }
    private let detailLabel = UILabel().then {
        $0.text = "입력한 전화번호로 인증번호를 전송했습니다."
        $0.textColor = DSMDeliveryColor.gray400.color
        $0.font = UIFont.systemFont(ofSize: 14, weight: .light)
    }
    private let firsTextField = UITextField().then {
        $0.setNumberTextField(forTextField: $0)
    }
    private let secondTextField = UITextField().then {
        $0.setNumberTextField(forTextField: $0)
    }
    private let thirdTextField = UITextField().then {
        $0.setNumberTextField(forTextField: $0)
    }
    private let fourthTextField = UITextField().then {
        $0.setNumberTextField(forTextField: $0)
    }
    private let nextButton = UIButton(type: .system).then {
        $0.setAuthButton(title: "다음")
    }
    override func bind() {
        let viewController = PasswordCertificationViewController()
        let input = NumberCertificationViewModel.Input(
            firstNumberText: firsTextField.rx.text.orEmpty.asDriver(),
            secondNumberText: secondTextField.rx.text.orEmpty.asDriver(),
            thirdNumberText: thirdTextField.rx.text.orEmpty.asDriver(),
            fourthNumberText: fourthTextField.rx.text.orEmpty.asDriver(),
            nextButtonDidTap: nextButton.rx.tap.asSignal(),
            numberCode: code
        )
        let textValid = viewModel.textValid(input)
        let output = viewModel.transform(input)
        output.result.subscribe(onNext: {
            switch $0 {
            case true:
                print("성공")
                self.navigationController?.pushViewController(viewController, animated: true)
            default:
                print("실패")
            }
        }).disposed(by: disposeBag)
        textValid
            .asObservable()
            .subscribe(onNext: { [unowned self] in
                switch $0 {
                case true:
                    nextButton.backgroundColor = DSMDeliveryColor.primary.color
                case false:
                    nextButton.backgroundColor = DSMDeliveryColor.green200.color
                }
            })
            .disposed(by: disposeBag)
    }
    override func addView() {
        [
            signUpLabel,
            detailLabel,
            firsTextField,
            secondTextField,
            thirdTextField,
            fourthTextField,
            nextButton
        ].forEach { view.addSubview($0) }
    }
    override func setLayout() {
        signUpLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(125)
            $0.leading.equalToSuperview().inset(24)
        }
        detailLabel.snp.makeConstraints {
            $0.top.equalTo(signUpLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(24)
            $0.height.equalTo(14)
        }
        firsTextField.snp.makeConstraints {
            $0.top.equalTo(detailLabel.snp.bottom).offset(36)
            $0.trailing.equalTo(secondTextField.snp.leading).offset(-15)
            $0.height.equalTo(48)
            $0.width.equalTo(45)
        }
        secondTextField.snp.makeConstraints {
            $0.top.equalTo(firsTextField.snp.top)
            $0.centerX.equalToSuperview().offset(-30)
            $0.height.equalTo(48)
            $0.width.equalTo(45)
        }
        thirdTextField.snp.makeConstraints {
            $0.top.equalTo(firsTextField.snp.top)
            $0.leading.equalTo(secondTextField.snp.trailing).offset(15)
            $0.height.equalTo(48)
            $0.width.equalTo(45)
        }
        fourthTextField.snp.makeConstraints {
            $0.top.equalTo(firsTextField.snp.top)
            $0.leading.equalTo(thirdTextField.snp.trailing).offset(15)
            $0.height.equalTo(48)
            $0.width.equalTo(45)
        }
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(45)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(50)
        }
    }
}
