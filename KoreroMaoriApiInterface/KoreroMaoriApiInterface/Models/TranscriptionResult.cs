using System.Text.Json.Serialization;

namespace KoreroMaoriApiInterface.Models
{
    public class TranscriptionResult
    {
        public bool Success { get; set; }
        public string Transcription { get; set; }

        [JsonPropertyName("model_version")]
        public string ModelVersion { get; set; }
        public string Log { get; set; }
    }
}
