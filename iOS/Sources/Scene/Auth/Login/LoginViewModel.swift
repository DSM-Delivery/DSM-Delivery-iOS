import Foundation
import RxSwift
import RxCocoa

class LoginViewModel: BaseViewModel {
    private let disposebag = DisposeBag()

    struct Input {
        let idText: Driver<String>
        let passwordText: Driver<String>
        let loginButtonDidTap: Signal<Void>
    }
    struct Output {
        let result: PublishRelay<Bool>
    }

    func transform(_ input: Input) -> Output {
     let service = Service()
        let info = Driver.combineLatest(input.idText, input.passwordText)
           let result = PublishRelay<Bool>()
           input.loginButtonDidTap
               .asObservable()
               .withLatestFrom(info)
               .flatMap { email, password in
                   service.login(email, password)
               }.subscribe(onNext: { res in
                   switch res {
                   case .getOk:
                       result.accept(true)
                   default:
                       result.accept(false)
                   }
               }).disposed(by: disposebag)
           return Output(result: result)
    }
}
