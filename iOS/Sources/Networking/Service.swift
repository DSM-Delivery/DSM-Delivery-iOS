import Foundation
import RxSwift
import RxCocoa
import RxMoya
import Moya
// swiftlint:disable line_length
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
    // swiftlint:disable function_parameter_count
    func signup(_ accountId: String, _ password: String, _ phone: String, _ name: String, _ sex: String, _ role: String) -> Single<NetworkingResult> {
        return provider.rx.request(.signup(
            accountId: accountId,
            password: password,
            phone: phone,
            name: name,
            sex: sex,
            role: role
        ))
        .filterSuccessfulStatusCodes()
        .map { _ -> NetworkingResult in
            return .created
        }
        .catch {[unowned self] in return .just(setNetworkError($0))}
    }
    // swiftlint:enabled function_parameter_count
    func refreshToken() -> Single<NetworkingResult> {
        return provider.rx.request(.refreshToken)
            .filterSuccessfulStatusCodes()
            .map(TokenModel.self)
            .map { response -> NetworkingResult in
                Token.accessToken = response.accessToken
                Token.refreshToken = response.refreshToken
                return .getOk
            }
            .catch {[unowned self] in return .just(setNetworkError($0))}
    }
//    func sendNumber() -> Single<(SMSCodeModel, NetworkingResult)> {
//        return provider.rx.request(.sendNumber)
//            .filterSuccessfulStatusCodes()
//            .map(SMSCodeModel.self)
//            .map { return ($0, .getOk) }
//            .catch { error in
//                print(error)
//                return .just((nil, .fault))
//            }
//    }
    func sendNumber(_ number: String) -> Single<(SMSCodeModel?, NetworkingResult)> {
        return provider.rx.request(.sendNumber(number: number))
            .filterSuccessfulStatusCodes()
            .map(SMSCodeModel.self)
            .map { return ($0, .getOk) }
            .catch { error in
                print(error)
                return .just((nil, .fault))
            }
    }
    func requestList() -> Single<(RequestListModel?, NetworkingResult)> {
        return provider.rx.request(.requestList)
            .filterSuccessfulStatusCodes()
            .map(RequestListModel.self)
            .map { return ($0, .getOk) }
            .catch { error in
                print(error)
                return .just((nil, .fault))
            }
    }
    func riderList() -> Single<(RiderListModel?, NetworkingResult)> {
        return provider.rx.request(.riderList)
            .filterSuccessfulStatusCodes()
            .map(RiderListModel.self)
            .map { return ($0, .getOk) }
            .catch { error in
                print(error)
                return .just((nil, .fault))
            }
    }
    func setNetworkError(_ error: Error) -> NetworkingResult {
        print(error)
        print(error.localizedDescription)
        guard let status = (error as? MoyaError)?.response?.statusCode else { return (.fault) }
        return (NetworkingResult(rawValue: status) ?? .fault)
    }
}
// swiftlint:enabled line_length
