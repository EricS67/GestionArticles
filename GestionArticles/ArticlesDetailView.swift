//
//  ArticlesDetailView.swift
//  GestionArticles
//
//  Created by Eric savary on 16.01.22.
//

import SwiftUI

struct ArticlesDetailView: View {
    
    @Environment(\.presentationMode) var mode
    
    let Item:ArticleItem
    
    @State private var isedit = true
    
    @State private var id = ""
    @State private var Article = ""
    @State private var Description = ""
    @State private var Prix = ""
    
    @FocusState private var focusedField: field?
    enum field {
        case Article
        case Description
        case Prix
    }
    var body: some View {
        
        VStack{
            if isedit {
                Text("Detail de \(Item.article)")
                    .bold()
            }else {
                Text("Edition de \(Item.article)")
                    .bold()
            }
            
            TextField("id", text: $id)
                .onAppear {
                    self.id = Item.id
                }
                .disabled(true)
                .textFieldStyle(.roundedBorder)
                .padding([.leading,.trailing], 10)
            
            if isedit {
                TextField("Article", text: $Article)
                    .onAppear {
                        self.Article = Item.article
                    }
                //if isedit ? {.disable(true) : .disable(false) }
                    .textFieldStyle(.roundedBorder)
                    .padding([.leading,.trailing], 10)
                    .focused($focusedField,equals: .Article)
                    .submitLabel(.next)
                    .disabled(true)
            }else {
                TextField("Article", text: $Article)
                //if isedit ? {.disable(true) : .disable(false) }
                    .textFieldStyle(.roundedBorder)
                    .padding([.leading,.trailing], 10)
                    .focused($focusedField,equals: .Article)
                    .submitLabel(.next)
            }
            
            if isedit {
                TextField("Description", text: $Description)
                    .onAppear {
                        self.Description = Item.description
                    }
                    .textFieldStyle(.roundedBorder)
                    .padding([.leading,.trailing], 10)
                    .focused($focusedField,equals: .Description)
                    .submitLabel(.next)
                    .disabled(true)
            }else {
                TextField("Description", text: $Description)
                    .textFieldStyle(.roundedBorder)
                    .padding([.leading,.trailing], 10)
                    .focused($focusedField,equals: .Description)
                    .submitLabel(.next)
            }
            
            if isedit {
                TextField("Prix", text: $Prix)
                    .onAppear {
                        self.Prix = Item.prix
                    }
                    .textFieldStyle(.roundedBorder)
                    .padding([.leading,.trailing], 10)
                    .focused($focusedField,equals: .Prix)
                    .submitLabel(.join)
                    .disabled(true)
            }else {
                TextField("Prix", text: $Prix)
                    .textFieldStyle(.roundedBorder)
                    .padding([.leading,.trailing], 10)
                    .focused($focusedField,equals: .Prix)
                    .submitLabel(.join)
            }
            Divider()
        }
        .onSubmit {
            switch focusedField {
            case .Article:
                focusedField = .Description
            case .Description:
                focusedField = .Prix
            default:
                focusedField = .Article
            }
        }
        if isedit {
            HStack {
                Button(action:{
                    
                    isedit = false
                    //mode.wrappedValue.dismiss()
                    
                }, label: {
                    Text("Edit")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(width: 70, height: 25)
                        .background(Color.blue)
                        .clipShape(Capsule())
                }) // Fin Button
                Button(action:{
                    
                    isedit = true
                    delArticle()
                    mode.wrappedValue.dismiss()
                    
                }, label: {
                    Text("Delete")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(width: 70, height: 25)
                        .background(Color.red)
                        .clipShape(Capsule())
                }) // Fin Button
            }
        }else {
            HStack{
                Button(action:{
                    
                    isedit = true
                    ArticleUpdate()
                    mode.wrappedValue.dismiss()
                    
                }, label: {
                    Text("Update")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(width: 70, height: 25)
                        .background(Color.gray)
                        .clipShape(Capsule())
                }) // Fin Button
                Button(action:{
                    //Name = NameOld
                    isedit = true
                    
                    //mode.wrappedValue.dismiss()
                    
                }, label: {
                    Text("Cancel")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(width: 70, height: 25)
                        .background(Color.red)
                        .clipShape(Capsule())
                }) // Fin Button
            }
        }
        
        Spacer()
    } // var body
    
    func ArticleUpdate() {
        
        let params = ["id":"\(id)","article":"\(Article)","description":"\(Description)","prix":"\(Prix)","categories_id":"2"]
        var request = URLRequest(url: URL(string:"https://ericapi.alwaysdata.net/api3/articles/change")!)
        request.httpMethod = "PUT"
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
        
        // showAlert1 = true
        
        // size = 3
        Article = ""
        Description = ""
        Prix = ""
    }
    
    func delArticle(){
        let id = Item.id
        let params = ["id":"\(id)"]
        var request = URLRequest(url: URL(string:"https://ericapi.alwaysdata.net/api3/articles/delete")!)
        request.httpMethod = "DELETE"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // send request
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print(data!)
            // response
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                print(json)
            } catch {
                print("error")
            }
        })
        
        task.resume()
    }
} // Struct

/*
struct ArticlesDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        ArticlesDetailView()
    }
}
*/
