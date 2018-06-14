
import Foundation
import Alamofire
import CoreData
import AERecord

class ReviewsViewModel {
    
    var searchMovieText: String!
    var baseUrl: String!
    
    //core data, model podatka iz baze.
    var reviews: [Review]? {
        let request: NSFetchRequest<Review> = Review.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        let context = AERecord.Context.main
        let review = try? context.fetch(request)
        return review
    }

    let apiKey = "e4c7fc84"
   
    init() {
    }

    func fetchReviews(completion: @escaping (([Review]?) -> Void)) -> Void {
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
                                _ = value.map({ json -> Review? in
                                    let review = Review.createFrom(json: json)
                                    return review
                                })
                                
                                try? AERecord.Context.main.save()
            
//                                completion(reviews)
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
    
    func review(atIndex index: Int) -> Review? {
        guard let reviews = reviews else {
            return nil
        }
        return reviews[index]
    }
    
    func numberOfReviews() -> Int {
        return reviews?.count ?? 0
    }
    
}
