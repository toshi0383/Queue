//
//  Queue.swift
//  LGTM
//
//  Created by toshi0383 on 2015/08/29.
//  Copyright © 2015年 toshi0383. All rights reserved.
//
import Darwin

public protocol QueueType {
    associatedtype Element
    mutating func enqueue(_ element: Element)
    mutating func dequeue() -> Element?
}
/// FIFO Queue
public struct Queue<T:Equatable>:QueueType {
    public typealias Element = T
    var queue: [Element]
    var reversed: [Element]
    public mutating func enqueue(_ element: Element) {
        if !self.contains(element) {
            queue.append(element)
        }
    }
    @discardableResult
    public mutating func dequeue() -> Element? {
        if reversed.count == 0 {
            reversed = queue.reversed()
            queue.removeAll(keepingCapacity: true)
        }
        return reversed.popLast()
    }
}

public extension Queue {
    public func reverse() -> Queue<Element> {
        var reversedQueue = Queue<Element>()
        reversedQueue.reversed = queue
        reversedQueue.queue = reversed
        return reversedQueue
    }
}

extension Queue: Collection {
    /// Returns the position immediately after the given index.
    ///
    /// - Parameter i: A valid index of the collection. `i` must be less than
    ///   `endIndex`.
    /// - Returns: The index value immediately after `i`.
    public func index(after i: Int) -> Int {
        return i + 1
    }

    public var startIndex: Int {return 0}
    public var endIndex: Int {
        return count
    }
    public var count: Int {
        return queue.count + reversed.count
    }
    public subscript(position: Int) -> Element {
        guard 0 <= position && position < count else { fatalError("index out of bounds") }
        if position < reversed.count {
            return reversed[reversed.count - 1 - position]
        } else {
            return queue[position - reversed.count]
        }
    }
    public func filter(includeElement: (Element) throws -> Bool) rethrows -> Queue<Element> {
        var resultQueue = Queue<Element>()
        for element in self {
            if try includeElement(element) {
                resultQueue.enqueue(element)
            }
        }
        return resultQueue
    }
}
extension Queue: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Element...) {
        reversed = elements.reversed()
        queue = []
    }
}

extension Queue {
    public init(array: [Element]) {
        reversed = array.reversed()
        queue = []
    }
}

extension Queue: CustomStringConvertible {
    public var description: String {
        return "Queue {\nreversed: \(reversed)\nqueue: \(queue)\n}"
    }
}
extension Queue: RangeReplaceableCollection {
    public init() {
        queue = []
        reversed = []
    }
    public mutating func replaceSubrange<C: Collection>
        (_ subRange: Range<Queue.Index>, with newElements: C) where C.Iterator.Element == Queue.Iterator.Element {
    }
    public mutating func reserveCapacity(_ n: IndexDistance) {
        queue.reserveCapacity(n <= queue.count ? n : 0)
        reversed.reserveCapacity(n - queue.count <= reversed.count ? n : 0)
    }
}
func shuffle<T>(_ array: [T]) -> [T] {

    guard !array.isEmpty else {
        return []
    }

    var result: [T] = []
    var idx = Int(arc4random_uniform(UInt32(array.count - 1)))
    for _ in 1...array.count {
        idx = idx < array.count ? idx : 0
        result.append(array[idx])
        idx += 1
    }
    return result
}
