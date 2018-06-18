
import Foundation
import AERecord

class SingleMovieViewModel {
    let movie: Movie
    
    init(singleMovie: Movie) {
        self.movie = singleMovie
    }
    
    var title: String {
        return movie.title.uppercased()
    }
    
    var summary: String {
        return movie.summary
    }
    
    //update summary
    func updateDescription(text: String, title: String){
      movie.summary = text
      try? AERecord.Context.main.save()
    }
}
