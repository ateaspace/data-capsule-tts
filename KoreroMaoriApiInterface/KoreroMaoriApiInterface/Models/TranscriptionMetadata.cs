using System.Text.Json.Serialization;

namespace KoreroMaoriApiInterface.Models
{
    public class TranscriptionMetadata
    {
        [JsonPropertyName("char")]
        public char Character { get; set; }

        [JsonPropertyName("start_time")]
        public double StartTime { get; set; }

        [JsonPropertyName("prob")]
        public double Confidence { get; set; }
    }
}
