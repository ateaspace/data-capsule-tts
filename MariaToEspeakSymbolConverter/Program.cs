using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Text;
using CsvHelper;
using CsvHelper.Configuration;

namespace MariaToEspeakSymbolConverter
{
    public class Program
    {
        public static void Main(string[] args)
        {
            string filePath;
            string outputFilePath;

            Console.WriteLine(args.Length);

            if (args.Length >= 1 && !string.IsNullOrEmpty(args[0]))
            {
                filePath = args[0];
            }
            else
            {
                System.Console.WriteLine("Please enter the path to the CSV file: ");
                filePath = Console.ReadLine();
            }

            if (args.Length >= 2 && !string.IsNullOrEmpty(args[1]))
            {
                outputFilePath = args[1];
            }
            else
            {
                System.Console.WriteLine("Please enter the path to the output text file: ");
                outputFilePath = Console.ReadLine();
            }

            Console.WriteLine("Reading file...");

            using StreamWriter writer = new StreamWriter(outputFilePath, false);
            using StreamReader reader = new StreamReader(filePath);
            using CsvReader csv = new CsvReader(reader, new CsvConfiguration(CultureInfo.InvariantCulture)
            {
                HasHeaderRecord = false
            });

            IEnumerable<WordPair> wordPairs = csv.GetRecords<WordPair>();

            foreach (WordPair pair in wordPairs) {
                string converted = ConvertTranscription(pair.Transcription);
                if (!CheckConversion(converted)) {
                    System.Console.WriteLine("String could not be converted: {0} | {1}", pair.Transcription, converted);
                    return;
                }

                writer.WriteLine($"{pair.Word} {converted}");
            }

            writer.Flush();

            System.Console.WriteLine("Done!");
        }

        private static string ConvertTranscription(string transcription) {
            return transcription
                .Replace(" ", string.Empty)
                .Replace("-", string.Empty)
                .Replace("ŋ", "N")
                .Replace("ɾ", "R"); // Note that this conversion could either be 'R' for a trill or '*' for a tap
        }

        private static bool CheckConversion(string convertedString) {
            return Encoding.UTF8.GetByteCount(convertedString) == convertedString.Length;
        }
    }
}
