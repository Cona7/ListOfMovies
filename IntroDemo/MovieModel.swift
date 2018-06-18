 
import Foundation
import CoreData
import AERecord

@objc(Movie)
public class Movie: NSManagedObject {
    class func createFrom(json: [String: Any]) -> Movie? {
        
//        pokušaj skracivanaj summarya, N/A problem
        
//        let longCharSummary = ((json["Plot"] as? String)?.count)!
//        var summary: String!
//        if longCharSummary > 200{
//                summary = (json["Plot"] as? String)?.substring(to:((json["Plot"] as?           String)?.index(((json["Plot"] as? String)?.startIndex)!, offsetBy: 150))!)
//        }else {
//             summary = json["Plot"] as? String
//        }
        
        if
            let title = json["Title"] as? String,
            let year = json["Year"] as? String,
            let summary = json["Plot"] as? String,
            let imgUrl = json["Poster"] as? String,
            let director = json["Director"] as? String
             {
            //izbaci prazne redove
            if summary == "N/A" {
                return nil }
                
            if imgUrl == "N/A" {
                return nil }
            
            //ako film postoji u bazi ne radi ništa (summary change)
            if let movie = Movie.first(with: ["title": title]){
                return movie
            }
            else{
            let movie = Movie.create(with: ["title": title])
                movie.title = title
                movie.summary = summary
                movie.year = year
                movie.imageUrl = imgUrl
                movie.director = director
                
            return movie
            }
        }
        return nil
    }
}
 
 extension Movie {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }
    
    @NSManaged public var title: String
    @NSManaged public var imageUrl: String?
    @NSManaged public var year: String
    @NSManaged public var summary: String
    @NSManaged public var director: String
    
 }

