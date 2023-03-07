import UIKit
import Then
import SnapKit

class RiderMenuView: UIView {
    let firstRiderButton = RiderMenuButton(type: .system)
    let underLineView1 = UIView().then {
        $0.backgroundColor = DSMDeliveryAsset.Color.gray100.color
    }
    let secondRiderButton = RiderMenuButton(type: .system)
    let underLineView2 = UIView().then {
        $0.backgroundColor = DSMDeliveryAsset.Color.gray100.color
    }
    let thridRiderButton = RiderMenuButton(type: .system)
    override func layoutSubviews() {
        self.backgroundColor = DSMDeliveryAsset.Color.light.color
        [
            firstRiderButton,
            underLineView1,
            secondRiderButton,
            underLineView2,
            thridRiderButton
        ].forEach { addSubview($0) }

        firstRiderButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(5)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(45)
        }
        underLineView1.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(firstRiderButton.snp.bottom)
        }
        secondRiderButton.snp.makeConstraints {
            $0.top.equalTo(underLineView1.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(45)
        }
        underLineView2.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(secondRiderButton.snp.bottom)
        }
        thridRiderButton.snp.makeConstraints {
            $0.top.equalTo(underLineView2.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(45)
        }
    }
}
