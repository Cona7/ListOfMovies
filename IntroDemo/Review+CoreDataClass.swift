 
import Foundation
import CoreData
import AERecord

@objc(Review)
public class Review: NSManagedObject {
    class func createFrom(json: [String: Any]) -> Review? {
        
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
            let date = json["Year"] as? String,
            let summary = json["Plot"] as? String,
            let imgUrl = json["Poster"] as? String
             {
            //izbaci prazne redove
            if summary == "N/A" {
                return nil }
                
            if imgUrl == "N/A" {
                return nil }
            
            //ako film postoji u bazi ne radi ništa (summary change)
            if let review = Review.first(with: ["title": title]){
                return review
            }
            else{
            let review = Review.create(with: ["title": title])
                review.title = title
                review.summary = summary
                review.date = date
                review.imageUrl = imgUrl
            return review
            }
        }
        return nil
    }
}
