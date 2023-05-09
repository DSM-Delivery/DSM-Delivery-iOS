import UIKit
import RxSwift
import RxCocoa

class FirstSignUpViewModel: BaseViewModel {
    private let disposeBag = DisposeBag()
    struct Input {
        let idText: Driver<String>
        let numberText: Driver<String>
        let certificationButtonDidTaped: Signal<Void>
    }
    struct Output {
        let result: PublishRelay<Bool>
        let codeNumber: PublishRelay<String>
    }
    func transform(_ input: Input) -> Output {
        let service = Service()
        let result = PublishRelay<Bool>()
        let codeNumber = PublishRelay<String>()
        let info = Driver.combineLatest(input.idText, input.numberText)
        print(input.numberText)
        input.certificationButtonDidTaped
            .asObservable()
            .withLatestFrom(info)
            .flatMap { _, number in
                service.sendNumber(number)
            }.subscribe(onNext: { code, res in
                switch res {
                case .getOk:
                    result.accept(true)
                    codeNumber.accept(code?.code ?? "")
                default:
                    result.accept(false)
                }
            }).disposed(by: disposeBag)
            return Output(result: result, codeNumber: codeNumber)
    }
}
