import Combine
import SwiftUI
import PlaygroundSupport

public struct letter: Identifiable, Equatable {
    public var id =  UUID().uuidString
    public var name  = ""
    public var right = true
    
    public init (name: String, right: Bool = true) {
        self.name = name
        self.right = right
    }
}
private let generateStrings = ["Together", "Done", "Work", "Big", "Down", "Up", "Around", "Small", "Fly", "Littel"]

public enum TextOptions {
    case Generate, Custom(word: String), None
}

public func configString(option: TextOptions = .Generate) -> [Any] {
    var correctString = ""
    var prove  = true
    switch option {
    case .Generate:
         let index = Int.random(in: 0 ..< generateStrings.count)
         correctString = generateStrings[index]
    case .Custom(let word):
        correctString = word
    case .None:
        prove = false
    }
    return [correctString, prove]
}

public class LetterModel: ObservableObject {
    @Published public var letters: [letter] = []
    @Published var recognicedLetter = ""
    @Published public var prove = true
    @Published public var correctString = ""
    
    public init(option: [Any]) {
        self.prove = option[1] as! Bool
        self.correctString = option[0] as! String
    }
    
    
    
    
    public var defaultLetters = [
                          letter(name: "Y"),
                          letter(name: "o"),
                          letter(name: "r"),
                          letter(name: " "),
                          letter(name: "W"),
                          letter(name: "o"),
                          letter(name: "r"),
                          letter(name: "d")]

    public func lettersString() -> String {
        var letterString = ""
        for letter in letters {
            letterString.append(letter.name)
        }
        return letterString
    }
    
    public func checkString(checkLetter: String) {
        if prove {
            if correctString[letters.count].uppercased() == checkLetter.uppercased() {
                self.letters.append(letter(name: checkLetter))
            } else {
                self.letters.append(letter(name: checkLetter, right: false))
            }
        } else {
            self.letters.append(letter(name: checkLetter))
        }
        self.saveInStore()
    }
    
    public func saveInStore() {
        PlaygroundKeyValueStore.current["lettersString"] = .string(lettersString())
    }
    
    public func toggleLetter(letter: letter) {
        let index = self.letters.firstIndex(of: letter)
        if Character(self.letters[index!].name).isUppercase {
            self.letters[index!].name = self.letters[index!].name.lowercased()
        } else {
            self.letters[index!].name = self.letters[index!].name.uppercased()
        }
        saveInStore()
    }
}
