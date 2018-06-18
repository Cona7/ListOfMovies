
import UIKit
import QuartzCore

class SearchMovieViewController: UIViewController {

    @IBOutlet weak var movieSearchName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieSearchName.delegate = self
        
        let myColor = UIColor.brown
        movieSearchName.layer.borderColor = myColor.cgColor
        movieSearchName.layer.borderWidth = 0.5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SearchMovieViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        let viewModel = MoviesViewModel()
        let viewController = MoviesListViewController(viewModel: viewModel, searchText: movieSearchName.text!)
        self.navigationController?.pushViewController(viewController, animated: true)
        
        return true
    }
}
