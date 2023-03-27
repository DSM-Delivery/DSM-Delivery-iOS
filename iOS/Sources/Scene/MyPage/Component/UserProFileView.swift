import UIKit
import SnapKit
import Then

class UserProFileView: UIView {

    private let proFileImageView = UIImageView().then {
        $0.image = .checkmark
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 15
        $0.layer.borderWidth = 1
        $0.layer.borderColor = DSMDeliveryAsset.Color.gray200.color.cgColor
        $0.image = DSMDeliveryAsset.Assets.userBase.image
    }
    private let proFileNameLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        $0.textColor = DSMDeliveryAsset.Color.gray600.color
        $0.text = "김철우"
    }
    private let proFileTermLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        $0.textColor = DSMDeliveryAsset.Color.gray400.color
        $0.text = "라이더가 된지 120일쨰"
    }

    override func layoutSubviews() {
        self.backgroundColor = DSMDeliveryAsset.Color.light.color
        [
            proFileImageView,
            proFileNameLabel,
            proFileTermLabel
        ].forEach { addSubview($0) }

        proFileImageView.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview().inset(10)
            $0.width.equalTo(60)
        }
        proFileNameLabel.snp.makeConstraints {
            $0.leading.equalTo(proFileImageView.snp.trailing).offset(15)
            $0.top.equalToSuperview().inset(23)
        }
        proFileTermLabel.snp.makeConstraints {
            $0.leading.equalTo(proFileImageView.snp.trailing).offset(16)
            $0.top.equalTo(proFileNameLabel.snp.bottom).offset(4)
        }
    }
}
