import UIKit

//MARK:- 너의 이름: Optional Chaining 중에서도 빠른 종료래 (Early Exit)
for i in 0...3 {
    guard i != 2 else {
        continue
    }
    print(i)
}

for i in 0...3 {
    if i != 2 {
        print(i)
    } else {
        continue
    }
}
