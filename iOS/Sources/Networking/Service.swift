import Foundation
import RxSwift
import RxCocoa
import RxMoya
import Moya

final class Service {
    let provider = MoyaProvider<API>(plugins: [MoyaLoggingPlugin()])
    func login(_ accountId: String, _ password: String ) -> Single<NetworkingResult> {
        return provider.rx.request(.login(accountId: accountId, password: password ))
            .filterSuccessfulStatusCodes()
            .map(TokenModel.self)
            .map {response -> NetworkingResult in
                Token.accessToken = response.accessToken
                Token.refreshToken = response.refreshToken
                return .getOk
            }
            .catch {[unowned self] in return .just(setNetworkError($0))}
    }
    func signup(_ accountId: String, _ password: String, _ phone: String) -> Single<NetworkingResult> {
            return provider.rx.request(.signup(
                accountId: accountId,
                password: password,
                phone: phone
            ))
            .filterSuccessfulStatusCodes()
            .map { _ -> NetworkingResult in
                return .created
            }
            .catch {[unowned self] in return .just(setNetworkError($0))}
    }
    func sendNumber(_ number: String) -> Single<NetworkingResult> {
        return provider.rx.request(.sendNumber(number: number))
            .filterSuccessfulStatusCodes()
            .map { _ -> NetworkingResult in
                return .created
            }
    }
    func numberCheck(_ number: String, _ numberCode: String) -> Single<NetworkingResult> {
        return provider.rx.request(.numberCheck(number: number, numberCode: numberCode))
            .filterSuccessfulStatusCodes()
            .map { _ -> NetworkingResult in
                return .created
            }
            .catch {[unowned self] in return .just(setNetworkError($0))}
    }
    func setNetworkError(_ error: Error) -> NetworkingResult {
        print(error)
        print(error.localizedDescription)
        guard let status = (error as? MoyaError)?.response?.statusCode else { return (.fault) }
        return (NetworkingResult(rawValue: status) ?? .fault)
    }
}
