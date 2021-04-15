//
//  RxswiftTest.swift
//  swift-proj
//
//  Created by lan on 2021/4/15.
//

import UIKit
import RxSwift

class RxswiftTest: NSObject {
    
    let disposeBag = DisposeBag()
    
    func test() {
        //        test1()
        //        test2()
        //        test3()
        //        test4()
        //        test5()
                test6()
        //        test7()
        //        test8()
    }
    
    // ----------------------------- Observable ----------------------------
    // Disposing and terminating
    func test1() {
        let obserable =  Observable<String>.create { observer in
            observer.onNext("1")
            observer.onCompleted()
            observer.onNext("2")
            return Disposables.create()
        }

        obserable.subscribe(
            onNext: { print($0) },
            onError: { print($0) },
            onCompleted: { print("Completed") },
            onDisposed: { print("Disposed") }
        )
        .disposed(by: disposeBag)
    }
    
    // ----------------------------  Subject ------------------------------------
    // PublishSubject
    func test2() {
        let subject = PublishSubject<String>()
        subject.onNext("1")
        subject.subscribe { string in
            print(string)
        }
        .disposed(by: disposeBag)
    }
    
    // BehaviorSubject
    func test3() {
        let subject = BehaviorSubject<String>(value: "1")
        subject.onNext("2")
//        subject.onError(MyError.anError)
        subject.dispose()
        subject.subscribe { string in
            print(string)
        }
        .disposed(by: disposeBag)
        subject.onNext("3")
    }
    
    func test4() {
        let subject = ReplaySubject<String>.create(bufferSize: 2)
        
        subject.onNext("1")
        subject.onNext("2")
        subject.onNext("3")
        
        subject.subscribe { (event) in
            print("1> \(event)")
        }
        .disposed(by: disposeBag)
        
//        subject.onNext("4")
//        subject.onError(MyError.anError)
//        subject.dispose()
        
        subject.subscribe { (event) in
            print("2> \(event)")
        }
        .disposed(by: disposeBag)
    }
    
    // ------------------------- Operatiors -----------------------------
    func test5() {
        let subject = PublishSubject<String>()
        subject
//            .ignoreElements()
//            .element(at: 2)
//            .skip(2)
//            .take(2)
//            .skip(while: { (string) -> Bool in
//                let bool = Int(string)! % 2 == 0
//                print(bool)
//                return bool
//            })
            .subscribe { event in
            print(event)
        }
        .disposed(by: disposeBag)
        subject.onNext("1")
        subject.onNext("2")
        subject.onNext("3")
        subject.onNext("3")
        subject.onNext("2")
        subject.onNext("4")
        subject.onCompleted()
    }
    
    // 1. 将每个元组转换成数组
    // 2. 将每个元素输出
    // 3. 将转换的每个数组后添加元素“7”，并将每个元素顺序输出
    // 4. ...latest 输出
    func test6() {
        let subject = Observable.of(("1", "4"), ("2", "5"), ("3", "6"))
        subject.map({ (a, b) -> [String] in
            return [a, b]
        })
            .subscribe { (event) in
                print(event)
//                let (a, b) = event
//                print(a, b)
            }
        .disposed(by: disposeBag)
    }
    
    // share
    func test7() {
        let subject = Observable<String>.create { observer in
            observer.onNext("1")
            observer.onNext("2")
            print("###########")
            return Disposables.create()
        }
        .share(replay: 1, scope: .forever)
        
//        let sub = subject.map({ $0 + "9"})
//            .share()
//
        let a = subject
            .subscribe{ event in
                print("1>  \(event)")
            }
//
        a.dispose()

       let b = subject
            .subscribe{ event in
                print("2>  \(event)")
            }
        
        a.disposed(by: disposeBag)
        b.disposed(by: disposeBag)
    }
    
    // merge zip combineLatest
    func test8() {
        let subject1 = PublishSubject<Int>()
        let subject2 = PublishSubject<Int>()
        
//        Observable.of(subject1, subject2)
//            .merge()
//            .subscribe(onNext: { print($0) })
//            .disposed(by: disposeBag)
        

//        Observable.zip(subject1, subject2) {
//            "\($0) -- \($1)"
//        }
//        .subscribe(onNext: { print($0)} )
//        .disposed(by: disposeBag)
        
        
        Observable.combineLatest(subject1, subject2) {
            "\($0) -- \($1)"
        }
        .subscribe(onNext: { print($0)} )
        .disposed(by: disposeBag)
        
        
        subject1.onNext(11)
        subject1.onNext(12)
        subject2.onNext(22)
        subject2.onNext(23)
        subject1.onNext(14)
    }
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
// =========================================================================
    
//    func test6() {
//        let subject = Observable.of(("1", "4"), ("2", "5"), ("3", "6"))
//        subject
////            .map({ [$0, $1] })                    // 1
////            .flatMap({ Observable.from($0) })     // 2
////            .map({ [$0, $1, "7"]})                 // 3
////            .concatMap( { Observable.from($0)} )
////            .map({ [$0, $1] })                       // 4
////            .flatMapLatest({ Observable.from($0) })
//            .subscribe { (event) in
//            print(event)
//        }
//        .disposed(by: disposeBag)
//    }

}
