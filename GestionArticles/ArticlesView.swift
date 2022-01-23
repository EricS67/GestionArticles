//
//  ArticlesView.swift
//  GestionArticles
//
//  Created by Eric savary on 16.01.22.
//

import SwiftUI

struct ArticleItem: Decodable, Identifiable {
    let id:String
    var article:String
    var description:String
    var prix:String
}

struct ArticlesView: View {
    
    @State private var showingAddScreen = false
    
    let liens =  "https://ericapi.alwaysdata.net/api3/articles"
    
    @State private var articles = [ArticleItem(id:"0", article: "", description:"",prix:"")]
    
    var body: some View {
        
        NavigationView{
                    List(articles) { Item in
                        
                        NavigationLink(destination:
                                        ArticlesDetailView(Item:Item)) {
                            HStack{
                                Text("**\(Item.id)** - \(Item.article)")
                            } // HStack
                        }  // Navigation Link
                    } // List
                    
                    .refreshable {
                        await ChargeArticle()
                    } // Refrech List
                    
                    .task {
                        await ChargeArticle()
                    } // Task
                    
                    .navigationTitle("Liste d'article(s)")
                    .sheet(isPresented: $showingAddScreen , content: CreateArticleView.init)
                    .toolbar{
                        Button {
                            showingAddScreen = true
                        } label: {
                            Label("Add Article", systemImage: "plus")
                        }
                    }
                    //.navigationBarTitleDisplayMode(.inline)
                    
                    
                } // Navigation View
                //.onAppear { item.item }
            } // var body
            
            func ChargeArticle() async{
                do {
                    let url = URL(string: "https://ericapi.alwaysdata.net/api3/articles")!
                    let (data, _) = try await URLSession.shared.data(from: url)
                    articles = try JSONDecoder().decode([ArticleItem].self, from: data)
                }catch{
                    articles = []
                }
            }
        }

struct ArticlesView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlesView()
    }
}
