//
//  DemoWithNewsAPITests.swift
//  DemoWithNewsAPITests
//
//  Created by Pradeep kumar on 30/6/23.
//

import XCTest
import RxSwift
@testable import DemoWithNewsAPI

final class DemoWithNewsAPITests: XCTestCase {
    
    let dispose = DisposeBag()
    
    class MockData: RequestAPI {
        
        let list: [NewsList]
        
        init(list: [NewsList]) {
            self.list = list
        }
        
        var response = PublishSubject<[NewsList]>()
        func getNewsAPI() {
            response.onNext(list)
        }
        
        var observable: RxSwift.Observable<[DemoWithNewsAPI.NewsList]> {
            response.asObservable()
        }
    }
    


    func test_interactor_empty() {
        // setup
        let interactor = NewsInteractor(network: MockData(list: []) )
        
        // data
        let list = interactor.list
        
        list.subscribe { data in
            XCTAssertNil(data.element)
            if let data = data.element {
                XCTAssertTrue(data.isEmpty)
            }
        }.disposed(by: dispose)
        
        // 
        
    }
    
    func test_interactor_with_Single_Data() {
        
      let listElement = NewsList(author: "iOS", title: "Driver", description: nil, url: "", urlToImage: nil, publishedAt: nil, content: nil)

        // setup
        let interactor = NewsInteractor(network: MockData(list: [listElement]) )
        
        // data
        let list = interactor.list
        
        //checking
        list.subscribe { data in
            if let data = data.element, let first = data.first {
                XCTAssertEqual(first.author, "iOS")
                XCTAssertEqual(first.title, "Driver")
                XCTAssertNil(first.description)
            }
        }.disposed(by: dispose)
                
    }

    

}
