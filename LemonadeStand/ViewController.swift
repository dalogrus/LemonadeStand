//
//  ViewController.swift
//  LemonadeStand
//
//  Created by Sebastian Burek on 10.04.2015.
//  Copyright (c) 2015 Sebastian Burek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currentCashLabel: UILabel!
    @IBOutlet weak var lemonsInInventoryLabel: UILabel!
    @IBOutlet weak var iceCubesInInventoryLabel: UILabel!
    @IBOutlet weak var lemonsToPurchaseLabel: UILabel!
    @IBOutlet weak var iceCubesToPurchaseLabel: UILabel!
    @IBOutlet weak var lemonsToMixLabel: UILabel!
    @IBOutlet weak var iceCubesToMixLabel: UILabel!
    
    var cash = 10
    let lemonPrice = 2
    let iceCubePrice = 1
    var lemonInventory = 1
    var iceCubeInventory = 1
    var lemonsToPurchase = 0
    var iceCubesToPurchase = 0
    var lemonsToMix = 0
    var iceCubesToMix = 0
    var todaysLemonadeType:String = ""
    var acidity:Int = 0
    var customers: [Customer] = []
    var lemonadeIs:CGFloat = 0
    
    
//    var lemonadeMixRatio:CGFLOAT = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func purchaseLemonsButtonPressed(sender: AnyObject) {
        
        if cash < 2 {
            println ("Not enough cash.")
            showAlertWithText(message: "Not enough cash!")
        }
        else {
            purchaseLemons()
        }
    }
    @IBAction func unpurchaseLemonsButtonPressed(sender: AnyObject) {
        if lemonInventory < 2 {
            println("You won't be able to make lemonade without lemons.")
            showAlertWithText(message: "You won't be able to make lemonade without lemons.")
        }
        else {
            unpurchaseLemons()
        }
    }
    @IBAction func purchaseIceCubesButtonPressed(sender: AnyObject) {
        if cash < 1 {
            println ("Not enough cash.")
            showAlertWithText(message: "Not enough cash!")
        }
        else {
            purchaseIceCubes()
        }
    }
    @IBAction func unpurchaseIceCubesButtonPressed(sender: AnyObject) {
        if iceCubeInventory < 1 {
            println("No... Noone wants warm acid.")
            showAlertWithText(message: "No... Noone wants warm acid!")
        }
        else {
            unpurchaseIceCubes()
        }
    }
    @IBAction func addLemonsToMixButtonPressed(sender: AnyObject) {
        if lemonInventory < 1 {
            println("You're out of lemons.")
            showAlertWithText(message: "You're out of lemons.")
        }
        else {
           addLemonsToMix()
        }
    }
    @IBAction func removeLemonsFromMixButtonPressed(sender: AnyObject) {
        if lemonsToMix < 1 {
            println("You won't be able to make lemonade without lemons.")
            showAlertWithText(message: "You won't be able to make lemonade without lemons.")
        }
        else {
            removeLemonsFromMix()
        }
    }
    @IBAction func addIceCubesToMixButtonPressed(sender: AnyObject) {
        if iceCubeInventory < 1 {
            println("You're out of Ice Cubes.")
            showAlertWithText(message: "You're out of Ice Cubes.")
        }
        else {
            addIceCubesToMix()
        }
    }
    @IBAction func removeIceCubesFromMixButtonPressed(sender: AnyObject) {
        if iceCubesToMix < 1 {
            println("There are no Ice Cubes in today's brew.")
            showAlertWithText(message: "There are no Ice Cubes in today's brew.")
        }
        else {
            removeIceCubesFromMix()
        }
    }
    @IBAction func startDayButtonPressed(sender: AnyObject) {
        makeLemonade()
        customers = createCustomers()
        for (index, element) in enumerate(customers) {
            if element.taste < 0.4 && lemonadeIs > 1 {
                println("Customer \(index + 1) (\(element.taste)) likes acidic lemonade so get paid $1.")
                cash += 1
                currentCashLabel.text = "$\(cash)"
            }
            else if element.taste < 0.4 && lemonadeIs < 1 {
                println("Customer \(index + 1) (\(element.taste)) likes acidic lemonade so no money made.")
            }
            else if element.taste < 0.4 && lemonadeIs == 1 {
                println("Customer \(index + 1) (\(element.taste)) likes acidic lemonade so no money made.")
            }
            else if element.taste >= 0.4 && element.taste <= 0.6 && lemonadeIs > 1 {
                println("Customer \(index + 1) (\(element.taste)) likes equally portioned lemonade so no money made.")
            }
            else if element.taste >= 0.4 && element.taste <= 0.6 && lemonadeIs < 1 {
                println("Customer \(index + 1) (\(element.taste)) likes equally portioned lemonade so no money made.")
            }
            else if element.taste >= 0.4 && element.taste <= 0.6 && lemonadeIs == 1 {
                println("Customer \(index + 1) (\(element.taste)) likes equally portioned lemonade so get paid $1.")
                cash += 1
                currentCashLabel.text = "$\(cash)"
            }
            else if element.taste > 0.6 && lemonadeIs > 1 {
                println("Customer \(index + 1) (\(element.taste)) likes diluted lemonade so no money made.")
            }
            else if element.taste > 0.6 && lemonadeIs < 1 {
                println("Customer \(index + 1) (\(element.taste)) likes diluted lemonade so get paid $1.")
                cash += 1
                currentCashLabel.text = "$\(cash)"
            }
            else {
                println("Customer \(index + 1) (\(element.taste)) likes diluted lemonade so no money made.")
            }
        }
        if cash < 1 {
            showAlertWithText(header: "Game Over", message: "You ran out of cash :( Press OK to start again.")
            hardReset()
        }
        else if cash < 2 && lemonInventory == 0 {
            showAlertWithText(header: "Game Over", message: "You ran out of cash :( Press OK to start again.")
            hardReset()
        }
        else if cash < 1 && iceCubeInventory == 0 {
            showAlertWithText(header: "Game Over", message: "You ran out of cash :( Press OK to start again.")
            hardReset()
        }
        else if cash < 3 && iceCubeInventory == 0 && lemonInventory == 0 {
            showAlertWithText(header: "Game Over", message: "You ran out of cash :( Press OK to start again.")
            hardReset()
        }
        else {
            softReset()
        }
}
    
    func showAlertWithText (header : String = "Warning", message : String) {
        
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func purchaseLemons() {
        cash -= 2
        lemonInventory += 1
        lemonsToPurchase += 1
        println("\(lemonInventory)")
        lemonsInInventoryLabel.text = "\(lemonInventory) Lemons"
        lemonsToPurchaseLabel.text = "\(lemonsToPurchase)"
        currentCashLabel.text = "$\(cash)"
    }
    
    func unpurchaseLemons() {
        lemonInventory -= 1
        cash += 2
        lemonsToPurchase -= 1
        lemonsInInventoryLabel.text = "\(lemonInventory) Lemons"
        lemonsToPurchaseLabel.text = "\(lemonsToPurchase)"
        currentCashLabel.text = "$\(cash)"
    }
    
    func purchaseIceCubes() {
        cash -= 1
        iceCubeInventory += 1
        iceCubesToPurchase += 1
        iceCubesInInventoryLabel.text = "\(iceCubeInventory) Ice Cubes"
        iceCubesToPurchaseLabel.text = "\(iceCubesToPurchase)"
        currentCashLabel.text = "$\(cash)"
    }
    
    func unpurchaseIceCubes() {
        iceCubeInventory -= 1
        cash += 1
        iceCubesToPurchase -= 1
        iceCubesInInventoryLabel.text = "\(iceCubeInventory) Ice Cubes"
        iceCubesToPurchaseLabel.text = "\(iceCubesToPurchase)"
        currentCashLabel.text = "$\(cash)"
    }
    
    func addLemonsToMix() {
        lemonInventory -= 1
        lemonsToMix += 1
        lemonsToMixLabel.text = "\(lemonsToMix)"
        lemonsInInventoryLabel.text = "\(lemonInventory) Lemons"
        println("\(lemonsToMix)")
    }
    
    func removeLemonsFromMix() {
        lemonInventory += 1
        lemonsToMix -= 1
        lemonsToMixLabel.text = "\(lemonsToMix)"
        lemonsInInventoryLabel.text = "\(lemonInventory) Lemons"
    }
    
    func addIceCubesToMix() {
        iceCubeInventory -= 1
        iceCubesToMix += 1
        iceCubesToMixLabel.text = "\(iceCubesToMix)"
        iceCubesInInventoryLabel.text = "\(iceCubeInventory) Ice Cubes"
        println("\(iceCubesToMix)")
    }
    
    func removeIceCubesFromMix() {
        iceCubeInventory += 1
        iceCubesToMix -= 1
        iceCubesToMixLabel.text = "\(iceCubesToMix)"
        iceCubesInInventoryLabel.text = "\(iceCubeInventory) Ice Cubes"
    }
    
    func makeLemonade () -> CGFloat {
        if lemonsToMix == 0 {
            println("NO ZEROS")
            showAlertWithText(message: "Can't have ZERO lemons in lemonade!")
        }
        else if iceCubesToMix == 0 {
            println("NO ZEROS")
            showAlertWithText(message: "Noone will buy warm acid! Add Ice.")
        }
        else {
            var brewAcidity:CGFloat = CGFloat(lemonsToMix) / CGFloat(iceCubesToMix)
            lemonadeIs = brewAcidity
            if brewAcidity < 1.0 {
                println("Lemonade is diluted today. (\(lemonadeIs))")
            }
            else if brewAcidity > 1.0 {
                println("Lemonade is acidic today. (\(lemonadeIs))")
            }
            else {
                println("Lemonade is equally portioned today. (\(lemonadeIs))")
            }
        }
       return lemonadeIs
    }
    
    func createCustomers() -> [Customer] {
        var numberOfCustomersToday = (Int(arc4random_uniform(UInt32(9)))) + 1
        var customers: [Customer] = []
        for var customerNumber = 0; customerNumber < numberOfCustomersToday; ++customerNumber {
            var customer = createCustomer()
            
            customers.append(customer)
        }
        return customers
    }
    
    func createCustomer() -> Customer {
        var customersTaste = CGFloat(arc4random_uniform(UInt32(11))) / 10
        var customer = Customer(taste: customersTaste)
        return customer
    }
    
    func softReset() {
        lemonsToPurchase = 0
        lemonsToPurchaseLabel.text = "\(lemonsToPurchase)"
        iceCubesToPurchase = 0
        iceCubesToPurchaseLabel.text = "\(iceCubesToPurchase)"
        iceCubesToMix = 0
        iceCubesToMixLabel.text = "\(iceCubesToMix)"
        lemonsToMix = 0
        lemonsToMixLabel.text = "\(lemonsToMix)"
    }
    func hardReset() {
        lemonsToPurchase = 0
        lemonsToPurchaseLabel.text = "\(lemonsToPurchase)"
        iceCubesToPurchase = 0
        iceCubesToPurchaseLabel.text = "\(iceCubesToPurchase)"
        iceCubesToMix = 0
        iceCubesToMixLabel.text = "\(iceCubesToMix)"
        lemonsToMix = 0
        lemonsToMixLabel.text = "\(lemonsToMix)"
        cash = 10
        currentCashLabel.text = "$\(cash)"
        lemonInventory = 1
        lemonsInInventoryLabel.text = "\(lemonInventory) Lemons"
        iceCubeInventory = 1
        iceCubesInInventoryLabel.text = "\(iceCubeInventory) Ice Cubes"
    }
}


