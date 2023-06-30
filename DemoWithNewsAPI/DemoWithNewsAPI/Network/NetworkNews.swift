//
//  NetworkNews.swift
//  DemoWithNewsAPI
//
//  Created by Pradeep kumar on 30/6/23.
//

import Foundation
import RxSwift
import RxCocoa


let basePath = "https://newsapi.org/v2/everything?q=bitcoin&from=2023-05-30&sortBy=publishedAt&apiKey=e3d69af3aea04d0384ea776453a8c321"

class NetworkNews {
    
    private init() {}
    
    static let sharedIntance = NetworkNews()
    
    let disposeBag = DisposeBag()
    var response = PublishSubject<[NewsList]>()
    
    var observable: Observable<[NewsList]> {
        return response.asObservable()
    }

    func getNewsAPI() {
        guard let url = URL(string: basePath) else {return}
        
        Observable.just(url)
            .observe(on: ConcurrentDispatchQueueScheduler(queue: .global()))
            .flatMap { url -> Observable<Data> in
                let req = URLRequest(url: url)
                let data = URLSession.shared.rx.data(request: req)
                return data
            }
            .map { [weak self] data -> [NewsList] in
                do {
                    let res = try JSONDecoder().decode(NewsDataResponse.self, from: data)
                    return res.articles ?? []
                } catch let error {
                    guard let strong = self else {return [] }
                    print("error \(error)")
                    strong.response.onError(error)
                }
                return []
            }
            .subscribe { [weak self] list in
                guard let strong = self else {return}
                print(list)
                DispatchQueue.main.async {
                    strong.response.onNext(list)
                }
            }
            .disposed(by: disposeBag)
    }
    
    
    
}
