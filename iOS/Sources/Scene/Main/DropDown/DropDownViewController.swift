import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift

class DropDownViewController: BaseViewController {
    let currentPage = BehaviorRelay<Bool>(value: true)
    let viewModel = DropDownViewModel()
    private let kindLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.text = "종류"
        $0.textColor = .black
    }
    private let firstButton = UIButton(type: .system).then {
        $0.isOff()
    }
    private let firstLabel = UILabel().then {
        $0.text = "택배, 간식"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .black
    }
    private let secondButton = UIButton(type: .system).then {
        $0.isOff()
    }
    private let secondLabel = UILabel().then {
        $0.text = "라이더"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .black
    }
    private let nextButton = UIButton(type: .system).then {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = DSMDeliveryColor.green400.color
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(DSMDeliveryColor.light.color, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }
    override func bind() {
        let input = DropDownViewModel.Input(currentPage: currentPage.asDriver())
        let output = viewModel.transform(input)
        output.currentPage.subscribe(onNext: { [self] in
            if $0 {
                firstButton.isOn()
                secondButton.isOff()
            } else {
                firstButton.isOff()
                secondButton.isOn()
            }
        }).disposed(by: disposeBag)
    }
    override func configureVC() {
        firstButton.rx.tap.subscribe(onNext: {
            self.currentPage.accept(true)
        }).disposed(by: disposeBag)
        secondButton.rx.tap.subscribe(onNext: {
            self.currentPage.accept(false)
        }).disposed(by: disposeBag)
        nextButton.rx.tap.subscribe(onNext: {
            self.dismiss(animated: true)
        }).disposed(by: disposeBag)
    }
    override func addView() {
        [
            kindLabel,
            firstButton,
            firstLabel,
            secondButton,
            secondLabel,
            nextButton
        ].forEach { view.addSubview($0) }
    }
    override func setLayout() {
        kindLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(34)
            $0.top.equalToSuperview().inset(24)
            $0.height.equalTo(28)
        }
        firstButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(34)
            $0.top.equalTo(kindLabel.snp.bottom).offset(25)
            $0.height.width.equalTo(24)
        }
        firstLabel.snp.makeConstraints {
            $0.leading.equalTo(firstButton.snp.trailing).offset(14)
            $0.top.equalTo(kindLabel.snp.bottom).offset(25)
            $0.height.equalTo(24)
        }
        secondButton.snp.makeConstraints {
            $0.leading.equalTo(firstLabel.snp.trailing).offset(41)
            $0.top.equalTo(kindLabel.snp.bottom).offset(25)
            $0.height.width.equalTo(24)
        }
        secondLabel.snp.makeConstraints {
            $0.leading.equalTo(secondButton.snp.trailing).offset(14)
            $0.top.equalTo(kindLabel.snp.bottom).offset(25)
            $0.height.equalTo(24)
        }
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(49)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(50)
        }
    }
}
