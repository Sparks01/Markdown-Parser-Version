//
//  ContentView.swift
//  Markdown Parser Version
//
//  Created by JXMUNOZ on 1/24/24.
//

import SwiftUI

struct ContentView: View {
    @State private var markdownInput: String = ""
    @State private var jsonOutput: String = ""

    var body: some View {
        HStack {
            // Markdown input area
            TextEditor(text: $markdownInput)
                .border(Color.gray, width: 1)
                .padding()

            // JSON output area
            ScrollView {
                Text(jsonOutput)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
            }
            .border(Color.gray, width: 1)
        }
        .onAppear(perform: parseMarkdown)
        .onChange(of: markdownInput, perform: { _ in parseMarkdown() })
    }

    private func parseMarkdown() {
        // Adjusted to use the corrected parser class name
        let parser = DnDStatBlockParser()
        let parsedData = parser.parse(markdown: markdownInput)
        
        // Convert DnDStatBlock to JSON
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if let jsonData = try? encoder.encode(parsedData),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            jsonOutput = jsonString
        } else {
            jsonOutput = "Error converting to JSON"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


