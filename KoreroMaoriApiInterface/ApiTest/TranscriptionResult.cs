namespace ApiTest
{
    public class TranscriptionResult
    {
        public bool Success { get; set; }
        public string Transcription { get; set; }
        public string ModelVersion { get; set; }
        public string Log { get; set; }
    }
}
