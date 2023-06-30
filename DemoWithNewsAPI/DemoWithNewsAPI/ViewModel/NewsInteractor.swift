//
//  NewsInteractor.swift
//  DemoWithNewsAPI
//
//  Created by Pradeep kumar on 30/6/23.
//

import Foundation
import RxSwift
import RxRelay

class NewsInteractor {
    
    
    private let disposeBag = DisposeBag()
    
    private(set) var list = PublishSubject<[NewsList]>()
    
    var isLoading = BehaviorRelay<Bool>(value: false)
    
    var isLoaderObservable: Observable<Bool> {
        return isLoading.asObservable()
    }
    
    var observable: Observable<[NewsList]> {
        return list.asObservable()
    }
    
    func getListOfNews() {
        NetworkNews.sharedIntance.getNewsAPI()
        NetworkNews.sharedIntance
            .observable
            .subscribe { [weak self] result  in
                guard let strong = self else {return}
                strong.list.onNext(result)
            }onError: { [weak self] error in
                guard let strong = self else {return}
                strong.list.onError(error)
            }
            .disposed(by: disposeBag)
    }
    
    
}
