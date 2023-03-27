import UIKit
import SnapKit
import Then

class RidingTableViewCell: UITableViewCell {
    private let userIamgeView = UIImageView().then {
        $0.layer.cornerRadius = 5
        $0.layer.borderWidth = 1
        $0.layer.borderColor = DSMDeliveryAsset.Color.gray200.color.cgColor
        $0.clipsToBounds = true
        $0.image = DSMDeliveryAsset.Assets.userBase.image
    }
    let userNameLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        $0.text = "양운석"
        $0.textColor = DSMDeliveryAsset.Color.gray600.color
    }
    let contentLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 8, weight: .regular)
        $0.text = "맛동산 밀키스 부탁드립니다."
        $0.textColor = DSMDeliveryAsset.Color.gray500.color
    }
    let kindLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 8, weight: .regular)
        $0.text = "간식"
        $0.textColor = DSMDeliveryAsset.Color.gray400.color
    }
    private let moenyLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        $0.text = "500원"
        $0.textColor = DSMDeliveryAsset.Color.gray600.color
    }

    override func layoutSubviews() {
        self.selectionStyle = .none
        self.backgroundColor = DSMDeliveryAsset.Color.light.color
        [
            userIamgeView,
            userNameLabel,
            contentLabel,
            kindLabel,
            moenyLabel
        ].forEach { addSubview($0) }
        userIamgeView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(10)
            $0.width.equalTo(30)
        }
        userNameLabel.snp.makeConstraints {
            $0.leading.equalTo(userIamgeView.snp.trailing).offset(10)
            $0.top.equalToSuperview().inset(13)
        }
        contentLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(13)
            $0.leading.equalTo(userIamgeView.snp.trailing).offset(10)
        }
        kindLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(13)
            $0.trailing.equalToSuperview()
        }
        moenyLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(13)
            $0.trailing.equalToSuperview()
        }
    }

}
