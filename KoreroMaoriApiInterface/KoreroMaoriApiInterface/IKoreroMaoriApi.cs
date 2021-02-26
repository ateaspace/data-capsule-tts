using KoreroMaoriApiInterface.Models;
using Refit;
using System.Threading;
using System.Threading.Tasks;

namespace KoreroMaoriApiInterface
{
    public interface IKoreroMaoriApi
    {
        [Multipart]
        [Post("/transcribe_file")]
        public Task<TranscriptionResult> Transcribe([AliasAs("audio_file")] StreamPart audioFile, CancellationToken cancelToken);

        [Multipart]
        [Post("/transcribe_with_metadata_file")]
        public Task<TranscriptionWithMetadataResult> TranscribeWithMetadata([AliasAs("audio_file")] StreamPart audioFile, CancellationToken cancelToken);
    }
}
