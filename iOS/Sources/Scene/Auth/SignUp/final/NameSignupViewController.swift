import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

class NameSignupViewController: BaseViewController {
    var userId = ""
    var sex = ""
    var name = PublishRelay<String>()
    var password = ""
    var number = ""
    let viewModel = NameSignupViewModel()
    private let signUpLabel = UILabel().then {
        $0.setAuthLabel(text: "Sign up")
    }
    private let nameTextField = UITextField().then {
        $0.setTextField(forTextField: $0, placeholder: "이름")
        $0.addLeftPadding()
    }
    private lazy var sexSegmentedControl = UISegmentedControl(items: ["남", "여"]).then {
        $0.selectedSegmentTintColor = DSMDeliveryColor.green200.color
        $0.addTarget(self, action: #selector(genderSelected(_:)), for: .valueChanged)
    }
    private let completeButton = UIButton(type: .system).then {
        $0.setAuthButton(title: "완료")
    }
    @objc func genderSelected(_ sender: UISegmentedControl) {
          let selectedIndex = sender.selectedSegmentIndex
          if selectedIndex == 0 {
              sex = "MALE"
              print(sex)
          } else {
              sex = "FEMALE"
              print(sex)
          }
      }
    override func bind() {
        let input = NameSignupViewModel.Input(
            userId: userId,
            password: password,
            name: name,
            number: number,
            sexText: sex,
            completButtonDidTap: completeButton.rx.tap.asSignal()
        )
        let output = viewModel.transform(input)
        output.result.subscribe(onNext: {
            switch $0 {
            case true:
                print("성공")
            default:
                print("실패")
            }
        })
    }
    override func addView() {
        [
         signUpLabel,
         nameTextField,
         sexSegmentedControl,
         completeButton
        ].forEach { view.addSubview($0) }
    }
    override func setLayout() {
        signUpLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(125)
            $0.leading.equalToSuperview().inset(24)
        }
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(signUpLabel.snp.bottom).offset(15)
            $0.leading.equalToSuperview().inset(24)
            $0.width.equalTo(345)
            $0.height.equalTo(49)
        }
        sexSegmentedControl.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(44)
            $0.width.equalTo(345)
        }
        completeButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(45)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.width.equalTo(345)
            $0.height.equalTo(50)
        }
    }
}
