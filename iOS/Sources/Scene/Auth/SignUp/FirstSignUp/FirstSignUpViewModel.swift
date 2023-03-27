import UIKit
import RxSwift
import RxCocoa

class FirstSignUpViewModel: BaseViewModel {
    private let disposeBag = DisposeBag()
    struct Input {
        let idText: Driver<String>
        let numberText: Driver<String>
        let nextButtonDidTaped: Signal<Void>
    }
    struct Output {
        let result: PublishRelay<Bool>
    }
    func transform(_ input: Input) -> Output {
        let service = Service()
        let result = PublishRelay<Bool>()
        let info = Driver.combineLatest(input.idText, input.numberText)
        input.nextButtonDidTaped
            .asObservable()
            .withLatestFrom(info)
            .flatMap { _, number in
                service.sendNumber(number)
            }.subscribe(onNext: {res in
                switch res {
                case .created:
                    result.accept(true)
                default:
                    result.accept(false)
                }
            }).disposed(by: disposeBag)
            return Output(result: result)
    }
}
