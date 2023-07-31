//
//  MainListVC.swift
//  DemoWithNewsAPI
//
//  Created by Pradeep kumar on 30/6/23.
//

import UIKit
import RxSwift
import RxCocoa

final class MainListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let interactor = NewsInteractor()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        
        tableView.register(UINib(nibName: "NewsCell", bundle: .main), forCellReuseIdentifier: "NewsCell")

        tableViewSettings()
        interactor.getListOfNews()
        
        interactor
            .observable
            .subscribe({_ in self.tableView.reloadData()})
            .disposed(by: disposeBag)
        
    }
    
    
    func tableViewSettings() {
        interactor.list
            .bind(to: tableView.rx.items(cellIdentifier: "NewsCell", cellType: NewsCell.self)) {
                row, data, cell in
                cell.currentData = data
            }
            .disposed(by: disposeBag)
    }
    


}
