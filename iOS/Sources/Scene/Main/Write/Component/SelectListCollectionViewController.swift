import UIKit
import Then
import SnapKit
import RxCocoa
import RxSwift

class SelectListCollectionViewController: BaseViewController {
    private let selectListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 345, height: 50)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 15
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(SelectListCollectionViewCell.self, forCellWithReuseIdentifier: "SelectListCollectionViewCell")
        view.backgroundColor = .systemBackground
        return view
    }()
    let sumView = UIView().then {
        $0.setShadow(radius: 10)
        $0.backgroundColor = .systemBackground
    }
    let sumLabel = UILabel().then {
        $0.text = "합계 2,500원"
        $0.font = UIFont.systemFont(ofSize: 18, weight: .light)
    }
    let completeButton = UIButton(type: .system).then {
        $0.setWriteButton(title: "완료", radius: 10, fontSize: 14)
    }
    override func configureVC() {
        selectListCollectionView.delegate = self
        selectListCollectionView.dataSource = self
        view.backgroundColor = .systemBackground
    }
    override func addView() {
        [
         selectListCollectionView,
         sumView,
         sumLabel,
         completeButton
        ].forEach { view.addSubview($0) }
    }
    override func setLayout() {
        selectListCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(99)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(570)
        }
        sumView.snp.makeConstraints {
            $0.top.equalTo(selectListCollectionView.snp.bottom).offset(74)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(109)
        }
        sumLabel.snp.makeConstraints {
            $0.top.equalTo(sumView.snp.top).offset(28)
            $0.leading.equalToSuperview().inset(24)
            $0.height.equalTo(18)
        }
        completeButton.snp.makeConstraints {
            $0.top.equalTo(sumView.snp.top).offset(15)
            $0.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(45)
            $0.width.equalTo(106)
        }
    }
}
extension SelectListCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          let width = collectionView.frame.width / 1 ///  3등분하여 배치, 옆 간격이 1이므로 1을 빼줌
          let size = CGSize(width: width, height: width)
          return size
      }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = selectListCollectionView.dequeueReusableCell(withReuseIdentifier: "SelectListCollectionViewCell", for: indexPath)
        return cell
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = selectListCollectionView.dequeueReusableCell(withReuseIdentifier: "SelectListCollectionViewCell", for: indexPath)        
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? SelectListCollectionViewCell else {return}
        
        func updateLabel() {
            // 선택된 셀의 가격이 있으면 라벨에 표시, 없으면 빈 문자열로 표시
            if let price = selectedPrice {
                sumLabel.text = price
            } else {
                sumLabel.text = ""
            }
        }

    }
}
