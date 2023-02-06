import SnapKit
import Then
import UIKit

class RiderTableView: UIView, UITableViewDataSource, UITableViewDelegate {

    let riderTableView = UITableView().then {
        $0.register(RiderCell.self, forCellReuseIdentifier: "RiderCell")
        $0.rowHeight = 70
        $0.separatorStyle = .none
        $0.backgroundColor = DSMDeliveryAsset.Color.light.color
    }
    override func layoutSubviews() {
        self.backgroundColor = DSMDeliveryAsset.Color.light.color
        self.addSubview(riderTableView)
        riderTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        riderTableView.delegate = self
        riderTableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = riderTableView.dequeueReusableCell(withIdentifier: "RiderCell", for: indexPath)
        return cell
    }
}
