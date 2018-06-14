
import Foundation
import AERecord

class SingleReviewViewModel {
    let review: Review
    
    init(review: Review) {
        self.review = review
    }
    
    var title: String {
        return review.title.uppercased()
    }
    
    var summary: String {
        return review.summary
    }
    
    //update summary
    func updateDescription(text: String, title: String){
      review.summary = text
      try? AERecord.Context.main.save()
    }
}
