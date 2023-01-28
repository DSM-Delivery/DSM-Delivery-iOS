import Foundation

protocol BaseViewModel {
    associatedtype Input
    associatedtype Output
    func transform(_ input: Input) -> Output
}
