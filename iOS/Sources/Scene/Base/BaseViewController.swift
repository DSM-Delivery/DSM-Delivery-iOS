import UIKit
import RxSwift
class BaseViewController: UIViewController {
    let bound = UIScreen.main.bounds
    typealias DSMDeliveryColor = DSMDeliveryAsset.Color
    typealias DSMDeliveryImage = DSMDeliveryAsset.Assets
    var disposeBag: DisposeBag = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = DSMDeliveryColor.light.color
        addView()
        setLayout()
        configureVC()
        bind()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

    func addView() {}
    func setLayout() {}
    func configureVC() {}
    func bind() {}
}
