//
//  ContentView.swift
//  rock-paper-scissors
//
//  Created by Design Work on 2020-08-19.
//  Copyright © 2020 Ling Lu. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var moves = ["rock","paper","scissors"]
    var loses_against = ["scissors","rock","paper"]
    var wins_against = ["paper","scissors","rock"]
    
    @State private var current_move = Int.random(in: 0...2)
    @State private var user_move = 0
    @State private var goal = Bool.random()
    @State private var player_score = 0
    @State private var rounds = 0
    @State private var showScore = false
    @State private var message = ""
    var slide = true
    
    var body: some View {
        ZStack{
            
            Color(red: 250/255, green: 230/255, blue: 100/255).frame(width:500, height:1000).edgesIgnoringSafeArea(.all)
            
            VStack(spacing:30){
                
                Text("Your Score: \(player_score)")
                    .fontWeight(.heavy)
                VStack{
                    Text("Our move")
                    if slide{
                    Image(self.moves[current_move]).renderingMode(.original).resizable()
                    .frame(width:100,height:100)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .transition(.slide)
                        .animation(.default)
                    }
                }
                Text("\(goal ? "Go for the win" : "Try to lose")").font(.title)
                .fontWeight(.black)
                HStack{
                    ForEach(0..<3){
                        number in Button(action: {
                            //dosmth
                            self.chooseMove(number)
//                            self.reset()
                        }){
                            Image(self.moves[number]).renderingMode(.original)
                              
                                
                                .resizable()
                                .frame(width:100,height:100)
                            
                                .overlay(RoundedRectangle(cornerRadius:10).stroke(Color.white,lineWidth: 2))
//
                        }
                        .alert(isPresented: self.$showScore){
                            Alert(title: Text(""),
                                  message: Text("\(self.message)"),
                                  dismissButton: .default(Text("Continue")){
                                    self.reset()
                                })
                        }
                        
                    }
                }.frame(width:400)
                Button("Restart"){
                    self.reset()
                }
            }
        }
    }
    
    func chooseMove(_ move_index: Int){
        rounds += 1
        if self.goal{
            if moves[move_index] == wins_against[self.current_move]{
                self.player_score+=1
                self.message = "That's correct!"
            }else{
                self.player_score-=1
                self.message = "Wrong! Should have picked \(wins_against[self.current_move])"
            }
            
        }else{
            if moves[move_index] == loses_against[self.current_move]{
                self.player_score+=1
                self.message = "That's correct!"
            }else{
                self.player_score-=1
                self.message = "Wrong! Should have picked \(loses_against[self.current_move])"
            }
        }
        showScore=true
        if rounds == 10{
            self.message = "Game over! Your score is \(self.player_score)"
            self.reset()
        }
    }
    func reset(){
        self.current_move = Int.random(in: 0...2)
        self.goal = Bool.random()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
