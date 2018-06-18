
import Foundation
import Alamofire
import CoreData
import AERecord

class MoviesViewModel {
    
    var searchMovieText: String!
    var baseUrl: String!
    
    //core data, model podatka iz baze.
    var movies: [Movie]? {
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        let context = AERecord.Context.main
        let movie = try? context.fetch(request)
        return movie
    }

    let apiKey = "e4c7fc84"
   
    init() {
    }

    func fetchMovies(completion: @escaping (([Movie]?) -> Void)) -> Void {
        guard let url = URL(string: baseUrl) else {
            completion(nil)
            return
        }
        Alamofire.request(url,
                          method: .get,
                          parameters: ["api-key": apiKey])
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    completion(nil)
                    return
                }
        
                let value = response.result.value as? [String: Any]
                if let results = value!["Search"] as? [[String: Any]] {
                    for elem in results{
                        guard let imdbID = elem["imdbID"] as? String else { continue }
                        let url = "http://www.omdbapi.com/?i=" + imdbID + "&plot=short&apikey=e4c7fc84"
                        
                        Alamofire.request(url,
                                          method: .get)
                            .validate()
                            .responseJSON { response in
                                print(response)
                                guard response.result.isSuccess else {
                                    completion(nil)
                                    return
                                }
                             let value = response.result.value as? [String: Any]
                                _ = value.map({ json -> Movie? in
                                    let movie = Movie.createFrom(json: json)
                                    return movie
                                })
                                
                                try? AERecord.Context.main.save()
            
//                                completion(movies)
                                return
                        }
                    }
                }
                else {
                    completion(nil)
                    return
                }
        }
    }
    
    func movie(atIndex index: Int) -> Movie? {
        guard let movies = movies else {
            return nil
        }
        return movies[index]
    }
    
    func numberOfmovies() -> Int {
        return movies?.count ?? 0
    }
    
}
