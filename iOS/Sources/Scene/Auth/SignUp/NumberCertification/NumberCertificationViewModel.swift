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
        let numberCode: String
    }
    struct Output {
        let result: PublishRelay<Bool>
    }
    func transform(_ input: Input) -> Output {
//        let api = Service()
        let result = PublishRelay<Bool>()
        let info = Driver.combineLatest(
            input.firstNumberText,
            input.secondNumberText,
            input.thirdNumberText,
            input.fourthNumberText
        )

        input.nextButtonDidTap.asObservable()
            .withLatestFrom(info)
            .subscribe(onNext: {
                result.accept(input.numberCode == $0+$1+$2+$3)
            }).disposed(by: disposeBag)
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
