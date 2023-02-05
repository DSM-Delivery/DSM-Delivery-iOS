import UIKit
import SnapKit
import Then

class MyPageViewController: BaseViewController {
    private let userProFileView = UserProFileView().then {
        $0.setShadow(radius: 20)
        $0.layer.cornerRadius = 25
    }
    private let ridingView = RidingView().then {
        $0.setShadow(radius: 20)
        $0.layer.cornerRadius = 25
    }
    private let riderMenuView = RiderMenuView().then {
        $0.setShadow(radius: 20)
        $0.layer.cornerRadius = 25
    }
    override func addView() {
        [
            userProFileView,
            ridingView,
            riderMenuView
        ].forEach { view.addSubview($0) }
    }
    override func setLayout() {
        userProFileView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(15)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(80)
        }
        ridingView.snp.makeConstraints {
            $0.top.equalTo(userProFileView.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(252)
        }
        riderMenuView.snp.makeConstraints {
            $0.top.equalTo(ridingView.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(148)
        }
    }
}
