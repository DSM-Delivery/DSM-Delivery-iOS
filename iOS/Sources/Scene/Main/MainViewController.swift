import RxSwift
import SnapKit
import Then
import UIKit
import RxCocoa

class MainViewController: BaseViewController {

    let writeButton = UIButton().then {
        $0.setImage(UIImage(named: "write_image"), for: .normal)
    }
    let chatButton = UIButton().then {
        $0.setImage(UIImage(named: "chat_image"), for: .normal)
    }
    lazy var userButton = UIButton().then {
        $0.setImage(UIImage(named: "user_image"), for: .normal)
    }
    let foodTableView = UITableView().then {
        $0.register(FoodCell.self, forCellReuseIdentifier: "FoodCell")
        $0.rowHeight = 100
        $0.separatorStyle = .none
        $0.backgroundColor = DSMDeliveryColor.light.color
    }
    let riderTableView = RiderTableView()

    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }

    override func configureVC() {
        foodTableView.dataSource = self
        foodTableView.delegate = self
        userButton.rx.tap.subscribe(onNext: {
            let myPage = MyPageViewController()
            self.navigationController?.pushViewController(myPage, animated: true)
        }).disposed(by: disposeBag)
    }
    override func addView() {
        [
            writeButton,
            chatButton,
            userButton,
            foodTableView,
            riderTableView
        ].forEach { view.addSubview($0) }
    }

    override func setLayout() {
        writeButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(68)
            $0.leading.equalToSuperview().inset(267)
            $0.height.width.equalTo(24)
        }
        chatButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(68)
            $0.leading.equalTo(writeButton.snp.trailing).offset(15)
            $0.height.width.equalTo(24)
        }
        userButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(68)
            $0.leading.equalTo(chatButton.snp.trailing).offset(15)
            $0.height.width.equalTo(24)
        }
        foodTableView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(107)
            $0.leading.equalToSuperview().inset(24)
            $0.width.equalTo(345)
            $0.height.equalTo(800)
        }
        riderTableView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(107)
            $0.leading.equalToSuperview().inset(24)
            $0.width.equalTo(345)
            $0.height.equalTo(800)
        }

    }

}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = foodTableView.dequeueReusableCell(withIdentifier: "FoodCell", for: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

}
