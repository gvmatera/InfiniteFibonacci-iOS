//
//  ViewController.swift
//  Fibonacci
//
//  Created by Gianni Matera on 10/25/16.
//  Copyright © 2016 Gianni Matera. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    var fibonacciCache = Array<UInt>()
    var cellsToDisplay:Int = 15
    var hasDisplayedIntegerOverflowWarning:Bool = false
    var lastAccurateResult:(Int,UInt) = (0,0)
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fibonacciCache.append(0)
        self.fibonacciCache.append(1)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellsToDisplay
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fibonacciCell", for: indexPath) as! FibonacciCell
        let numForLabel = generateFibonacci(i: UInt(indexPath.row))
        cell.fibonacciLabel.text = String(numForLabel)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height {
            self.cellsToDisplay += 15
            self.tableView.reloadData()
        }
    }
    
    // MARK: Helpers
    func generateFibonacci(i:UInt) -> UInt {
        
        if i == 0 || i == 1 {
            return i
        }
        
        if let fibonacci = self.fibonacciCache[safe: Int(i)] {
            return fibonacci
        }
        
        let a = generateFibonacci(i: i - 1)
        let b = generateFibonacci(i: i - 2)
        let sum = UInt.addWithOverflow(a, b)
        self.fibonacciCache.append(sum.0)
        
        if sum.overflow == false {
            if self.lastAccurateResult.1 < sum.0 {
                self.lastAccurateResult = (Int(i), sum.0)
            }
        }
        
        if self.hasDisplayedIntegerOverflowWarning == false && sum.overflow == true {
            self.displayWarning()
        }
        
        return sum.0
    }
    
    func displayWarning() {
        self.hasDisplayedIntegerOverflowWarning = true
        let alertController = UIAlertController(title: "Integer Overflow Warning", message: "The maximum value for a UInt on your system is \(UInt.max). The values calculated are now too large and are inaccurate. Last good result: \(lastAccurateResult.1).", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default))
        self.present(alertController, animated: true, completion: nil)
    }
}

extension Collection {
    subscript (safe index: Index) -> Iterator.Element? {
        return index >= startIndex && index < endIndex ? self[index] : nil
    }
}
