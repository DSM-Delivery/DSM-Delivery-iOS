import Foundation
import RxCocoa
import RxSwift

class PasswordCertificationViewModel: BaseViewModel {
    private let disposeBag = DisposeBag()
    struct Input {
        let passwordText: PublishRelay<String>
        let idText: String
        let numberText: String
        let completeButtonDidTap: Signal<Void>
    }
    struct Output {
        let result: PublishRelay<Bool>
    }
    func transform(_ input: Input) -> Output {
        let api = Service()
        let result = PublishRelay<Bool>()
        let info = input.passwordText
        input.completeButtonDidTap
            .asObservable()
            .withLatestFrom(info)
            .flatMap { passwordText in
                api.signup(input.idText, passwordText, input.numberText)
            }.subscribe(onNext: { res in
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
