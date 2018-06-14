
import Foundation
import CoreData


extension Review {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Review> {
        return NSFetchRequest<Review>(entityName: "Review")
    }

    @NSManaged public var title: String
    @NSManaged public var imageUrl: String?
    @NSManaged public var date: String
    @NSManaged public var summary: String
    @NSManaged public var user: User?

}
