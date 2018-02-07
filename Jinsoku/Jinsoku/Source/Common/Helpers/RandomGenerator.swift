import Foundation

public struct Random {
    public enum Digits: UInt8 {
        case one = 1, two = 2, three = 3, four = 4, five = 5, six = 6, seven = 7, eight = 8, nine = 9
        
        /// Returns an integer from 1 up to 'digits' digits. eg: random(.three) // may generate 5, 834, 64, etc.
        public func randomUpTo() -> UInt32 {
            // why 9 digits? UInt32 is -2,147,483,648 to 2,147,483,647 =  (10 digits)
            // I set one less digit than 10 so I can have the full range 0 to 999_999_999
            let bound = Int(pow(Double(10), Double(self.rawValue))) - 1
            return Random.random(range: 0..<bound)
        }
        
        /// Returns a random integer with exactly the given number of digits.
        public func random() -> UInt32 {
            let min = Int(pow(Double(10), Double(self.rawValue-1)))
            let max = Int(pow(Double(10), Double(self.rawValue)))
            return Random.random(range: min..<max)
        }
    }
    
    /// Return a random integer on the given range. e.g.: random(1...3) returns 1, 2 or 3.
    public static func random(range: Range<Int> ) -> UInt32 {
        var offset = 0
        if range.lowerBound < 0 {
            offset = abs(range.lowerBound)
        }
        let mini = UInt32(range.lowerBound + offset)
        let maxi = UInt32(range.upperBound   + offset)
        return mini + UInt32(arc4random_uniform(maxi - mini)) - UInt32(offset)
    }
    
    /// Returns a random date between 00:00:00 UTC on 1 January 2001 and today
    public static func randomDateSinceReferenceDate() -> Date {
        let interval = Date().timeIntervalSinceReferenceDate
        let randomInterval = (0...interval).randomFloatingPoint()
        return Date(timeIntervalSinceReferenceDate: randomInterval)
    }
    
    /// Returns a string created from the UUID, such as "E621E1F8-C36C-495A-93FC-0C247A3E6E5F"
    public static func randomString() -> String {
        return UUID().uuidString
    }
    
    /// Returns a random string with exactly the given number of digits.
    public static func randomDigitString(numberOfDigits: Int) -> String {
        return (1...numberOfDigits).map({ _ in return Int(arc4random_uniform(10)).description }).joined()
    }
    
    /// Returns a random bool.
    public static func randomBool() -> Bool {
        return (0...1).randomBinaryInteger() == 0
    }
    
    /// Returns a random Data with the passed number of bytes.
    public static func randomData(numberOfBytes: UInt) -> Data {
        var bytes = [UInt8]()
        (0...numberOfBytes).forEach { _ in bytes.append((0...255).randomBinaryInteger()) }
        return Data(bytes: bytes)
    }
}

public extension ClosedRange where Bound: FloatingPoint {
    /**
     Usage: let i: TYPE = (-1...1).random()
     where TYPE may be Double, Float, Float80 or CGFloat.
     */
    func randomFloatingPoint() -> Bound {
        let range = upperBound - lowerBound
        let randomValue = (Bound(arc4random_uniform(UINT32_MAX)) / Bound(UINT32_MAX)) * range + self.lowerBound
        return randomValue
    }
}

public extension ClosedRange where Bound: BinaryInteger {
    /**
     Usage: let i: TYPE = (1...10).random() where TYPE defaults to Int.
     If the sign of any bound is negative, it will be dropped by doing UInt32(bound).
     This call throws if the upperBound is lower than the lowerBound.
     */
    func randomBinaryInteger() -> Bound {
        let mini = UInt32(lowerBound)
        let maxi = UInt32(upperBound)
        return Bound(UInt32(mini) + UInt32(arc4random_uniform(UInt32(maxi - mini))))
    }
}
