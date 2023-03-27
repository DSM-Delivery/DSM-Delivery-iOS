import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class FoodViewController: BaseViewController {
    private let proFileView = ProFileView().then {
        $0.setShadow(radius: 20)
        $0.layer.cornerRadius = 10
    }

    private let titleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        $0.text = "맛동산 밀기스 부탁드립니다"
        $0.textColor = DSMDeliveryColor.gray600.color
    }
    private let foodNameLabel = UILabel().then {
        $0.text = "간식 이름 : 추억의 맛동산(2), 밀키스(1)"
        $0.textColor = DSMDeliveryColor.gray400.color
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.backgroundColor = DSMDeliveryColor.light.color
    }
    private let contentLabel = UITextView().then {
        $0.text = "맛동산이 요즘 맛있어서 맛동산을 먹어야겠는데 그건 좀 틀딱같은 맛이라 내가 사러 내려가긴 싫은 느낌이라 도와주세요"
        $0.textColor = DSMDeliveryColor.gray400.color
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.backgroundColor = DSMDeliveryColor.light.color
        $0.textAlignment = .left
    }
    private let chatButtonView = ChatButtonView().then {
        $0.setShadow(radius: 20)
    }
    override func addView() {
        [
            proFileView,
            titleLabel,
            foodNameLabel,
            contentLabel,
            chatButtonView
        ].forEach { view.addSubview($0) }
    }
    override func setLayout() {
        proFileView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(80)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(proFileView.snp.bottom).offset(25)
            $0.leading.equalToSuperview().inset(25)
        }
        foodNameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(25)
            $0.top.equalTo(titleLabel.snp.bottom).offset(21)
        }
        contentLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(foodNameLabel.snp.bottom).offset(18)
            $0.bottom.equalTo(chatButtonView.snp.top)
        }
        chatButtonView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(109)
        }
    }
}
