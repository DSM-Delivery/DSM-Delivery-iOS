import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class RiderEditViewController: BaseViewController {
    private let ridingView = RidingView().then {
        $0.setShadow(radius: 20)
        $0.layer.cornerRadius = 10
    }
    private let riderMenuView = RiderMenuView().then {
        $0.setShadow(radius: 20)
        $0.layer.cornerRadius = 10
        $0.firstRiderButton.titleTextLabel.text = "라이더 신청하기 | 탈퇴하기"
        $0.secondRiderButton.titleTextLabel.text = "라이딩 요청"
        $0.thridRiderButton.titleTextLabel.text = "배달 내역"
    }
    override func addView() {
        [
            ridingView,
            riderMenuView
        ].forEach { view.addSubview($0) }
    }
    override func setLayout() {
        riderMenuView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(15)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(148)
        }
        ridingView.snp.makeConstraints {
            $0.top.equalTo(riderMenuView.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(252)
        }
    }
}
