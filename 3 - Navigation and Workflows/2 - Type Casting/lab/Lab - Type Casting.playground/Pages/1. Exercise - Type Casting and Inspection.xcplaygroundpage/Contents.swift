/*:
 ## Exercise - Type Casting and Inspection
 
 Create a collection of type [Any], including a few doubles, integers, strings, and booleans within the collection. Print the contents of the collection.
 */
var newCollection: [Any] = [3.0, 6.4, 2,8, "Hello", "Bye", true]
print(newCollection)
/*:
 Loop through the collection. For each integer, print "The integer has a value of ", followed by the integer value. Repeat the steps for doubles, strings and booleans.
 */
for element in newCollection {
    if let number = element as? Int {
        print("The integer has a value of \(number)")
    }
    if let number = element as? Double {
        print("The double has a value of \(number)")
    }
    if let number = element as? String {
        print("The string has a value of \(number)")
    }
    if let number = element as? Bool {
        print("The boolean has a value of \(number)")
    }
}
/*:
 Create a [String : Any] dictionary, where the values are a mixture of doubles, integers, strings, and booleans. Print the key/value pairs within the collection
 */
var newDictionaty: [String: Any] = ["First": true, "Second": 2.0, "Third": 3, "Forth": "Position number four"]
print(newDictionaty)
/*:
 Create a variable `total` of type `Double` set to 0. Then loop through the dictionary, and add the value of each integer and double to your variable's value. For each string value, add 1 to the total. For each boolean, add 2 to the total if the boolean is `true`, or subtract 3 if it's `false`. Print the value of `total`.
 */
var total: Double = 0

for element in newDictionaty {
    if let number = element.value as? Int {
        total += Double(number)
    }
    if let number = element.value as? Double {
        total += number
    }
    if let number = element.value as? String {
        total += 1
    }
    if let number = element.value as? Bool {
        total += 2
    }
}

print(total)
/*:
 Create a variable `total2` of type `Double` set to 0. Loop through the collection again, adding up all the integers and doubles. For each string that you come across during the loop, attempt to convert the string into a number, and add that value to the total. Ignore booleans. Print the total.
 */
var total2: Double = 0

for element in newDictionaty {
    if let number = element.value as? Int {
        total2 += Double(number)
    }
    if let number = element.value as? Double {
        total2 += number
    }
    if let number = element.value as? String {
        
    }
}

print(total2)
//: page 1 of 2  |  [Next: App Exercise - Workout Types](@next)
