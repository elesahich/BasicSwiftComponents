import UIKit

/// 스위프트는 함수를 일급 객체로 취급 > 함수를 다른 함수의 전달인자로 사용 가능 ( 클로저만 봐도 )
/// 매개변수로 함수를 가지는 함수를 고차함수라고 한다

//MARK: - map;
//      자신을 호출할 때 매개변수로 전달된 함수를 실행하여 그 결과를 다시 반환해주는 함수
//      Sequence, Collection 프로토콜을 따르는 타입, Optional은 map을 사용 가능 (배열 형태이거나~)

/// 맵을 사용하면 컨테이너가 담고있던 각각의 값을 매개변수를 통해 받은 함수에 적용한 후 다시 컨테이너에 포장하여 반환합니다
/// 기존 컨테이너의 값은 변경되지 않고 새로운 컨테이너가 생성되어 반환됩니다 `> 기존 데이터를 변형하는데 많이 사용함`
/// 다중 스레드 환경에서 컨테이너가 다른 스레드에서도 동시에 값이 변경되는 상황이나 부작용을 방지할 수 있다

//      딕셔너리에는 키를 위해 mapValue, compactMapValue, faltMapValue 뭐 이런것도 있대요 우왕

let numbers: [Int] = [0, 1, 2, 3, 4]

var doubledNumbers: [Int] = [Int]()
var strings: [String] = [String]()

doubledNumbers = numbers.map { (number: Int) -> Int in
    return number * 2
}
print(doubledNumbers)

strings = numbers.map { (number: Int) -> String in
    
    return "\(number)"
}
print(strings)
// 정말신기

strings = numbers.enumerated().map { (tuple: (indexing: Int, data: Int)) -> String in
    
//    guard tuple.indexing != numbers.count else {
////        continue
//    }
    return "\(tuple)"
}
print (strings)

for i in 0...3 {
    guard i == 2 else {
        continue
    }
    print(i)
}
