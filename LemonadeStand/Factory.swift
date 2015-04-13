//
//  Factory.swift
//  LemonadeStand
//
//  Created by Sebastian Burek on 12.04.2015.
//  Copyright (c) 2015 Sebastian Burek. All rights reserved.
//

//import Foundation
//import UIKit
//
//class Factory {
//    
//    class func createCustomers() -> [Customer] {
//        var numberOfCustomersToday = (Int(arc4random_uniform(UInt32(9)))) + 1
//        var customers: [Customer] = []
//        for var customerNumber = 0; customerNumber < numberOfCustomersToday; ++customerNumber {
//            var customer = Factory.createCustomer()
//            customers.append(customer)
//        }
//        return customers
//    }
//    
//    class func createCustomer() -> Customer {
//        var customersTaste = CGFloat(arc4random_uniform(UInt32(11))) / 10
//        var customer = Customer(taste: customersTaste)
//        return customer
//    }
//}