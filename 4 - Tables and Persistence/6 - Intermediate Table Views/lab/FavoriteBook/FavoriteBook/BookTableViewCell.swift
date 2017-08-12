//
//  BookTableViewCell.swift
//  FavoriteBooks
//
//  Created by Guillermo Alcalá Gamero on 12/8/17.
//
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookAuthorLabel: UILabel!
    @IBOutlet weak var bookGenreLabel: UILabel!
    @IBOutlet weak var bookLengthLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(with book: Book) {
        bookTitleLabel.text = book.title
        bookAuthorLabel.text = book.author
        bookGenreLabel.text = book.genre
        bookLengthLabel.text = book.length
    }

}
