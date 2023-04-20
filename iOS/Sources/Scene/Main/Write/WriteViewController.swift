import UIKit
import Then
import SnapKit
import RxSwift
import Then

class WriteViewController: BaseViewController {
    let titleTextField = UITextField().then {
        $0.setTitleTextField(forTextField: $0, placeholderText: "제목을 입력하세요")
    }
    let titleLineView = UIView().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = DSMDeliveryAsset.Color.gray200.color.cgColor
    }
    let foodButton = UIButton().then {
        $0.setWriteButton(title: "간식", radius: 5, fontSize: 12)
    }
    let deliveryButton = UIButton(type: .system).then {
        $0.setWriteButton(title: "택배", radius: 5, fontSize: 12)
        $0.backgroundColor = DSMDeliveryAsset.Color.gray10.color
        $0.setTitleColor(DSMDeliveryColor.green400.color, for: .normal)
    }
    let foodLineView = UIView().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = DSMDeliveryAsset.Color.gray200.color.cgColor
    }
    let foodNameLabel = UILabel().then {
        $0.setWriteLabel(text: "간식이름 :")
    }
    let selectFoodButton = UIButton(type: .system).then {
        $0.setWriteButton(title: "간식선택하기", radius: 5, fontSize: 12)
    }
    let detailLineView = UIView().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = DSMDeliveryAsset.Color.gray200.color.cgColor
    }
    let detailTextView = UITextView().then {
        $0.setWriteTextView(placeholderText: "내용을 입력하세요")
    }
    let completeButton = UIButton(type: .system).then {
        $0.setWriteButton(title: "확인", radius: 10, fontSize: 12)
        $0.backgroundColor = DSMDeliveryAsset.Color.primary.color
    }
    override func configureVC() {
        let selectListViewController = SelectListCollectionViewController()
        detailTextView.delegate = self
        view.backgroundColor = .systemBackground
        foodButton.rx.tap
            .bind {
                self.foodButton.backgroundColor = DSMDeliveryColor.green400.color
                self.foodButton.setTitleColor(DSMDeliveryColor.gray10.color, for: .normal)
                self.deliveryButton.backgroundColor = DSMDeliveryColor.gray10.color
                self.deliveryButton.setTitleColor(DSMDeliveryColor.green400.color, for: .normal)
                self.foodNameLabel.isHidden = false
                self.detailTextView.isHidden = false
                self.selectFoodButton.isHidden = false
                self.detailLineView.isHidden = false
            }.disposed(by: disposeBag)
        deliveryButton.rx.tap
            .bind {
                self.deliveryButton.backgroundColor = DSMDeliveryColor.green400.color
                self.deliveryButton.setTitleColor(DSMDeliveryColor.gray10.color, for: .normal)
                self.foodButton.backgroundColor = DSMDeliveryColor.gray10.color
                self.foodButton.setTitleColor(DSMDeliveryColor.green400.color, for: .normal)
                self.foodNameLabel.isHidden = true
                self.detailLineView.isHidden = true
                self.selectFoodButton.isHidden = true

            }.disposed(by: disposeBag)
        selectFoodButton.rx.tap
            .bind {
                self.navigationController?.pushViewController(selectListViewController, animated: true)
            }
    }
    override func addView() {
        [
            titleTextField,
            titleLineView,
            foodButton,
            deliveryButton,
            foodLineView,
            foodNameLabel,
            selectFoodButton,
            detailLineView,
            detailTextView,
            completeButton
        ].forEach { view.addSubview($0) }
    }
    override func setLayout() {
        titleTextField.snp.makeConstraints {
            $0.top.equalToSuperview().inset(107)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(23)
        }
        titleLineView.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(1)
        }
        foodButton.snp.makeConstraints {
            $0.top.equalTo(titleLineView.snp.bottom).offset(15)
            $0.leading.equalToSuperview().inset(24)
            $0.height.equalTo(30)
            $0.width.equalTo(68)
        }
        deliveryButton.snp.makeConstraints {
            $0.top.equalTo(foodButton)
            $0.leading.equalTo(foodButton.snp.trailing).offset(10)
            $0.height.equalTo(30)
            $0.width.equalTo(68)
        }
        foodLineView.snp.makeConstraints {
            $0.top.equalTo(foodButton.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(1)
        }
        foodNameLabel.snp.makeConstraints {
            $0.top.equalTo(foodLineView.snp.bottom).offset(25)
            $0.leading.equalToSuperview().inset(24)
            $0.height.equalTo(16)
        }
        selectFoodButton.snp.makeConstraints {
            $0.top.equalTo(foodNameLabel.snp.top)
            $0.leading.equalTo(foodNameLabel.snp.trailing).offset(197)
            $0.trailing.equalToSuperview().inset(24)
            $0.width.equalTo(84)
            $0.height.equalTo(30)
        }
        detailLineView.snp.makeConstraints {
            $0.top.equalTo(foodNameLabel.snp.bottom).offset(21)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(1)
        }
        detailTextView.snp.makeConstraints {
            $0.top.equalTo(detailLineView.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(381)
        }
        completeButton.snp.makeConstraints {
            $0.top.equalTo(detailTextView.snp.bottom).offset(98)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.width.equalTo(345)
            $0.height.equalTo(50)
        }
    }
}
extension WriteViewController: UITextViewDelegate {
    
}
