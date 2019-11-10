//
//  SynchronizedArray.swift
//  testframework
//
//  Created by Юрий Нориков on 10.11.2019.
//  Copyright © 2019 norikoff. All rights reserved.
//

import Foundation


public class SynchronizedArray<Element> {
    fileprivate let queue = DispatchQueue(label: "com.norikoff.SynchronizedArray", attributes: .concurrent)
    fileprivate var array = [Element]()
}


public extension SynchronizedArray {
    
    
    var count: Int {
        var result = 0
        queue.sync { result = self.array.count }
        return result
    }
    
    var first: Element? {
        var result: Element?
        queue.sync { result = self.array.first }
        return result
    }
    
    /// Adds a new element at the end of the array.
    ///
    /// - Parameter element: The element to append to the array.
    func append( _ element: Element) {
        queue.async(flags: .barrier) {
            self.array.append(element)
        }
    }
    
    /// Removes and returns the element at the specified position.
    ///
    /// - Parameters:
    ///   - index: The position of the element to remove.
    ///   - completion: The handler with the removed element.
    func remove(at index: Int, completion: ((Element) -> Void)? = nil) {
        queue.async(flags: .barrier) {
            let element = self.array.remove(at: index)
            
            DispatchQueue.main.async {
                completion?(element)
            }
        }
    }
    
    /// Removes all elements from the array.
    ///
    /// - Parameter completion: The handler with the removed elements.
    func removeAll(completion: (([Element]) -> Void)? = nil) {
        queue.async(flags: .barrier) {
            let elements = self.array
            self.array.removeAll()
            
            DispatchQueue.main.async {
                completion?(elements)
            }
        }
    }
}

