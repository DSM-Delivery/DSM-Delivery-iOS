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
        let passwordValidText: PublishRelay<String>
    }
    struct Output {
        let result: PublishRelay<Bool>
    }
    func transform(_ input: Input) -> Output {
        let result = PublishRelay<Bool>()

//        let info = PublishRelay.combineLatest(input.passwordText, input.passwordValidText)
//        input.completeButtonDidTap
//            .asObservable()
//            .withLatestFrom(info)
//            .filter { password, passwordVaildText in
//                return password == passwordVaildText
//            }
//            .subscribe(onNext: { res in
//                switch res {
//                case true:
//                    result.accept(true)
//                default:
//                    result.accept(false)
//                }
//            }).disposed(by: disposeBag)
        return Output(result: result)
    }
}
