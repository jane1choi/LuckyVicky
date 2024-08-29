//
//  DependencyInjector.swift
//  LuckyVicky
//
//  Created by EUNJU on 8/29/24.
//

import Swinject

protocol DependencyAssemblable {
    func assemble(_ assemblyList: [Assembly])
    func register<T>(_ serviceType: T.Type, _ object: T)
}

protocol DependencyResolvable {
    func resolve<T>(_ serviceType: T.Type) -> T
    func resolve<T, Arg>(_ serviceType: T.Type, argument: Arg) -> T
    func resolve<T, Arg1, Arg2>(_ serviceType: T.Type, arguments: Arg1, _ arg2: Arg2) -> T
}

typealias Injector = DependencyAssemblable & DependencyResolvable

final class DependencyInjector: Injector {

    private let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    func assemble(_ assemblyList: [Assembly]) {
        assemblyList.forEach {
            $0.assemble(container: container)
        }
    }
    
    func register<T>(_ serviceType: T.Type, _ object: T) {
        container.register(serviceType) { _ in object }
    }
    
    func resolve<T>(_ serviceType: T.Type) -> T {
        container.resolve(serviceType)!
    }
    
    func resolve<T, Arg>(_ serviceType: T.Type, argument: Arg) -> T {
        container.resolve(serviceType, argument: argument)!
    }
    
    func resolve<T, Arg1, Arg2>(_ serviceType: T.Type, arguments: Arg1, _ arg2: Arg2) -> T {
        container.resolve(serviceType, arguments: arguments, arg2)!
    }
}
