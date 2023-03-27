import UIKit
import Then
import SnapKit

class FoodTableViewCell: UITableViewCell {
    private let userImageView = UIImageView().then {
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = DSMDeliveryAsset.Color.gray200.color.cgColor
    }
    private let userLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.text = "양운석"
        $0.textColor = DSMDeliveryAsset.Color.gray600.color
    }
    private let detailLabel = UILabel().then {
        $0.text = "앙앙기모띠"
        $0.font = UIFont.systemFont(ofSize: 10, weight: .light)
        $0.textColor = DSMDeliveryAsset.Color.gray600.color
    }
    private let priceLabel = UILabel().then {
        $0.text = "10,000원"
        $0.textColor = DSMDeliveryAsset.Color.gray600.color
    }
    private let foodLabel = UILabel().then {
        $0.text = "간식"
        $0.font = UIFont.systemFont(ofSize: 10, weight: .light)
        $0.textColor = DSMDeliveryAsset.Color.gray400.color
    }
    private let bottomLine = UIImageView().then {
        $0.backgroundColor = DSMDeliveryAsset.Color.gray100.color
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.selectionStyle = .none
        self.backgroundColor = DSMDeliveryAsset.Color.light.color
        addSubView()
        setLayout()
    }

    func addSubView() {
        [userImageView,
         userLabel,
         detailLabel,
         priceLabel,
         foodLabel,
         bottomLine
        ].forEach {self.addSubview($0)}
    }
    func setLayout() {
        userImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(10)
            $0.height.width.equalTo(80)
        }
        userLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(22)
            $0.leading.equalTo(userImageView.snp.trailing).offset(10)
            $0.height.equalTo(16)
        }
        detailLabel.snp.makeConstraints {
            $0.top.equalTo(userLabel.snp.bottom).offset(8)
            $0.leading.equalTo(userImageView.snp.trailing).offset(10)
            $0.height.equalTo(10)

        }
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(detailLabel.snp.bottom).offset(8)
            $0.leading.equalTo(userImageView.snp.trailing).offset(10)
            $0.height.equalTo(14)
        }
        foodLabel.snp.makeConstraints {
            $0.top.equalTo(detailLabel.snp.bottom).offset(10)
            $0.leading.equalTo(priceLabel.snp.trailing).offset(5)
            $0.height.equalTo(10)
        }
        bottomLine.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview().inset(95)
            $0.width.equalTo(240)
            $0.height.equalTo(1)
        }
    }
}
