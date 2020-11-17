//
//  RealmWorker.swift
//  EhHoFinal
//
//  Created by Javier Laguna on 17/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import RealmSwift

protocol RealmWorkerDelegate: class {
    func realmWorkerHasChanged()
}

final class RealmWorker {
    var realm: Realm!
    private var delegates = [RealmWorkerDelegate]()
    
    // MARK: Object lifecycle
    
    static let shared = RealmWorker()
    
    private init() {}
    
    // MARK: Observer delegates
    
    func addDelegate(delegate: RealmWorkerDelegate) {
        if indexOfDelegate(delegate: delegate) == nil {
            delegates.append(delegate)
        }
    }
    
    func removeDelegate(delegate: RealmWorkerDelegate) {
        if let index = indexOfDelegate(delegate: delegate) {
            delegates.remove(at: index)
        }
    }
    
    private func indexOfDelegate(delegate: RealmWorkerDelegate) -> Int? {
        return delegates.firstIndex(where: { $0 === delegate })
    }
    
    // MARK: Setup
    
    func setupRealm() {
        configure()
    }
    
    func setupRealm(inMemoryIdentifier: String) {
        configure(inMemoryIdentifier: inMemoryIdentifier)
    }
    
    // MARK: Private
    
    private func configure() {
        realm = try! Realm()
    }
    
    private func configure(inMemoryIdentifier: String) {
        realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: inMemoryIdentifier))
    }
    
    private func clear() {
        try! realm.write {
            realm.deleteAll()
        }
    }
}
