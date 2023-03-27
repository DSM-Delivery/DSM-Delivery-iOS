import Foundation
import RxSwift
import RxCocoa

class NumberCertificationViewModel: BaseViewModel {
    let disposeBag = DisposeBag()
    struct Input {
        let firstNumberText: Driver<String>
        let secondNumberText: Driver<String>
        let thirdNumberText: Driver<String>
        let fourthNumberText: Driver<String>
        let nextButtonDidTap: Signal<Void>
        let number: String
    }
    struct Output {
        let result: PublishRelay<Bool>
    }
    func transform(_ input: Input) -> Output {
        let api = Service()
        let result = PublishRelay<Bool>()
        let info = Driver.merge(
            input.firstNumberText,
            input.secondNumberText,
            input.thirdNumberText,
            input.fourthNumberText
        )
        input.nextButtonDidTap
            .asObservable()
            .withLatestFrom(info)
            .flatMap {code in
                api.numberCheck(input.number, code)
            }
            .subscribe(onNext: { res in
                switch res {
                case .getOk:
                    result.accept(true)
                default:
                    result.accept(false)
                }
            })
            .disposed(by: disposeBag)
        return Output(result: result)
    }
    func textVaild() {
    }
}