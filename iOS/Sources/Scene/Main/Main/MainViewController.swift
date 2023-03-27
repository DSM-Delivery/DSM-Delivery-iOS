import RxSwift
import SnapKit
import Then
import UIKit
import RxCocoa

class MainViewController: BaseViewController {
    let currentPage = BehaviorRelay<Bool>(value: true)
    let writeButton = UIButton().then {
        $0.setImage(DSMDeliveryImage.writeImage.image, for: .normal)
    }
    let chatButton = UIButton().then {
        $0.setImage(DSMDeliveryImage.chatImage.image, for: .normal)
    }
    let userButton = UIButton().then {
        $0.setImage(DSMDeliveryImage.userImage.image, for: .normal)
    }
    private let foodTableView = UITableView().then {
        $0.register(FoodTableViewCell.self, forCellReuseIdentifier: "FoodTableViewCell")
        $0.rowHeight = 100
        $0.separatorStyle = .none
        $0.backgroundColor = DSMDeliveryColor.light.color
        $0.showsVerticalScrollIndicator = false
    }
    private let riderTableView = UITableView().then {
        $0.register(RiderTableViewCell.self, forCellReuseIdentifier: "RiderTableViewCell")
        $0.rowHeight = 70
        $0.separatorStyle = .none
        $0.backgroundColor = DSMDeliveryAsset.Color.light.color
        $0.showsVerticalScrollIndicator = false
    }
    let dropDownButton = UIButton().then {
        $0.setComponent(
            title: "택배, 간식",
            font: UIFont.systemFont(ofSize: 18, weight: .medium),
            image: DSMDeliveryImage.arrowDown.image,
            color: DSMDeliveryAsset.Color.gray600.color)
        $0.semanticContentAttribute = .forceLeftToRight
        $0.imagePadding(padding: 4)
    }
    override func configureVC() {
        foodTableView.dataSource = self
        foodTableView.delegate = self
        riderTableView.dataSource = self
        riderTableView.delegate = self
        userButton.rx.tap.subscribe(onNext: {
            let myPage = MyPageViewController()
            self.navigationController?.pushViewController(myPage, animated: true)
        }).disposed(by: disposeBag)
        dropDownButton.rx.tap
            .subscribe(onNext: {
                let dropDownViewController = DropDownViewController()
                dropDownViewController.currentPage.accept(self.currentPage.value)
                dropDownViewController.viewModel.currentPage.subscribe(onNext: {
                    self.currentPage.accept($0)
                }).disposed(by: self.disposeBag)
                self.presentButtonSheet(nextVC: dropDownViewController, height: 224, radius: 20)
            }).disposed(by: disposeBag)
        currentPage.subscribe(onNext: { currentPage in
            UIView.animate(withDuration: 1, animations: {
                self.foodTableView.isHidden = !currentPage
                self.riderTableView.isHidden = currentPage
            })
            if currentPage {
               self.dropDownButton.setTitle("택배, 간식", for: .normal)
            } else {
                self.dropDownButton.setTitle("라이더", for: .normal)
            }
        }).disposed(by: disposeBag)
    }
    override func addView() {
        let rigthStackView = UIStackView(arrangedSubviews: [writeButton, chatButton, userButton]).then {
            $0.distribution = .equalSpacing
            $0.axis = .horizontal
            $0.alignment = .center
            $0.spacing = 15
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rigthStackView)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: dropDownButton)
        [
            foodTableView,
            riderTableView
        ].forEach { view.addSubview($0) }
    }
    override func setLayout() {
        foodTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(15)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview()
        }
        riderTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(15)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview()
        }
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case foodTableView:
            return 8
        default:
            return 9
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case foodTableView:
            let cell =  foodTableView.dequeueReusableCell(withIdentifier: "FoodTableViewCell", for: indexPath)
            return cell
        default:
            let cell = riderTableView.dequeueReusableCell(withIdentifier: "RiderTableViewCell", for: indexPath)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case foodTableView:
            let foodViewController = FoodViewController()
            self.presentButtonSheet(nextVC: foodViewController, height: 558, radius: 20)
        default:
            let riderViewController = RiderViewController()
            self.presentButtonSheet(nextVC: riderViewController, height: 558, radius: 20)
        }
    }
}
