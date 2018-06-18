
import UIKit

class SingleMovieViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var summaryEdit: UITextView!
    
    
    var viewModel: SingleMovieViewModel!
    
    convenience init(singleViewModel: SingleMovieViewModel) {
        self.init()
        self.viewModel = singleViewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = viewModel.title
        titleLabel.numberOfLines = 0
        
        let myColor = UIColor.brown
        summaryEdit.layer.borderColor = myColor.cgColor
        summaryEdit.layer.borderWidth = 0.5
        summaryEdit.text = viewModel.summary
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Uredi", style: .plain, target: self, action: #selector(clickOnButton))
    }
    @objc func clickOnButton(button: UIButton) {
    viewModel.updateDescription(text: summaryEdit.text, title: titleLabel.text!)
    
    }
}


