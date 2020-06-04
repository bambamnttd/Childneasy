//
//  QuizModel.swift
//  Childneasy
//
//  Created by MacBookPro on 1/12/18.
//  Copyright © 2018 MacBookPro. All rights reserved.
//

import Foundation
import UIKit

class Question {
    var question : String?
    var soundQuestion : String?
    var imgQuestion : String?
    var answers : [Answer]!
    
    init (question: String, soundQuestion: String, imgQuestion: String, answers: [Answer]) {
        self.question = question
        self.soundQuestion = soundQuestion
        self.imgQuestion = imgQuestion
        self.answers = answers
    }
}

class Answer {
    var response: String!
    var isRight: Bool!
    
    init(answer: String, isRight: Bool) {
        self.response  = answer
        self.isRight = isRight
    }
}
