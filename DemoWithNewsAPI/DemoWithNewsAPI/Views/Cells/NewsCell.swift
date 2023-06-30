//
//  NewsCell.swift
//  DemoWithNewsAPI
//
//  Created by Pradeep kumar on 30/6/23.
//

import UIKit
import SDWebImage

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var subHeading: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var imageNews: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var currentData: NewsList? {
        didSet{
            setData()
        }
    }
    
    
    private func setData() {
        guard let news = currentData else {return}
        heading.text = news.title ?? ""
        subHeading.text = news.content ?? ""
        time.text = news.publishedAt ?? ""
        imageNews.sd_setImage(with: URL(string: news.urlToImage ?? ""))
    }
    
}
