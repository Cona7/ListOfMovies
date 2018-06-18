
import UIKit
import Alamofire
import Reachability

class MoviesListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var refreshControl: UIRefreshControl!
    
    var viewModel: MoviesViewModel!

    let cellReuseIdentifier = "cellReuseIdentifier"
    
//    let reachability = Reachability()!
//    
//    var reachabilityChecker: String!
    
    var searchText: String!
    
    convenience init(viewModel: MoviesViewModel, searchText: String) {
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
        tableView.separatorStyle = .singleLineEtched
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(MoviesListViewController.refresh), for: UIControlEvents.valueChanged)
        tableView.refreshControl = refreshControl
        
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
    }

    func setupData() {
        viewModel.fetchMovies { [weak self] (movies) in
            self?.refresh()
        }
    }
    
    func refresh() {
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
}

extension MoviesListViewController: UITableViewDelegate {
    
    //ograničava da svi filmovi, odnosno redovi budu jednakih proporcija, slike
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }

    //postavi View klasu header za header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = MoviesTableSectionHeader()
        return view
    }

    //dodjeli mu visinu
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }

    //na temelju rowa, indexa editaj
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let cellMovie = viewModel.movie(atIndex: indexPath.row) {
            let singleMovieViewModel = SingleMovieViewModel(singleMovie: cellMovie)
            let singleMovieViewController = SingleMovieViewController(singleViewModel: singleMovieViewModel)
            //SingleMovieViewController.delegate = self as? EditViewControllerDelegate
            self.navigationController?.pushViewController(singleMovieViewController, animated: true)
        }
        self.refresh()
    }
}
    //može se promjeniti za summary

extension MoviesListViewController: UITableViewDataSource {
    func tableView( _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! MovieTableViewCell

        if let movie = viewModel.movie(atIndex: indexPath.row) {
            cell.setup(withMovie: movie)
        }
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfmovies()
    }
}

extension MoviesListViewController{
    
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



