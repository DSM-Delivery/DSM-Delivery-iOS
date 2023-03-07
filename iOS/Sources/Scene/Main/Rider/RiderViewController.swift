import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class RiderViewController: BaseViewController {
    private let proFileView = ProFileView().then {
        $0.setShadow(radius: 20)
        $0.layer.cornerRadius = 10
        $0.useCountLabel.text = "★ 5.0"
        $0.nameLabel.text = "김철우"
    }
    private let minPriceLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        $0.text = "라이딩 최소 가격: 500원"
        $0.textColor = DSMDeliveryColor.gray600.color
    }
    private let contentLabel = UITextView().then {
        $0.text = "작은 택배나 간식 배달 : 500원\n큰 택배(생수같은 무거운 택배) : 1,000원 X 물건 개수"
        $0.textColor = DSMDeliveryColor.gray600.color
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
            minPriceLabel,
            contentLabel,
            chatButtonView
        ].forEach { view.addSubview($0) }
    }
    override func setLayout() {
        proFileView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(80)
        }
        minPriceLabel.snp.makeConstraints {
            $0.top.equalTo(proFileView.snp.bottom).offset(25)
            $0.leading.equalToSuperview().inset(25)
        }
        contentLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(minPriceLabel.snp.bottom).offset(18)
            $0.bottom.equalTo(chatButtonView.snp.top)
        }
        chatButtonView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(109)
        }
    }
}
