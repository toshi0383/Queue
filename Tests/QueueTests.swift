let test = TAP(tests:8+9+9)
func testAll() {
    testSimpleDequeue()
    testComplexQueueing()
    testSubscript()
    test.done()
}
func testSimpleDequeue() {
    var q: Queue<Int> = [1,2,3,4]
    test.eq(q.count, 4)
    test.eq(q.dequeue(), 1, "q.dequeue() == 1")
    test.eq(q.dequeue(), 2, "q.dequeue() == 2")
    test.eq(q.dequeue(), 3, "q.dequeue() == 3")
    test.eq(q.dequeue(), 4, "q.dequeue() == 4")
    test.eq(q.dequeue(), nil, "q.dequeue() == nil")
    test.eq(q.count, 0, "q.count == 0")
    test.ok(q.isEmpty, "q.isEmpty")
}

func testComplexQueueing() {
    var q: Queue<Int> = [1, 2]
    q.enqueue(5)
    q.enqueue(6)
    test.eq(q.count, 4, "q.count == 4")
    test.eq(q.dequeue(), 1, "q.dequeue() == 1")
    test.eq(q.dequeue(), 2, "q.dequeue() == 2")
    test.eq(q.dequeue(), 5, "q.dequeue() == 5")
    q.enqueue(7)
    q.enqueue(8)
    test.eq(q.dequeue(), 6, "q.dequeue() == 6")
    test.eq(q.dequeue(), 7, "q.dequeue() == 7")
    q.enqueue(9)
    test.eq(q.dequeue(), 8, "q.dequeue() == 8")
    test.eq(q.dequeue(), 9, "q.dequeue() == 9")
    test.ok(q.isEmpty)
}

func testSubscript() {
    var q: Queue<String> = ["a", "b", "c"]
    test.eq(q[0], "a", "q[0] == \"a\"")
    test.eq(q[1], "b", "q[1] == \"b\"")
    test.eq(q[2], "c", "q[2] == \"c\"")
    q.enqueue("d")
    q.enqueue("e")
    test.eq(q[3], "d", "q[1] == \"d\"")
    test.eq(q[4], "e", "q[1] == \"e\"")
    _ = q.dequeue() // pop "a"
    test.eq(q[0], "b", "q[1] == \"b\"")
    test.eq(q[1], "c", "q[1] == \"c\"")
    test.eq(q[2], "d", "q[1] == \"d\"")
    test.eq(q[3], "e", "q[1] == \"d\"")
}
