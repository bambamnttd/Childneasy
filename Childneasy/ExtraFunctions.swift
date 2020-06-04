import Foundation

extension Array
{
    /** Randomizes the order of an array's elements. */
    mutating func shuffle()
    {
        for _ in 0..<5
        {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}
