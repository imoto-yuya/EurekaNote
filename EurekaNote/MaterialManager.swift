//
//  MaterialManager.swift
//  EurekaNote
//
//  Created by Yuya Imoto on 2018/08/30.
//  Copyright © 2018年 Yuya Imoto. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MaterialManager {
    static let materialManager = MaterialManager()
    private init() {}

    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var list: [Material] = []

    func fetch() {
        let fetchRequest: NSFetchRequest<Material> = Material.fetchRequest()
        do {
            list = try context.fetch(fetchRequest)
        } catch {
            print("Fetching Failed")
        }
    }

    func add(_ contents: String) {
        let material = Material(context: context)
        material.contents = contents
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
}
