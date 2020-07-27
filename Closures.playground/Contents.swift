import UIKit

//MARK: - Closures

/// 1. Closure는 변수나 상수가 선언된 위치에서 참조를 획득하고 저장할 수 있다
///   어려운 말 같으니 있다가 이해해 보자 > 이제는 이해 됨
/// 2. 함수는 클로저의 일종이다
/// 3. 세가지 형태를 한번 이해해보도록 하자 :
///     (1) 이름이 있으면서 어떤 값도 획득하지 않는 전역함수
///     (2) 이름이 있으면서 다른 함수 내부의 값을 획득할 수 있는 중첩함수의 형태
///     (3) 이름이 없고 주변 문맥에 따라 값을 획득할 수 있는 축약 문법인 상태
/// 4. 기본 클로저와 후행 클로저가 있는데 후행 클로저는 스위프트가 제공하는 기본구성 클로저인듯
/// 5. 클로저는 참조 타입


let names: [String] = ["승호","야곰","제니"]
let reversed: [String] = names.sorted { $0 > $1 }
let reversedComplex: [String] = names.sorted (by: { (first: String, second: String) -> Bool in
    return first > second
})
/// 선행 클로저는 후행 클로저에 비해 뭔가가 덜 깔끔
/// 후행 클로저는 내부 실행문이 단 한줄일 때 그 실행문이 리턴 값
    
print(reversedComplex)
print(reversed)
// 충격 : 한글 소팅이 됨


func makeIncrementer (forIncrement amount: Int) -> (() -> Int) {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

let incrementByTwo: (() -> Int) = makeIncrementer(forIncrement: 2)
let first: Int = incrementByTwo()
let second: Int = incrementByTwo()
/// 충격충격 클로저에 값 저장이 된다 이말이자나
/// 함수나 클로저를 상수나 변수에 할당할 때 마다 사실은 상수나 변수에 함수나 클로저의 참조를 설정하는 것
/// 클로저의 참조를 다른 상수에 할당해준다면 두 상수가 모두 같은 클로저를 가리키는 것 (위에서의 first, second에서 증명)
/// 따라서 클로저는 참조 타입

// MARK: - Escaping Closure
/// 함수가 작업을 종료하고 난 이후 (return 이후)에 컴플리션 핸들러, 즉 클로저를 호출하기 때문에 클로저는 함수를 탈출 해 있어야함
/// 그 클로저를 저장할 수 있는 함수 외부에 배열 변수가 있담
/// @escaping 키워드로 탈출클로저임을 명시한 이후에는 self 선언을 계속 해조야 해

var completionHandlers: [() -> Void] = []

func someFunctionWithEscapingClosure(completionHandler: @escaping ()-> Void) {
    completionHandlers.append(completionHandler)
}

typealias VoidVoidClosure = () -> Void
let firstClosure: VoidVoidClosure = {
    print("Closure A")
}

let secondClosure: VoidVoidClosure = {
    print("Closure B")
}

func returnOneClosure(first: @escaping VoidVoidClosure, second: @escaping VoidVoidClosure, shoudReturnFirstClosure: Bool) -> VoidVoidClosure {
    return shoudReturnFirstClosure ? first : second
}

let returnClosure: VoidVoidClosure = returnOneClosure(first: firstClosure, second: secondClosure, shoudReturnFirstClosure: true)
returnClosure()
var closures: [VoidVoidClosure] = []

func appendClosure(closure: @escaping VoidVoidClosure) {
    closures.append(contentsOf: closures)
}


//MARK:- withoutActuallyEscaping
//lazy 키워드가 있습니다 와아

//func hasElements(in array: [Int], match predicate: (Int) -> Bool) -> Bool {
//    return (array.lazy.filter { predicate($0)}.isEmpty == false )
//}

func hasElements(in array: [Int], match predicate: (Int) -> Bool) -> Bool {
    return withoutActuallyEscaping(predicate, do: { escapablePredicate in
        return ( array.lazy.filter { escapablePredicate($0)}.isEmpty == false )
        
    })
}

let numbers: [Int] = [1, 1, 3, 5]
let evenNumberPredicate = { (number: Int) -> Bool in
    return number % 2 == 0
}
/// 클로저나 함수 내부에 타입에서 미리 계산을 해내고......리턴을 해낼 수 있다고........호우

let hasEvenNumber = hasElements(in: numbers, match: evenNumberPredicate)
print(hasEvenNumber)

//MARK:- 연산지연 클로저 : 자동 클로저

var customersInLine: [String] = ["승호","야곰","제니"]
print("first: \(customersInLine)")

/// 이 선언은 뭐니...
let customerPrivider: () -> String = {
    return customersInLine.removeFirst()
}

let provider: String = {
    return customersInLine.removeFirst()
}()
///`두개의 차이: 위에는 실행 안하고 가지고 있음(인스턴스 생성 전) 밑은 괄호가 닫혀있음 > 생성이 된 상태 일단 둘다 클로저임`

/// 너는 그럼 연산을 수행하지도 않고 그냥 가지고만 있다가

print("second: \(customersInLine)")
print("Now serving: \(customerPrivider())!")
print(customersInLine)
