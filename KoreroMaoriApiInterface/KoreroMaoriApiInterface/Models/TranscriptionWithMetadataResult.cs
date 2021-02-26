using System.Collections.Generic;

namespace KoreroMaoriApiInterface.Models
{
    public class TranscriptionWithMetadataResult : TranscriptionResult
    {
        public List<TranscriptionMetadata> Metadata { get; set; }
    }
}
