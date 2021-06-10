//
//  ProductList+CoreDataProperties.swift
//  ShoppingList
//
//  Created by Felipe Gil on 2021-06-10.
//
//

import Foundation
import CoreData


extension ProductList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductList> {
        return NSFetchRequest<ProductList>(entityName: "ProductList")
    }

    @NSManaged public var productName: String?

}

extension ProductList : Identifiable {

}
