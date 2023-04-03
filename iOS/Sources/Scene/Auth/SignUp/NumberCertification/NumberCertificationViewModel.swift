import Foundation
import RxSwift
import RxCocoa

class NumberCertificationViewModel: BaseViewModel {
    private let disposeBag = DisposeBag()
    struct Input {
        let firstNumberText: Driver<String>
        let secondNumberText: Driver<String>
        let thirdNumberText: Driver<String>
        let fourthNumberText: Driver<String>
        let nextButtonDidTap: Signal<Void>
        let number: String
        let id: String
    }
    struct Output {
        let result: PublishRelay<Bool>
    }
    func transform(_ input: Input) -> Output {
        let api = Service()
        let result = PublishRelay<Bool>()
        let info = Driver.combineLatest(
            input.firstNumberText,
            input.secondNumberText,
            input.thirdNumberText,
            input.fourthNumberText
        )
        input.nextButtonDidTap
            .asObservable()
            .withLatestFrom(info)
            .flatMap { first, second, third, fourth in
                api.numberCheck(input.number, first+second+third+fourth)
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
    func textValid(_ input: Input) -> Driver<Bool> {
        return Driver.combineLatest(
            input.firstNumberText,
            input.secondNumberText,
            input.thirdNumberText,
            input.fourthNumberText
        )
        .map { $0.0.count == 1 && $0.1.count == 1 && $0.2.count == 1 && $0.3.count == 1 }
    }
}
