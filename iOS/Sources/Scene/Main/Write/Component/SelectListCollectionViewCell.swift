import UIKit
import Then
import SnapKit

class SelectListCollectionViewCell: UICollectionViewCell {
    let objectTitle = UILabel().then {
        $0.text = "밀키스"
        $0.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    }
    let objectPrice = UILabel().then {
        $0.text = "1500원"
        $0.font = UIFont.systemFont(ofSize: 10, weight: .light)
    }
    let shadowView = UIView().then {
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = false
        $0.layer.shadowColor = DSMDeliveryAsset.Color.gray10.color.cgColor
        $0.layer.shadowOpacity = 1
        $0.layer.shadowRadius = 1
        $0.layer.shadowOffset = CGSize(width: 0, height: 10)
        $0.backgroundColor = .systemBackground
    }
    let checkMarkButton = UIButton(type: .system).then {
        $0.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        $0.tintColor = DSMDeliveryAsset.Color.green400.color
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
        $0.layer.borderColor = DSMDeliveryAsset.Color.gray100.color.cgColor
    }
    //    override var isSelected: Bool {
    //        didSet{
    //            if isSelected {
    //                checkMarkButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
    //            }
    //            else {
    //                checkMarkButton.setImage(UIImage(systemName: ""), for: .normal)
    //            }
    //        }
    //    }
    override func layoutSubviews() {
        super.layoutSubviews()
        addView()
        setLayout()
        contentView.layer.cornerRadius = 10
    }
    func addView() {
        [
            shadowView,
            objectTitle,
            objectPrice,
            checkMarkButton
        ].forEach { addSubview($0) }
    }
    func setLayout() {
        shadowView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        objectTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(10)
            $0.height.equalTo(14)
        }
        objectPrice.snp.makeConstraints {
            $0.top.equalTo(objectTitle.snp.bottom).offset(6)
            $0.leading.equalToSuperview().inset(10)
            $0.height.equalTo(10)
        }
        checkMarkButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(13)
            $0.trailing.equalToSuperview().inset(13)
            $0.height.width.equalTo(24)
        }
    }
}
