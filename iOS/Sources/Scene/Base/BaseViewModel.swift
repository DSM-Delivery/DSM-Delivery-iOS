import Foundation
import RxSwift

protocol BaseViewModel {
    associatedtype Input
    associatedtype Output
    func transform(_ input: Input) -> Output

}
