print("Hello, world!")

var myVariable = 42
myVariable = 50
let myConstant = 42

let implicitInteger = 70
let implicitDouble = 70.0
let explicitDouble: Double = 70

//--------------------------
// Experiment, simple values
let explicitFloat:Float = 4
//--------------------------

let label = "The width is "
let width = 94
let widthLabel = label + String(width)

//--------------------------
// Experiment, simple values
// Removing the String() conversion it says that + cannot be used with int and string
//--------------------------

let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples."
let fruitSummary = "I have \(apples + oranges) pieces of fruit."

//--------------------------
// Experiment, simple values
let hd = 300.5
let ssd:Double = 500
let human = "Luis"
let message = "Hi \(human), in your class there is a total of \(hd+ssd) GBs of secondary memory"
//--------------------------

var shoppingList = ["catfish", "water", "tulips", "blue paint"]
shoppingList[1] = "bottle of water"

var occupations = [
    "Malcolm": "Captain",
    "Kaylee": "Mechanic",
]
occupations["Jayne"] = "Public Relations"

let emptyArray = [String]()
let emptyDictionary = [String: Float]()

shoppingList = []
occupations = [:]

let individualScores = [75, 43, 103, 87, 12]
var teamScore = 0
for score in individualScores {
    if score > 50 {
        teamScore += 3
    } else {
        teamScore += 1
    }
}
print(teamScore)

//--------------------------
// Experiment, control flow
// The greeting is not printed when the string is nil
var optionalString: String? = "Hello"
print(optionalString == nil)

var optionalName: String? = nil
var greeting = "Hello!"
if let name = optionalName {
    greeting = "Hello, \(name)"
} else {
    greeting = "Hello, human"
}
//--------------------------

let nickName: String? = nil
let fullName: String = "John Appleseed"
let informalGreeting = "Hi \(nickName ?? fullName)"

//--------------------------
// Experiment, control flow
// Switch must be exhaustive, consider adding a default case
let vegetable = "red pepper"
switch vegetable {
case "celery":
    print("Add some raisins and make ants on a log.")
case "cucumber", "watercress":
    print("That would make a good tea sandwich.")
case let x where x.hasSuffix("pepper"):
    print("Is it a spicy \(x)?")
default:
    print("Everything tastes good in soup.")
}
//--------------------------


//--------------------------
// Experiment, control flow
let interestingNumbers = [
    "Prime": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Square": [1, 4, 9, 16, 25],
]
var largest = 0
// Add varibable to keep track of the largest type
var type = ""
for (kind, numbers) in interestingNumbers {
    for number in numbers {
        if number > largest {
            largest = number
            type = kind
        }
    }
}
print(type)
print(largest)
//--------------------------

var n = 2
while n < 100 {
    n = n * 2
}
print(n)

var m = 2
repeat {
    m = m * 2
} while m < 100
print(m)

var firstForLoop = 0
for i in 0..<4 {
    firstForLoop += i
}
print(firstForLoop)

var secondForLoop = 0
for var i = 0; i < 4; ++i {
    secondForLoop += i
}
print(secondForLoop)

//--------------------------
//Experiment, functions and closures
// Add lunch special
func greet(name: String, lunch: String) -> String {
    return "Hello \(name), today's special is \(lunch)."
}
greet("Bob", lunch: "soup")
//--------------------------

func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
    var min = scores[0]
    var max = scores[0]
    var sum = 0
    
    for score in scores {
        if score > max {
            max = score
        } else if score < min {
            min = score
        }
        sum += score
    }
    
    return (min, max, sum)
}
let statistics = calculateStatistics([5, 3, 100, 3, 9])
print(statistics.sum)
print(statistics.2)

func sumOf(numbers: Int...) -> Int {
    var sum = 0
    for number in numbers {
        sum += number
    }
    return sum
}
sumOf()
sumOf(42, 597, 12)

//--------------------------
//Experiment, functions and closures
func averageOf(numbers: Int...) -> Int {
    var sum = 0
    for number in numbers {
        sum += number
    }
    let average = sum/numbers.count
    return average
}

averageOf(42, 597, 12)
//--------------------------

func returnFifteen() -> Int {
    var y = 10
    func add() {
        y += 5
    }
    add()
    return y
}
returnFifteen()

func makeIncrementer() -> ((Int) -> Int) {
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    return addOne
}
var increment = makeIncrementer()
increment(7)

func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}
func lessThanTen(number: Int) -> Bool {
    return number < 10
}
var numbers = [20, 19, 7, 12]
hasAnyMatches(numbers, condition: lessThanTen)

numbers.map({
(number: Int) -> Int in
let result = 3 * number
return result
})

//--------------------------
//Experiment, functions and closures
numbers.map({
    (number: Int) -> Int in
    let result = number
    if number%2 == 1 {
        return 0
    } else {
        return result
    }
})
//--------------------------

let mappedNumbers = numbers.map({ number in 3 * number })
print(mappedNumbers)

let sortedNumbers = numbers.sort { $0 > $1 }
print(sortedNumbers)