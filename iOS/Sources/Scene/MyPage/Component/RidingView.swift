import UIKit
import SnapKit
import Then

class RidingView: UIView {
    private let ridingLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        $0.text = "라이딩 요청 내용"
    }
    private let moreButton = UIButton(type: .system).then {
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        $0.setTitle("더보기", for: .normal)
        $0.setTitleColor(DSMDeliveryAsset.Color.gray200.color, for: .normal)
        $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        $0.tintColor = DSMDeliveryAsset.Color.gray200.color
        $0.semanticContentAttribute = .forceRightToLeft
    }
    let ridingTableView = UITableView().then {
        $0.rowHeight = 50
        $0.register(RidingTableViewCell.self, forCellReuseIdentifier: "RidingTableViewCell")
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = DSMDeliveryAsset.Color.light.color
    }
    override func layoutSubviews() {
        self.backgroundColor = DSMDeliveryAsset.Color.light.color
        ridingTableView.delegate = self
        ridingTableView.dataSource = self
        [
            ridingLabel,
            moreButton,
            ridingTableView
        ].forEach { addSubview($0) }

        ridingLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(20)
        }
        moreButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(12)
            $0.width.equalTo(48)
        }
        ridingTableView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(20)
            $0.top.equalTo(ridingLabel.snp.bottom).offset(5)
        }
    }
}

extension RidingView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "RidingTableViewCell",
            for: indexPath) as? RidingTableViewCell else { return UITableViewCell() }
        return cell
    }
}
