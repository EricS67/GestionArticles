//
//  CreateArticleView.swift
//  GestionArticles
//
//  Created by Eric savary on 16.01.22.
//

import SwiftUI

struct CreateArticleView: View {
    
    @Environment(\.presentationMode) var mode
    
    @State private var Article = ""
    @State private var Description = ""
    @State private var Prix = ""
    
    
    var body: some View {
        
        NavigationView{
            ScrollView {
                VStack {
                    Section("Create Article") {
                        
                        HStack{
                            Image(systemName: "cart.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color(.darkGray))
                                .padding(.bottom, 14)
                            TextField("Article", text: $Article)
                                .textFieldStyle(.roundedBorder)
                                .padding(.bottom, 14)
                        }
                        
                        HStack{
                            Image(systemName: "list.bullet")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color(.darkGray))
                                .padding(.bottom, 14)
                            TextField("Description", text: $Description)
                                .textFieldStyle(.roundedBorder)
                                .padding(.bottom, 14)
                        }
                        HStack{
                            Image(systemName: "dollarsign.square.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color(.darkGray))
                                .padding(.bottom, 14)
                            TextField("Prix", text: $Prix)
                                .textFieldStyle(.roundedBorder)
                                .padding(.bottom, 14)
                        }
                        Button(action:{
                            createArticle()
                            mode.wrappedValue.dismiss()
                            Task.init {
                                //vm.isfetching = true
                                //vm.articles.removeAll()
                                //await vm.fetchData()
                            }
                        }, label: {
                            Text("Create Article")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: 150, height: 50)
                                .background(Color.blue)
                                .clipShape(Capsule())
                        }) // Fin Button
                            .disabled (Article.isEmpty || Description.isEmpty || Prix.isEmpty)
                            .padding(.top, 14)
                    } // Fin de section create
                    Spacer()
                    
                } // Vstack
            } // Scroll
            .padding()
        } // NavigationView
    } // body
    func createArticle() {
        
        let params = ["article":"\(Article)","description":"\(Description)","prix":"\(Prix)","categories_id":"2"]
        var request = URLRequest(url: URL(string:"https://ericapi.alwaysdata.net/api3/articles/create")!)
        request.httpMethod = "POST"
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
        
        Article = ""
        Description = ""
        Prix = ""
    }
}

struct CreateArticleView_Previews: PreviewProvider {
    static var previews: some View {
        CreateArticleView()
    }
}
