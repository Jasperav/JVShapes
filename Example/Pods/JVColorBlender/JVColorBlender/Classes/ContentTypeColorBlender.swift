import JVContentType
import JVRandomNumberGenerator

public final class ContentTypeColorBlender: ContentTypeGroup, Copyable {
    
    public static var allTypes = Set<ContentTypeColorBlender>()
    
    public var contentTypeId: String?
    public var contentTypeGroupId: [String]?
    public var color1: UIColor
    public var color2: UIColor
    
    /// Defines all the colors from percentage 0 till 100.
    private var colors = [UIColor]()
    private var randomNumber = RandomNumberInt(inclusiveLow: 0, inclusiveHigh: 100)
    
    public init(contentTypeId: String?,
                contentTypeGroupId: [String]?,
                color1: UIColor,
                color2: UIColor) {
        self.contentTypeId = contentTypeId
        self.contentTypeGroupId = contentTypeGroupId
        self.color1 = color1
        self.color2 = color2
    }
    
    public convenience init(contentTypeId: String?, color1: UIColor, color2: UIColor) {
        self.init(contentTypeId: contentTypeId, contentTypeGroupId: nil, color1: color1, color2: color2)
    }
    
    public convenience init(color1: UIColor, color2: UIColor) {
        self.init(contentTypeId: nil, contentTypeGroupId: nil, color1: color1, color2: color2)
        calculateAllColors()
    }
    
    public required init(old: ContentTypeColorBlender, newContentTypeId: String?) {
        contentTypeId = newContentTypeId
        contentTypeGroupId = old.contentTypeGroupId
        color1 = old.color1
        color2 = old.color2
    }
    
    /// Loops through allTypes and calculates every color combination
    /// Could be very expensive, so call this function only 1 time (more isn't needed, else re-think your design)
    public static func calulateAllColors() {
        for contentType in ContentTypeColorBlender.allTypes {
            contentType.calculateAllColors()
        }
    }
    
    private func calculateAllColors() {
        assert(colors.count == 0)
        for percentage in 0...100 {
            colors.append(ColorBlender.blend(from: color1, to: color2, percent: CGFloat(percentage) / 100))
        }
    }
    
    public var randomColor: UIColor {
        get {
            return colors[randomNumber.random()]
        }
    }
    
    public func color(percentage: CGFloat) -> UIColor {
        return colors[Int(percentage * 100)]
    }
    
}
