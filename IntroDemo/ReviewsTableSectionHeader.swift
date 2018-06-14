
import UIKit
import PureLayout

class ReviewsTableSectionHeader: UIView {

    var titleLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor.red
        titleLabel = UILabel()
        titleLabel.text = "List of Movies"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.black
        self.addSubview(titleLabel)
        //postavljeno koliko ce dole iznositi udaljenost
        titleLabel.autoPinEdge(.top, to: .top, of: self, withOffset: 16.0)
        titleLabel.autoAlignAxis(.vertical, toSameAxisOf: self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
