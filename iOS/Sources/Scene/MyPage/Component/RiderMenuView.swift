import UIKit
import Then
import SnapKit

class RiderMenuView: UIView {
    let riderEditButton = RiderMenuButton(type: .system).then {
        $0.titleTextLabel.text = "라이더 설정"
    }
    let underLineView1 = UIView().then {
        $0.backgroundColor = DSMDeliveryAsset.Color.gray100.color
    }
    let starButton = RiderMenuButton(type: .system).then {
        $0.titleTextLabel.text = "별점주기"
    }
    let underLineView2 = UIView().then {
        $0.backgroundColor = DSMDeliveryAsset.Color.gray100.color
    }
    let controlButton = RiderMenuButton(type: .system).then {
        $0.titleTextLabel.text = "DMS Delivery 환경설정"
    }

    override func layoutSubviews() {
        self.backgroundColor = DSMDeliveryAsset.Color.light.color
        [
            riderEditButton,
            underLineView1,
            starButton,
            underLineView2,
            controlButton
        ].forEach { addSubview($0) }

        riderEditButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(5)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(45)
        }
        underLineView1.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(riderEditButton.snp.bottom)
        }
        starButton.snp.makeConstraints {
            $0.top.equalTo(underLineView1.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(45)
        }
        underLineView2.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(starButton.snp.bottom)
        }
        controlButton.snp.makeConstraints {
            $0.top.equalTo(underLineView2.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(45)
        }
    }
}
