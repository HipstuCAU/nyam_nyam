//
//  Observable.swift
//  NyamNyam
//
//  Created by 박준홍 on 2023/02/28.
//

//import UIKit
//
//public final class CustomObservable<Value> {
//    
//    struct Observer<Value> {
//        weak var observer: AnyObject?
//        let block: (Value) -> Void
//    }
//    
//    private var observers = [Observer<Value>]()
//    
//    public var value: Value {
//        didSet { notifyObservers() }
//    }
//    
//    public init(_ value: Value) {
//        self.value = value
//    }
//    
//    public func observe(on observer: AnyObject, observerBlock: @escaping (Value) -> Void) {
//        observers.append(Observer(observer: observer, block: observerBlock))
//        observerBlock(self.value)
//    }
//    
//    public func remove(observer: AnyObject) {
//        observers = observers.filter { $0.observer !== observer }
//    }
//    
//    private func notifyObservers() {
//        for observer in observers {
//            DispatchQueue.main.async { observer.block(self.value) }
//        }
//    }
//}
