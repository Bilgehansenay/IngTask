//
//  FavoriteMovieDBItem.swift
//  Ing Task
//
//  Created by Bilgehan Senay on 8.11.2020.
//  Copyright © 2020 Bilgehan Senay. All rights reserved.
//
import UIKit
import RealmSwift


class FavoriteMovieDBItem: Object {
    
    static let realm = try! Realm()
    
    @objc dynamic var id: Int = 0
    @objc dynamic var movieID: Int = 0

    convenience init(movieID: Int) {
        self.init()
        self.id = self.newId()
        self.movieID = movieID
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func add() {
        try! FavoriteMovieDBItem.realm.write({
            FavoriteMovieDBItem.realm.add(self, update: .modified)
        })
    }
    
    
    func readAll() -> [FavoriteMovieDBItem] {
        let tasks = FavoriteMovieDBItem.realm.objects(FavoriteMovieDBItem.self).sorted(byKeyPath: "id", ascending: true)
        var list: [FavoriteMovieDBItem] = []
        
        for task in tasks {
            list.append(task)
        }
        
        return list
    }
    
    
    func update(task: FavoriteMovieDBItem, movieID: Int) {
        try! FavoriteMovieDBItem.realm.write({
            task.movieID = movieID
        })
    }
    
    func delete(id: Int) {
        let task = FavoriteMovieDBItem.realm.objects(FavoriteMovieDBItem.self)[id]

        try! FavoriteMovieDBItem.realm.write({
            FavoriteMovieDBItem.realm.delete(task)
        })
    }
    
    func deleteAll() {
        try! FavoriteMovieDBItem.realm.write({
            FavoriteMovieDBItem.realm.deleteAll()
        })
    }
    
    func newId() -> Int {
        if let last = FavoriteMovieDBItem.realm.objects(FavoriteMovieDBItem.self).last {
            return last.id + 1
        }
        else {
            return 1
        }
    }


}
