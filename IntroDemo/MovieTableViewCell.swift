
import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell{
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.textColor = UIColor.black
        yearLabel.font = UIFont.systemFont(ofSize: 13)
        summaryLabel.font = UIFont.systemFont(ofSize: 16)
        summaryLabel.textColor = UIColor.gray
        summaryLabel.numberOfLines = 0
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
        yearLabel.text = ""
        summaryLabel.text = ""
        imageLabel?.image = nil
    }

    func setup(withMovie movie: Movie) {
        titleLabel.text = movie.title
        yearLabel.text = movie.year
        summaryLabel.text = movie.summary
        
        if
            let urlString = movie.imageUrl,
            let url = URL(string: urlString) {
                imageLabel.kf.setImage(with: url)
        }
    }
}
