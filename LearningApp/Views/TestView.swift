//
//  TestView.swift
//  LearningApp
//
//  Created by Christopher Ching on 2021-03-24.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model:ContentModel
    var module: Module
  
    @State var selectedAnswerIndex: Int?
    @State var numcorrect = 0
    @State var submitted = false
    
    var body: some View {
        
        
            
        VStack(alignment: .leading) {
                if model.currentQuestion != nil {
                // Question number
               
                    Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                        .padding(.leading, 17)
                
                // Question
                CodeTextView()
                    .padding(.horizontal, 10)
                
                // Answers
                    ScrollView{
                        VStack{
                            ForEach(0..<model.currentQuestion!.answers.count , id: \.self){ index in
                                
                                Button(action: {
                                    
                                   
                                    
                                    selectedAnswerIndex = index
                                    
                                }, label: {
                                   
                                    ZStack{
                                        
                                        if submitted == false {
                                        
                                        RectangleCard(color: index == selectedAnswerIndex ? .gray : .white)
                                            .frame(height: 48)
                                        }
                                        else{
                                            if index == selectedAnswerIndex && index == model.currentQuestion!.correctIndex || index == model.currentQuestion!.correctIndex {
                                               
                                                RectangleCard(color: Color.green)
                                                    .frame(height: 48)
                                            }
                                            else if index == selectedAnswerIndex && index != model.currentQuestion!.correctIndex {
                                               
                                                RectangleCard(color: Color.red)
                                                    .frame(height: 48)
                                            }
                                            else if index != selectedAnswerIndex && index != model.currentQuestion!.correctIndex {
                                              
                                                RectangleCard(color: Color.white)
                                                    .frame(height: 48)
                                                
                                            }
                                             
                                        }
                                    
                                    
                                    Text(model.currentQuestion!.answers[index])
                                
                                }
                                }).disabled(submitted)
                                
                                
                            }
                        }.padding()
                    }
                    
                    Button(action: {
                        
                        if submitted == true {
                            
                            model.nextQuestion()
                            
                            //Reset properties
                            submitted = false
                            selectedAnswerIndex = nil
                        }
                        else {
                            
                            submitted = true
                            if selectedAnswerIndex == model.currentQuestion!.correctIndex{
                                numcorrect += 1
                            }

                            
                        }
                        
                        
                    }, label: {
                       
                        ZStack{
                            RectangleCard(color:  Color.green)
                                .frame(height: 48)
                                
                        
                        Text(buttonText)
                            .bold()
                            .foregroundColor(.white)
                            
                    
                        }.padding()
                        
                    }).disabled(selectedAnswerIndex == nil)
                // Button
            }
                else {
                    TestResultView(numcorrect: numcorrect)
                }
            }.navigationBarTitle("\(model.currentModule?.category ?? "") Test")
        .accentColor(.black)
            .onAppear {
               model.beginTest(module.id)
            }
            
        
    }
   
    var buttonText: String {
        
        if submitted == true {
            if model.currentQuestionIndex + 1 == model.currentModule!.test.questions.count {
                
                return "Finish"
            }
            else {
                return "Next"
            }
        }
        else {
            return "Submit"
        }
    }
}
struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        let model = ContentModel()
        TestView(module: model.modules[0])
            .environmentObject(ContentModel())
    }
}
