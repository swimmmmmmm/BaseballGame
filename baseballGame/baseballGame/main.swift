//
//  main.swift
//  baseballGame
//
//  Created by 서수영 on 3/11/24.
//

import Foundation

var record = [Int]()

func getMenu() {
    print(
    """
    환영합니다! 원하시는 번호를 입력해주세요
    1. 게임 시작하기  2. 게임 기록 보기  3. 종료하기
    """)

    let menu = Int(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines))
    if let menu {
        switch menu {
        case 1: record.append(startGame())
        case 2: showCount()
        case 3: return
        default:
            print("올바른 숫자를 입력해주세요!")
            getMenu()
        }
    }
    getMenu()
}

func startGame() -> Int {
    print("< 게임을 시작합니다 >")
    let answer = makeAnswer()

    var count = 0
    var strike = 0
    var ball = 0

    while strike < 3 {
        count += 1
        strike = 0
        ball = 0
        print("숫자를 입력하세요")

        let arr = readLine()!
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .split(separator: "")
            .compactMap{ Int($0) }

        if arr.count != 3 {
            print("올바르지 않은 입력값 입니다")
            continue
        }

        compare(array: arr, with: answer, ball: &ball, strike: &strike)

        let strStrike = "\(strike)스트라이크"
        let strBall = "\(ball)볼"
        var str = ""

        if strike != 0 { str += strStrike + " " }
        if ball != 0 { str += strBall }
        if str.count == 0 { str = "Nothing" }
        if strike == 3 { str = "정답입니다!" }

        print(str + "\n")
    }
    return count
}

func showCount() {
    for i in 0..<record.count {
        print("\(i+1)번째 게임 : 시도 횟수 - \(record[i])")
    }
    print("\n")
}

func makeAnswer() -> [Int] {
    var arr = [1, 2, 3, 4, 5 ,6 ,7, 8, 9]
    var answer = Array(repeating: 0, count: 3)

    answer[0] = arr.remove(at: arr.firstIndex(of: arr.randomElement()!)!)
    arr.append(0)
    answer[1] = arr.remove(at: arr.firstIndex(of: arr.randomElement()!)!)
    answer[2] = arr.remove(at: arr.firstIndex(of: arr.randomElement()!)!)

    return answer
}

func compare(array arr: [Int], with answer: [Int], ball: inout Int, strike: inout Int) {
    for i in 0..<3 {
        if arr[i] == answer[i] { strike += 1 }
    }
    arr.forEach {
        if answer.contains($0) { ball += 1 }
    }
    ball -= strike
}

getMenu()


