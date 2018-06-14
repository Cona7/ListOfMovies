
import UIKit
import Alamofire
import Reachability

class ReviewsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var refreshControl: UIRefreshControl!
    
    var viewModel: ReviewsViewModel!

    let cellReuseIdentifier = "cellReuseIdentifier"
    
//    let reachability = Reachability()!
//    
//    var reachabilityChecker: String!
    
    var searchText: String!
    
    convenience init(viewModel: ReviewsViewModel, searchText: String) {
        self.init()
        self.viewModel = viewModel
        self.searchText = searchText
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//
//        reachabilityChecker = isReacheble()
//
//        if reachabilityChecker == "Reachable" {
//            viewModel.searchMovieText = self.searchText
//            viewModel.baseUrl = "http://www.omdbapi.com/?&s=" + self.searchText + "&apikey=e4c7fc84"
//            setupTableView()
//            setupData()
//        } else {
//
//            setupTableView()
//            refresh()
//        }
        
//        reachability.whenReachable = { reachability in
//            print("Reachable via WiFi or Reachable via Cellular")
//
//            self.viewModel.searchMovieText = self.searchText
//            self.viewModel.baseUrl = "http://www.omdbapi.com/?&s=" + self.searchText + "&apikey=e4c7fc84"
//            self.setupTableView()
//            self.setupData()
//        }
//        reachability.whenUnreachable = { _ in
//            print("Not reachable")
//            self.setupTableView()
//            self.refresh()
//        }
//        do {
//            try reachability.startNotifier()
//        } catch {
//            print("Unable to start notifier")
//        }

        viewModel.searchMovieText = searchText
        viewModel.baseUrl = "http://www.omdbapi.com/?&s=" + searchText + "&apikey=e4c7fc84"
        setupTableView()
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    
    //glavno setupiranje
    func setupTableView() {
        tableView.backgroundColor = UIColor.black
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ReviewsListViewController.refresh), for: UIControlEvents.valueChanged)
        tableView.refreshControl = refreshControl
        
        tableView.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
    }

    func setupData() {
        viewModel.fetchReviews { [weak self] (reviews) in
            self?.refresh()
        }
    }
    
    func refresh() {
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
}

extension ReviewsListViewController: UITableViewDelegate {
    
    //ograničava da svi filmovi, odnosno redovi budu jednakih proporcija, slike
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }

    //postavi View klasu header za header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = ReviewsTableSectionHeader()
        return view
    }

    //dodjeli mu visinu
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }

    //na temelju rowa, indexa editaj
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let review = viewModel.review(atIndex: indexPath.row) {
            let singleReviewViewModel = SingleReviewViewModel(review: review)
            let singleReviewViewController = SingleReviewViewController(viewModel: singleReviewViewModel)
            //singleReviewViewController.delegate = self as? EditViewControllerDelegate
            self.navigationController?.pushViewController(singleReviewViewController, animated: true)
        }
        
        self.refresh()
    }
    //može se promjeniti za summary
}

extension ReviewsListViewController: UITableViewDataSource {
    func tableView( _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! ReviewsTableViewCell

        if let review = viewModel.review(atIndex: indexPath.row) {
            cell.setup(withReview: review)
        }
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfReviews()
    }
}

extension ReviewsListViewController{
    
//    func isReacheble() -> String{
//        var bok: String!
//        reachability.whenReachable = { reachability in
//            print("Reachable via WiFi or Reachable via Cellular")
//            bok = "r"
//           // self.reachabilityChecker = "Reachable"
//        }
//
//        reachability.whenUnreachable = { _ in
//            print("Not reachable")
//            bok = "n"
//            //self.reachabilityChecker = "Not Reachable"
//        }
//        do {
//            try reachability.startNotifier()
//            return bok
//        } catch {
//            print("Unable to start notifier")
//        }
//
//        return ""
//        //return ""
//    }
}



