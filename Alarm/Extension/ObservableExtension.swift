import Foundation
import RxSwift
import RxCocoa

extension ObservableType {
    public func subscribeService(
        onNext: @escaping ((Self.Element) -> Swift.Void),
        onError: @escaping ((ServiceError) -> Swift.Void),
        onCompleted: (() -> Swift.Void)? = nil ,
        onDisposed: (() -> Swift.Void)? = nil
    ) -> Disposable {
        return subscribe(
            onNext: onNext,
            onError: { error in
                if let customerError = error as? ServiceError {
                    return onError(customerError)
                } else {
                    var error = ServiceError(.unknownError)
                    error.description = "\(error)"
                    return onError(error)
                }
            },
            onCompleted: onCompleted,
            onDisposed: onDisposed
        )
    }
}

extension ObservableConvertibleType {
    public func asDriverIgnoreError() -> RxCocoa.Driver<Self.Element> {
        return self.asDriver(onErrorRecover: { _ in return Driver<Self.Element>.empty() })
    }
}
