import SwiftUI

struct Quiz: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var score = 0
    @State private var quizCompleted = false
    
    struct Question {
        var text: String
        var answer: Bool
    }
    
    let questionPool: [Question] = [
        Question(text: "Carbon dioxide is a natural gas found in the air.", answer: true),
        Question(text: "Plants and animals produce oxygen as they breathe.", answer: true),
        Question(text: "Renewable energy sources include coal and natural gas.", answer: false),
        Question(text: "Deforestation helps reduce the levels of CO2 in the atmosphere.", answer: false),
        Question(text: "The ozone layer protects the Earth from harmful ultraviolet (UV) rays.", answer: true),
        Question(text: "Recycling paper helps save trees.", answer: true),
        Question(text: "Nuclear power is a completely renewable energy source.", answer: false),
        Question(text: "The greenhouse effect is only caused by the excessive use of air conditioners.", answer: false),
        Question(text: "Solar panels generate electricity by harnessing the power of the wind.", answer: false),
        Question(text: "Biodiversity refers to the variety of plant and animal species in an ecosystem.", answer: true),
        Question(text: "The Amazon rainforest produces 20% of the world's oxygen.", answer: true),
        Question(text: "Hydropower is a type of renewable energy derived from the movement of tides.", answer: false),
        Question(text: "Oceans cover about 70% of the Earth's surface.", answer: true),
        Question(text: "Methane is a greenhouse gas more potent than carbon dioxide.", answer: true),
        Question(text: "The Great Barrier Reef is the largest coral reef system in the world.", answer: true),
        Question(text: "Composting is a method of waste disposal that helps reduce landfill waste.", answer: true),
        Question(text: "Wind turbines generate electricity from the kinetic energy of moving air.", answer: true),
        Question(text: "Geothermal energy harnesses the heat from the Earth's interior.", answer: true),
        Question(text: "E-waste includes discarded electronic devices and appliances.", answer: true),
        Question(text: "Photosynthesis is the process by which plants convert sunlight into energy.", answer: true)
    ]
    
    @State private var selectedQuestions: [Question] = []
    @State private var currentQuestionIndex = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(UIColor.systemRed).opacity(0.2))
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    if quizCompleted {
                        QuizResultView(score: score, rematchAction: startQuiz)
                    } else {
                        Text("Quiz Time!")
                            .font(.title)
                            .padding(.bottom, 40)
                        
                        Text(selectedQuestions.indices.contains(currentQuestionIndex) ? selectedQuestions[currentQuestionIndex].text : "Invalid Index")
                            .font(.headline)
                            .padding()
                        
                        HStack {
                            Button(action: {
                                withAnimation {
                                    checkAnswer(true)
                                }
                            }) {
                                Text("True")
                                    .font(.system(size: 24))
                                    .foregroundColor(.green)
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.green, lineWidth: 2))
                            }
                            
                            Button(action: {
                                withAnimation {
                                    checkAnswer(false)
                                }
                            }) {
                                Text("False")
                                    .font(.system(size: 24))
                                    .foregroundColor(.red)
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.red, lineWidth: 2))
                            }
                        }
                        
                        Text("Score: \(score)")
                            .font(.headline)
                            .padding()
                            .foregroundColor(colorScheme == .dark ? .white : (score == 0 ? .black : (score < 3 ? .orange : .green)))
                    }
                }
                .onAppear {
                    startQuiz()
                }
                .padding()
            }
        }
    }
    
    func startQuiz() {
        score = 0
        quizCompleted = false
        
        if questionPool.count >= 5 {
            selectedQuestions = Array(questionPool.shuffled().prefix(5))
            currentQuestionIndex = 0
        } else {
            print("Not enough questions in the pool.")
        }
    }
    
    func checkAnswer(_ userAnswer: Bool) {
        let correctAnswer = selectedQuestions[currentQuestionIndex].answer
        
        if userAnswer == correctAnswer {
            score += 1
        }
        if currentQuestionIndex < selectedQuestions.count - 1 {
            currentQuestionIndex += 1
        } else {
            quizCompleted = true
        }
    }
}

struct QuizResultView: View {
    var score: Int
    var rematchAction: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Quiz Completed!")
                .font(.title)
                .foregroundColor(.blue)
                .padding()
            
            Text("Your Score: \(score) / 5")
                .font(.headline)
                .foregroundColor(score < 3 ? .red : .green)
                .padding()
            
            Image(systemName: score >= 4 ? "star.fill" : "star")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .foregroundColor(score >= 3 ? .yellow : .gray)
            
            Button(action: {
                withAnimation {
                    rematchAction()
                }
            }) {
                Text("Rematch")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

struct QuizResultView_Previews: PreviewProvider {
    static var previews: some View {
        QuizResultView(score: 4, rematchAction: {})
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        Quiz()
    }
}

