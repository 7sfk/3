import SwiftUI

struct AIRecommendationsView: View {
    @ObservedObject var projectVM: ProjectViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "brain.head.profile")
                    .foregroundColor(.blue)
                Text("AI Рекомендации")
                    .font(.headline)
                Spacer()
                Text("🤖")
                    .font(.title2)
            }
            
            if projectVM.recommendations.isEmpty {
                Text("AI анализирует проект...")
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
            } else {
                ForEach(projectVM.recommendations.prefix(3)) { recommendation in
                    RecommendationCard(recommendation: recommendation)
                }
            }
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(12)
    }
}

struct RecommendationCard: View {
    let recommendation: AIRecommendation
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: recommendation.icon)
                .font(.title3)
                .foregroundColor(recommendation.priority.color)
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(recommendation.title)
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(.primary)
                
                Text(recommendation.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                
                HStack {
                    Text("Влияние: \(recommendation.impact.rawValue)")
                        .font(.caption2)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(Color.orange.opacity(0.2))
                        .cornerRadius(4)
                    
                    Spacer()
                    
                    Text(recommendation.priority.rawValue)
                        .font(.caption2)
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(recommendation.priority.color)
                        .cornerRadius(4)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: .gray.opacity(0.1), radius: 2, x: 0, y: 1)
    }
}
