//
//  DummyDatabase.swift
//  CondoModel
//
//  Created by Lucas Tenório on 09/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit

public class DummyDatabase: NSObject {
    
    var allUsers: Dictionary<String, User> {
        get {
            let lucas = User(dictionary: ["id": "1", "name": "Lucas Tenório", "imageName": "dummy-photo-lucas"])
            let guedes = User(dictionary: ["id": "2", "name": "Lucas Guedes", "imageName": "dummy-photo-guedes"])
            let maria = User(dictionary: ["id": "3", "name": "Maria dos Santos", "imageName": "dummy-photo-maria"])
            let pedro = User(dictionary: ["id": "4", "name": "Pedro Barrrrrcelah", "imageName": "dummy-photo-pedro"])
            let hunka = User(dictionary: ["id": "5", "name": "Cecília Hunka", "imageName": "dummy-photo-hunka"])
            let adm = User(dictionary: ["id":"6", "name": "Eduardo Leite", "imageName": "dummy-photo-adm"])
            return [
                "lucas": lucas,
                "guedes": guedes,
                "maria": maria,
                "pedro": pedro,
                "hunka": hunka,
                "adm": adm
            ]
        }
    }
    
    var allAnnouncements: Array<Model> {
        get{
            let adm: User = self.allUsers["adm"]!
            let postDic1 : Dictionary<String, AnyObject> = [
                "id": "announcements-1",
                "owner": adm,
                "text": "Infelizmente nosso querido zelador Zequinha se encontra hospitalizado depois de ter recebido uma privada na cabeça num jogo de futebol. Até a sua melhora, contratei um substituto, nenhuma mudança no condomínio será necessária (trabalho escravo).",
                "comments": DummyModelList(data: self.getCommentByIdPost("announcements-1"))
            ]
            let post1 = PostAnnouncement(dictionary: postDic1)
            
            let postDic2 : Dictionary<String, AnyObject> = [
                "id": "announcements-2",
                "owner": adm,
                "text": "Lembrando para todo mundo que está chegando a data do pagamento dos porteiros, preciso que todos estejam em dia com o condomínio.",
                "comments": DummyModelList(data: self.getCommentByIdPost("announcements-2"))
            ]
            let post2 = PostAnnouncement(dictionary: postDic2)
            
            let postDic3 : Dictionary<String, AnyObject> = [
                "id": "announcements-3",
                "owner": adm,
                "text": "Hoje é dia de festa, Zequinha voltou para o nosso prédio! Estamos muito felizes com sua recuperação!",
                "comments": DummyModelList(data: self.getCommentByIdPost("announcements-3"))
            ]
            let post3 = PostAnnouncement(dictionary: postDic3)
            
            let postsList = [post1, post2, post3]
            return postsList
        }
    }
    
    public var allQuestions: Array<Model> {
        get{
            let adm: User = self.allUsers["adm"]!
            let postDic1 : Dictionary<String, AnyObject> = [
                "id": "questions-1",
                "owner": adm,
                "text": "O que vocês acham da ideia de trocar todas as lâmpadas para um padrão mais eficiente? Estamos gastando muito dinheiro com a energia comum. O custo esperado seria de aproximadamente R$500.",
                "comments": DummyModelList(data: self.getCommentByIdPost("questions-1")),
                "answers": DummyModelList(data: [])
            ]
            let post1 = PostQuestion(dictionary: postDic1)
            return [post1]
        }
    }
    
    public var allReports: Array<Model> {
        get {
            
            let user1: User = self.allUsers["pedro"]!
            let postDic1 : Dictionary<String, AnyObject> = [
                "id": "reports-1",
                "owner": user1,
                "text": "Mermão doido, tem lixo na frente do meu apartamento. Quando fui sair para trabalhar achei que estava na muribeca #odeiomeuvizinho",
                "comments": DummyModelList(data: self.getCommentByIdPost("reports-1")),
                "status": PostReport.PostReportStatus.Open.rawValue
            ]
            let post1 = PostReport(dictionary: postDic1)
            return [post1]
        }
    }
    
    public func getCommentByIdPost (id: String) -> Array<Comment> {
        
        let comment_1 = Comment(dictionary: [
            "id": "comments-1",
            "owner" : self.allUsers["pedro"]!,
            "text"  : "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt"
        ])
        
        let comment_2 = Comment(dictionary: [
            "id": "comments-2",
            "owner" : self.allUsers["lucas"]!,
            "text"  : "Mas esse comentário tbm ta ruim"
        ])
        
        let comment_3 = Comment(dictionary: [
            "id": "comments-3",
            "owner" : self.allUsers["guedes"]!,
            "text"  : "então relaxa ai, pq vocês são muitos fracos"
        ])
        
        let comment_4 = Comment(dictionary: [
            "id": "comments-4",
            "owner" : self.allUsers["maria"]!,
            "text"  : "Que cara doidão vlh"
        ])
        
        let comment_5 = Comment(dictionary: [
            "id": "comments-5",
            "owner" : self.allUsers["hunka"]!,
            "text"  : "Esse teu vizinho é doido mesmo"
        ])
        
        let comment_adm = Comment(dictionary: [
            "id": "comments-6",
            "owner" : self.allUsers["adm"]!,
            "text"  : "Parem de pertubar, por favor"
        ])
        
        let comments: Array<Comment>
        
        switch (id){
            case "announcements-2":
                comments = [comment_3, comment_2, comment_5]
            case "reports-1":
                comments = [comment_5]
            case "questions-1":
                comments = [comment_4, comment_2, comment_adm]
            default:
                comments = [comment_1, comment_2, comment_3, comment_4, comment_5, comment_adm]
        }
        
        return comments
        
    }
    
    public var community: Community {
        get{
            let adm: User = self.allUsers["adm"]!
            let dic = [
                "id": "1",
                "name":"Edifício Santiago",
                "administrators": DummyModelList(data: [adm]),
                "posts": DummyModelList(data: self.allAnnouncements + self.allQuestions + self.allReports)
            ]
            return Community(dictionary: dic)
        }
    }
}
