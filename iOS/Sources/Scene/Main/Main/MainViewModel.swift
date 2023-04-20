import Foundation
import RxCocoa
import RxSwift

class MainViewModel: BaseViewModel {
    private let disposeBag = DisposeBag()
    struct Input {
        let refreshToken: PublishRelay<Void>
        let requestList: PublishRelay<Void>
        let riderList: PublishRelay<Void>
    }
    struct Output {
        let result: PublishRelay<Bool>
        let requsetList: BehaviorRelay<[PostList]>
        let riderList: BehaviorRelay<[RiderList]>
    }
    func transform(_ input: Input) -> Output {
        let api = Service()
        let result = PublishRelay<Bool>()
        let requestList = BehaviorRelay<[PostList]>(value: [])
        let riderList = BehaviorRelay<[RiderList]>(value: [])
        input.refreshToken.asObservable()
            .flatMap { api.refreshToken() }
            .subscribe(onNext: { res in
                switch res {
                case .getOk:
                    result.accept(true)
                default:
                    result.accept(false)
                }
            }).disposed(by: disposeBag)
        input.requestList.asObservable()
            .flatMap { api.requestList() }
            .subscribe(onNext: { data, res in
                switch res {
                case .getOk:
                    requestList.accept(data!.postList)
                default:
                    return
                }
            }).disposed(by: disposeBag)
        input.riderList.asObservable()
            .flatMap { api.riderList() }
            .subscribe(onNext: { data, res in
                switch res {
                case .getOk:
                    riderList.accept(data!.riderList)
                default:
                    return
                }
            }).disposed(by: disposeBag)
        return Output(result: result, requsetList: requestList, riderList: riderList)
    }
}
