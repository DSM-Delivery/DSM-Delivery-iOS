import Foundation
import RxSwift

let disposBag = DisposeBag()
protocol BaseViewModel {
    associatedtype Input
    associatedtype Output
    func transform(_ input: Input) -> Output

}
