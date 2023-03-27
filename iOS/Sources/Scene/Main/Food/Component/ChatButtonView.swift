import UIKit
import SnapKit
import Then

class ChatButtonView: UIView {
    let payLabel = UILabel().then {
        $0.textColor = DSMDeliveryAsset.Color.gray600.color
        $0.text = "1,000원"
        $0.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    }
    let userStateLabel = UILabel().then {
        $0.textColor = DSMDeliveryAsset.Color.gray400.color
        $0.text = "인증된사용자"
        $0.font = UIFont.systemFont(ofSize: 10, weight: .regular)
    }
    let chatButton = UIButton(type: .system).then {
        $0.setComponent(
            title: "채팅하기",
            font: UIFont.systemFont(ofSize: 14, weight: .regular),
            image: nil,
            color: DSMDeliveryAsset.Color.light.color
        )
        $0.backgroundColor = DSMDeliveryAsset.Color.green400.color
        $0.layer.cornerRadius = 10
    }

    override func layoutSubviews() {
        self.backgroundColor = DSMDeliveryAsset.Color.light.color
        [
            payLabel,
            userStateLabel,
            chatButton
        ].forEach { addSubview($0) }
        payLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(28)
        }
        userStateLabel.snp.makeConstraints {
            $0.leading.equalTo(payLabel.snp.trailing).offset(5)
            $0.top.equalToSuperview().inset(35)
        }
        chatButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(15)
            $0.width.equalTo(129)
            $0.height.equalTo(45)
        }
    }
}
