import Spectre
import Queue

func describeQueue() {
    describe("a queue") {
        var q: Queue<Int> = [0,1,2,3,4]
        $0.it("maintain order of the array literal") {
            try expect(q.dequeue()) == 0
        }
    }
}
