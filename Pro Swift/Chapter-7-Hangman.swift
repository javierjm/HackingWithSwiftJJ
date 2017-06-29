import Foundation

let word = "RHYTHM"
var usedLetters = [Character]()
print("Welcome to Hangman!")
print("Press a letter to guess, or Ctrl+D to quit.")

func printWord() {
   print("\nWord: ", terminator: "")
   var missingLetters = false
   for letter in word.characters {
      if usedLetters.contains(letter) {
         print(letter, terminator: "")
      } else {
         print("_", terminator: "")
         missingLetters = true
      }
}
   print("\nGuesses: \(usedLetters.count)/8")
   if missingLetters == false {
      print("It looks like you live on... for now.")
      print("Thanks for playing!")
      exit(0)
   } else {
      if usedLetters.count == 8 {
         print("Oops – you died! The word was \(word).")
         print("Thanks for playing!")
         exit(0)
      } else {
         print("Enter a guess: ", terminator: "")
      }
}
}

printWord()


while var input = readLine() {
   if let letter = input.uppercased().characters.first {
      if usedLetters.contains(letter) {
         print("You used that letter already!")
      } else {
         usedLetters.append(letter)
} }
   printWord()
}
