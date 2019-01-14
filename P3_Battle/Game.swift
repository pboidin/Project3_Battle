//
//  Game.swift
//  P3_Battle
//
//  Created by Angelique Babin on 20/12/2018.
//  Copyright © 2018 Angelique Babin. All rights reserved.
//

import Foundation

class Game {
  
  //MARK: - Vars
  private var arrayTeams = [Team]() // with mentor // array gathering the teams
  private var endlessLoop = true // let si false

  //MARK: - Init

  //MARK: - Methodes

  // function for start game
  func start() {
    var userChoice = 0
    repeat {
      welcome()
      repeat {
        if let data = readLine() {
          if let dataToInt = Int(data) {
            userChoice = dataToInt
          }
        }
      } while userChoice != 1 && userChoice != 2 && userChoice != 3
      
      switch userChoice {
      case 1: // New Game !!! - Creation of the teams
        let teamFactory = TeamFactory()
        teamFactory.createTeams()
        arrayTeams = teamFactory.arrayTeams // import arrayTeams of class TeamFactory
      case 2: // Play to the game : Choice of character, fight, report  ...
        playGame()
      case 3:
        print("End of Game")
        endlessLoop = false
        //          endOfGame()
      default:
        print("Erreur - Choose a number between 1 and 3.")
        //break
      }
      userChoice = 0
    } while endlessLoop
  }
  
  // Interface to display the starting menu
  private func welcome() {
    print("")
    print("========================================================"
      + "\n Battle of warriors - Choose a number between 1 and 3 : "
      + "\n--------------------------------------------------------"
      + "\n1 - Creation of the teams "
      + "\n2 - Start of game ! "
      + "\n3 - End of Game "
      + "\n========================================================")
  }
  
  
  // Interface to display the choices to the game
  private func listChoiceGame() {
    print("========================================================")
    print("What action to do ? - Choose a number between 1 and 5 : ")
    print("--------------------------------------------------------")
    print("1. Display of teams and life points of the characters ")
    print("2. Report last action ")
    print("3. Start the battle ! ")
//    print("3. Choice of the character to play.")
//    print("4. Choice of the character’s target.")
//    print("5. Action of the character.")
    //      print("6. Random arrival of a treasure chest.")
    print("========================================================")
  }

  // Play to the game : Start of game --- EN COURS ----
  private func playGame() {
    var userChoice = 0
    
    // loop until one of the options is chosen
    repeat {
      listChoiceGame()
      repeat {
        if let data = readLine() {
          if let dataToInt = Int(data) {
            userChoice = dataToInt
          }
        }
    } while userChoice != 1 && userChoice != 2 && userChoice != 3 // && userChoice != 4 && userChoice != 5
    
    switch userChoice {
      case 1: // Display of teams and life points of the characters
        listTeams()
      case 2: // Report last action
        reportLastAction()
      case 3: // Start the battle
        battle()
        print("choice 3")
//      case 3: // Choice of the character to play
//        print("choice 3")
//      case 4: // Choice of the character’s target
//        print("choice 4")
//      case 5: // Action of the character
//        print("choice 5")
  //    case 6: // Ramdom arrival of a treasure chest containing a random weapon
  //      print("choice 6")
      default:
        print("Erreur - Choose a number between 1 and 5.")
        //break
      }
      userChoice = 0
    } while endlessLoop
 } // playGame ??? --- EN COURS ----

  // display the teams and life points of the characters
  private func listTeams() {
    for i in 0..<arrayTeams.count {
      print("====================")
      print("List of the team \(i+1) :")
      print("--------------------")
      let team = arrayTeams[i]
      team.displayTeam()
    }
  }
  
  // display of last action report 
  private func reportLastAction() {
    for i in 0..<arrayTeams.count {
      print("==========================================")
      print("Report of last action to the team \(i+1) :")
      print("------------------------------------------")
      let team = arrayTeams[i]
      team.displayLastAction()
    }
  }

  // Play to the game - Players perform the following action loop:
  // 1. Choose a character from your team
  // 2. Choose a character of the opposing team to attack or a character of its own team to care for in the case of the Mage.
  // The program will then carry out the attack (or heal) and tell the players what just happened.
  func battle() {
    print("=============================")
    print("@@@  The battle starts !  @@@")
    
//    reportLastAction()
    var myCharacter: Character
    repeat {
      for i in 0..<arrayTeams.count {
        print("===============================")
        print("Turn of player \(i+1) - Team \(i+1) :")
        print("===============================")
        let team = arrayTeams[i]
        team.displayTeam()
        print("==================================================")
        print("Player \(i+1) : What characters you choose to fight ?")
        print("--------------------------------------------------")
        myCharacter = arrayTeams[i].characters[userChoice() - 1]
        
        if let wizard = myCharacter as? Wizard {
          arrayTeams[i].displayTeam()
          print("=============================================")
          print("Choose a character of your team to heal him :")
          print("---------------------------------------------")
          myCharacter = arrayTeams[i].characters[userChoice() - 1]
          wizard.heal(character: myCharacter)
        } else {
          
          if i == 0 {
            let myTeamEnemy = arrayTeams[i+1]
            fightAction(myCharacter: myCharacter, myTeamEnemy: myTeamEnemy, index: i)
//            let myEnemy = myTeamEnemy.characters[userChoice() - 1]
//            arrayTeams[i].displayTeam()
//            print("Choose a character from the opposing team to attack.")
//            myCharacter.attack(character: myEnemy)
//            if myTeamEnemy.isDead() {
//            return
//            }
          } else {
            // attack enemy
            let myTeamEnemy = arrayTeams[i-1]
            fightAction(myCharacter: myCharacter, myTeamEnemy: myTeamEnemy, index: i)
//            let myEnemy = myTeamEnemy.characters[userChoice() - 1]
//            arrayTeams[i].displayTeam()
//            print("Choose a character from the opposing team to attack.")
//            myCharacter.attack(character: myEnemy)
//            if myTeamEnemy.isDead() {
//              return
//            }
          }
        }
      }
    } while endlessLoop == true
  }
  
  private func fightAction(myCharacter: Character, myTeamEnemy: Team, index: Int) {
//    arrayTeams[index].displayTeam()
    print("=====================================================")
    print("Choose a character from the opposing team to attack :")
    print("-----------------------------------------------------")
    if index == 0 {
      arrayTeams[index+1].displayLastAction()
      let myEnemy = myTeamEnemy.characters[userChoice() - 1]
      myCharacter.attack(character: myEnemy)
    } else {
      arrayTeams[index-1].displayLastAction()
      let myEnemy = myTeamEnemy.characters[userChoice() - 1]
      myCharacter.attack(character: myEnemy)
    }
//    let myEnemy = myTeamEnemy.characters[userChoice() - 1]
//    myCharacter.attack(character: myEnemy)
    if myTeamEnemy.isDead() {
      return
    }
  }
 
  //
  private func userChoice() -> Int {
    var characterChoice = 0
    repeat {
      if let data = readLine() {
        if let dataToInt = Int(data) {
          characterChoice = dataToInt
        }
      }
    } while characterChoice != 1 && characterChoice != 2 && characterChoice != 3
    return characterChoice
  }
  
  //    if userChoice == 1 {
  //      self.attack(character: character)
  //    } //else {
  ////      self.upgradeWeapon() // for test ====
  ////    }
  
  
  
} // END Class Game
