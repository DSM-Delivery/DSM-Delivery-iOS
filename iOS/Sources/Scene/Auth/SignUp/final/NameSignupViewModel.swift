import Foundation
import RxCocoa
import RxSwift

class NameSignupViewModel: BaseViewModel {
    let disposeBag = DisposeBag()
    struct Input {
        let userId: String
        let password: String
        let name: PublishRelay<String>
        let number: String
        let sexText: String
        let completButtonDidTap: Signal<Void>
    }
    struct Output {
        let result: PublishRelay<Bool>
    }
    func transform(_ input: Input) -> Output {
        let result = PublishRelay<Bool>()
        let service = Service()
        input.completButtonDidTap
            .asObservable()
            .withLatestFrom(input.name)
            .flatMap { name in
                service.signup(input.userId, input.password, input.number, name, input.sexText, "USER")
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
