import Cocoa
import CreateML

let data = try MLDataTable(contentsOf: URL(fileURLWithPath: "/Users/juhyunyun/Desktop/twitter-sanders-apple3.csv"))

let (trainingData, testingData) = data.randomSplit(by: 0.8, seed: 5)

let sentimentClassifier = try MLTextClassifier(trainingData: trainingData, textColumn: "text", labelColumn: "class")

let evaluationMetrics = sentimentClassifier.evaluation(on: testingData, textColumn: "text", labelColumn: "class")

let evaluationAccuracy = (1.0 - evaluationMetrics.classificationError) * 100

let metadata = MLModelMetadata(author: "Juhyun Yun", shortDescription: "A model trained to classify sentiment on Tweets", version: "1.0")

try sentimentClassifier.write(to: URL(fileURLWithPath: "/Users/juhyunyun/Desktop/TweetSentimentClassifier.mlmodel"), metadata: metadata)

try sentimentClassifier.prediction(from: "I love @Apple")

try sentimentClassifier.prediction(from: "I don't think @Apple is a good company")

try sentimentClassifier.prediction(from: "I think @Apple is nice")

try sentimentClassifier.prediction(from: "Hi @Apple")
