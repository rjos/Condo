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
            let maria = User(dictionary: ["id": "3", "name": "Maria dos Santos", "imageName": ""])
            let pedro = User(dictionary: ["id": "4", "name": "Pedro Barrrrrcelah", "imageName": "dummy-photo-pedro"])
            let hunka = User(dictionary: ["id": "5", "name": "Cecília Hunka", "imageName": "dummy-photo-hunka"])
            let adm = User(dictionary: ["id":"6", "name": "Hermano Borges", "imageName": ""])
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
                "comments": DummyModelList(data: [])
            ]
            let post1 = PostAnnouncement(dictionary: postDic1)
            
            let postDic2 : Dictionary<String, AnyObject> = [
                "id": "announcements-2",
                "owner": adm,
                "text": "Lembrando para todo mundo que está chegando a data do pagamento dos porteiros, preciso que todos estejam em dia com o condomínio.",
                "comments": DummyModelList(data: [])
            ]
            let post2 = PostAnnouncement(dictionary: postDic2)
            
            let postDic3 : Dictionary<String, AnyObject> = [
                "id": "announcements-3",
                "owner": adm,
                "text": "Hoje é dia de festa, Zequinha voltou para o nosso prédio! Estamos muito felizes com sua recuperação!",
                "comments": DummyModelList(data: [])
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
                "comments": DummyModelList(data: []),
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
                "comments": DummyModelList(data: []),
                "status": PostReport.PostReportStatus.Open.rawValue
            ]
            let post1 = PostReport(dictionary: postDic1)
            return [post1]
        }
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
