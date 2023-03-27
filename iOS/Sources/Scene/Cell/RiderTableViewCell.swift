import UIKit
import Then
import SnapKit

class RiderTableViewCell: UITableViewCell {

    private let riderUserImageView = UIImageView().then {
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = DSMDeliveryAsset.Color.gray200.color.cgColor
    }
    private let nameLabel = UILabel().then {
        $0.text = "김연우"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        $0.textColor = DSMDeliveryAsset.Color.gray600.color
    }
    private let starImageView = UIImageView().then {
        $0.image = UIImage(systemName: "star.fill")
        $0.tintColor = DSMDeliveryAsset.Color.gray400.color
    }
    private let starLabel = UILabel().then {
        $0.text = "5.0"
        $0.font = UIFont.systemFont(ofSize: 10, weight: .light)
        $0.textColor = DSMDeliveryAsset.Color.gray400.color
    }
    private let priceLabel = UILabel().then {
        $0.text = "1000원"
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textColor = DSMDeliveryAsset.Color.gray600.color
    }
    private let bottomLineView = UIView().then {
        $0.backgroundColor = DSMDeliveryAsset.Color.gray100.color
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.selectionStyle = .none
        self.backgroundColor = DSMDeliveryAsset.Color.light.color
        addView()
        setLayout()
    }

    func addView() {
        [riderUserImageView,
         nameLabel,
         starImageView,
         starLabel,
         priceLabel,
         bottomLineView
        ].forEach { addSubview($0) }
    }
    func setLayout() {
        riderUserImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(10)
            $0.height.width.equalTo(50)
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(25)
            $0.leading.equalTo(riderUserImageView.snp.trailing).offset(15)
        }
        starImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(21)
            $0.trailing.equalTo(starLabel.snp.leading)
            $0.width.height.equalTo(10)
        }
        starLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(21)
            $0.trailing.equalToSuperview().inset(10)
        }
        priceLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(35)
            $0.trailing.equalToSuperview().inset(10)

        }
        bottomLineView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview().inset(65)
            $0.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(1)
        }
    }
}
