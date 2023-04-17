import RxSwift
import SnapKit
import Then
import UIKit
import RxCocoa
import Kingfisher

class MainViewController: BaseViewController {
    let viewmodel = MainViewModel()
    private let refreshToken = PublishRelay<Void>()
    private let requestList = PublishRelay<Void>()
    private let riderList = PublishRelay<Void>()
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
    override func viewWillAppear(_ animated: Bool) {
        self.riderList.accept(())
        self.requestList.accept(())
    }
    override func bind() {
        let input = MainViewModel.Input(refreshToken: refreshToken,
                                        requestList: requestList,
                                        riderList: riderList)
        let output = viewmodel.transform(input)
        output.result.subscribe(onNext: {
            switch $0 {
            case true:
                print("성공")
            default:
                let viewcontroller = LoginViewController()
                viewcontroller.modalPresentationStyle = .fullScreen
                self.present(viewcontroller, animated: true)
            }
        }).disposed(by: disposeBag)
        output.requsetList.bind(to: foodTableView.rx.items(
            cellIdentifier: "FoodTableViewCell",
            cellType: FoodTableViewCell.self)) { _, item, cell in
                let url = URL(string: item.profileImg)
                cell.userImageView.kf.setImage(with: url)
                cell.titleLabel.text = item.title
                cell.userLabel.text = item.userName
                cell.foodLabel.text = item.productType
            }.disposed(by: disposeBag)

        output.riderList.bind(to: riderTableView.rx.items(
            cellIdentifier: "RiderTableViewCell",
            cellType: RiderTableViewCell.self)) { _, item, cell in
                let url = URL(string: item.profileImg)
                cell.riderUserImageView.kf.setImage(with: url)
                cell.starLabel.text = "\(item.star)"
                cell.nameLabel.text = item.userName
                cell.priceLabel.text = item.cost
            }.disposed(by: disposeBag)
    }
    override func configureVC() {
        let writeViewController = WriteViewController()
        foodTableView.delegate = self
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
        writeButton.rx.tap
            .bind {
                self.navigationController?.pushViewController(writeViewController, animated: true)
            }.disposed(by: disposeBag)
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

extension MainViewController: UITableViewDelegate {
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
