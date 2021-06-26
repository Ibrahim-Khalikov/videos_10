//
//  TestResultView.swift
//  LearningApp
//
//  Created by cloud_vfx on 26/06/21.
//

import SwiftUI

struct TestResultView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var numcorrect : Int
    
    var resultHeading: String {
        
        guard model.currentModule != nil else {
            return ""
        }
        
        let pct = Double(numcorrect)
        
        if pct > 5 {
            return "Avesome!"
        }
        else if pct > 8 {
            return "Doing Greatttt"
        }
        else {
            return "Keep learning"
        }
    }
    
    var body: some View {
        
        VStack{
            Spacer()
            
            Text(resultHeading)
                .font(.title)
            
            Spacer()
            
            Text("Find \(numcorrect) out of \(model.currentModule!.test.questions.count) Questions")
            
            Spacer()
            
            Button(action: {
                
                model.currentTestSelected = nil
                
                
            }, label: {
                
                ZStack{
                    RectangleCard(color: .green)
                        .frame(height: 48)
                    
                    Text("Complete")
                        .bold()
                        .foregroundColor(.white)
                }
            }).padding()
            
            Spacer()
        }
        
    }
}

