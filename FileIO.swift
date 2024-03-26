//
//  HelloWorld.swift
//
//  Created by Tamer Zreg
//  Created on 2024-03-25
//  Version 1.0
//  Copyright (c) Tamer Zreg. All rights reserved.
//
//  Reads numbers from an input file, calculates the sum of each line,
//  and writes the sums or error messages to an output file.

import Foundation

// Function to process input file
func processInputFile() {
    // Define paths for input and output files
    let inputFilePath = "./input.txt" // Path to input file
    let outputFilePath = "./output.txt" // Path to output file
    
    do {
        // Open input and output files
        let inputFileURL = URL(fileURLWithPath: inputFilePath)
        let outputFileURL = URL(fileURLWithPath: outputFilePath)
        let outputFileHandle = try FileHandle(forWritingTo: outputFileURL)
        let inputFileContents = try String(contentsOf: inputFileURL)
        
        // Split input file contents into lines
        let lines = inputFileContents.components(separatedBy: .newlines)
        
        // Process each line of the input file
        for line in lines {
            let numbersAsString = line.split(separator: " ")
            var sum = 0
            var error = false
            
            // Calculate sum of numbers in the line
            for numberAsString in numbersAsString {
                if let number = Int(numberAsString) {
                    sum += number
                } else {
                    // If parsing fails, set error flag and break
                    error = true
                    print("Error occurred in input line: \(line)")
                    break
                }
            }
            
            // Write sum or error message to output file
            if !error {
                let outputLine = "\(sum)\n"
                if let outputData = outputLine.data(using: .utf8) {
                    outputFileHandle.write(outputData)
                }
            } else {
                let errorOutput = "Error occurred in input line: \(line)\n"
                if let errorData = errorOutput.data(using: .utf8) {
                    outputFileHandle.write(errorData)
                }
            }
        }
        
        // Close output file
        outputFileHandle.closeFile()
        
    } catch {
        // Handle errors
        print("An error occurred: \(error)")
    }
}

// Call the function to process input file
processInputFile()
