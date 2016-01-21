import Spectre
import Queue

func describeQueue() {
	describe("a queue") {
		var q: Queue<Int> = [1,2,3,4]
		$0.it("has count of 4") {
			try expect(q.count) == 4
		}
		$0.it("maintain order of the array literal") {
			try expect(q.dequeue()) == 1
			try expect(q.dequeue()) == 2
			try expect(q.dequeue()) == 3
			try expect(q.dequeue()) == 4
		}
		$0.it("dequeue()ing empty Queue returns Optional.None (aka nil)") {
			try expect(q.dequeue()) == nil
		}
		$0.it("now has count of 0") {
			try expect(q.count) == 0
		}
		$0.it("is now empty") {
			try expect(q.isEmpty) == true
		}
	}
	describe("complex enqueue and dequeue") {
		var q: Queue<Int> = [1, 2]
		q.enqueue(5)
		q.enqueue(6)
		$0.it("complex enqueue and dequeue check") {
			try expect(q.count) == 4
			try expect(q.dequeue()) == 1
			try expect(q.dequeue()) == 2
			try expect(q.dequeue()) == 5
			q.enqueue(7)
			q.enqueue(8)
			try expect(q.dequeue()) == 6
			try expect(q.dequeue()) == 7
			q.enqueue(9)
			try expect(q.dequeue()) == 8
			try expect(q.dequeue()) == 9
			try expect(q.isEmpty) == true
		}
	}
	describe("subscript") {
		var q: Queue<String> = ["a", "b", "c"]
		$0.it("elements can be retrieved using subscript") {
			try expect(q[0]) == "a"
			try expect(q[1]) == "b"
			try expect(q[2]) == "c"
		}
		q.enqueue("d")
		q.enqueue("e")
		$0.it("elements can be retrieved using subscript after enqueueing") {
			try expect(q[3]) == "d"
			try expect(q[4]) == "e"
		}
		q.dequeue() // pop "a"
		$0.it("elements can be retrieved using subscript after dequeueing") {
			try expect(q[0]) == "b"
			try expect(q[1]) == "c"
			try expect(q[2]) == "d"
			try expect(q[3]) == "e"
		}
	}
}
