import Foundation
import RxSwift
import RxCocoa

class DropDownViewModel: BaseViewModel {
    struct Input {
        let currentPage: Driver<Bool>
    }

    struct Output {
        let currentPage: BehaviorRelay<Bool>
    }

    private var disposeBag = DisposeBag()
    let currentPage = BehaviorRelay<Bool>(value: true)
    func transform(_ input: Input) -> Output {
        input.currentPage.asObservable()
            .subscribe(onNext: {
                self.currentPage.accept($0)
            }).disposed(by: disposeBag)
        return Output(currentPage: currentPage)
    }
}
