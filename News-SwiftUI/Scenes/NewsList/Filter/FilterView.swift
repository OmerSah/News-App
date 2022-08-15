//
//  FilterView.swift
//  News-SwiftUI
//
//  Created by Ömer Faruk Şahin on 15.08.2022.
//

import SwiftUI

struct FilterView: View {
    
    @State private var fromDate = Date()
    @State private var toDate = Date()
    
    @Binding var presenting: Bool
    
    var filterButtonAction: (_ from: String, _ to: String) -> ()
    
    var body: some View {
        
        VStack {
            Text("Choose dates: ")
                .bold()
                .font(.system(size: 28))
                .frame(width: UIScreen.main.bounds.width * 0.9, alignment: .leading)
                
            DatePicker("From:",
                       selection: $fromDate,
                       displayedComponents: [.date]
            ).padding()
            
                
            DatePicker("To:",
                       selection: $toDate,
                       displayedComponents: [.date]
            ).padding()
            
            Button {
                filterButtonAction(
                    DateFormatter
                        .filterDateFormat
                        .string(from: fromDate),
                    DateFormatter
                        .filterDateFormat
                        .string(from: toDate)
                )
                presenting.toggle()
            } label: {
                Text("Filter")
                    .frame(width: 200, height: 40, alignment: .center)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .padding(.top)
            }
        }
        
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(presenting: .constant(true), filterButtonAction: { from,to in })
    }
}
