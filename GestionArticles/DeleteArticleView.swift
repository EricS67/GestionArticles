//
//  DeleteArticleView.swift
//  GestionArticles
//
//  Created by Eric savary on 16.01.22.
//

import SwiftUI

struct DeleteArticleView: View {
    
    @State private var number = ""
    
    var body: some View {
        VStack{
            
            Section("Effacer user"){
                HStack{
                    Image(systemName: "trash")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color(.darkGray))
                    TextField("ID", text: $number)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.decimalPad)
                        .padding(.bottom, 14)
                }
                
                Button(action:{
                    deleteArticle()
                    hideKeyboard()
                    //mode.wrappedValue.dismiss()
                }, label: {
                    Text("Effacer Article")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 150, height: 50)
                        .background(Color.blue)
                        .clipShape(Capsule())
                }) // Fin Button
                //.shadow(color: .gray, radius: 10, x: 0.0, y: 0.0)
                    .disabled(number.isEmpty)
                /*.alert(isPresented: $showAlert2) {
                 Alert(
                 title: Text("User Deleted"),
                 message: Text("It's Done ...")
                 )
                 }*/
            }
            
            
        }
        .padding()
    }
    func deleteArticle() {
        
        let params = ["id":"\(number)"]
        var request = URLRequest(url: URL(string:"https://ericapi.alwaysdata.net/api3/articles/delete")!)
        request.httpMethod = "DELETE"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print(data!)
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                print(json)
            } catch {
                print("error")
            }
        })
        
        task.resume()
        
        // showAlert2 = true
        number = ""
    }
    
    
}


#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct DeleteArticleView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteArticleView()
    }
}
