
import UIKit
import Kingfisher

class ReviewsTableViewCell: UITableViewCell{

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionlabel: UILabel!
    @IBOutlet weak var reviewImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.textColor = UIColor.black
        timeLabel.font = UIFont.systemFont(ofSize: 13)
        descriptionlabel.font = UIFont.systemFont(ofSize: 16)
        descriptionlabel.textColor = UIColor.gray
        descriptionlabel.numberOfLines = 0
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
        timeLabel.text = ""
        descriptionlabel.text = ""
        reviewImageView?.image = nil
    }

    func setup(withReview review: Review) {
        titleLabel.text = review.title
        timeLabel.text = review.date
        descriptionlabel.text = review.summary
        
        if
            let urlString = review.imageUrl,
            let url = URL(string: urlString) {
                reviewImageView.kf.setImage(with: url)
        }
    }
}
