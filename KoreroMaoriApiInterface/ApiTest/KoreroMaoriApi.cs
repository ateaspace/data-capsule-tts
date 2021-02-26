using RestSharp;
using System;
using System.Threading.Tasks;

namespace ApiTest
{
    public class KoreroMaoriApi
    {
        public const string BASE_URL = "https://asr.koreromaori.io";

        private readonly IRestClient _client;

        public KoreroMaoriApi()
        {
            string token = Environment.GetEnvironmentVariable("KOREROMAORI_TOKEN");

            _client = new RestClient(BASE_URL)
            {
                FollowRedirects = true
            };

            _client.AddDefaultHeader("Authorization", $"Basic {token}");
        }

        public async Task<T> ExecuteAsync<T>(RestRequest request) where T : new()
        {
            IRestResponse<T> response = await _client.ExecuteAsync<T>(request).ConfigureAwait(false);
            if (response.ErrorException != null)
                throw response.ErrorException;

            return response.Data;
        }

        public async Task<TranscriptionResult> GetTranscription(string filePath)
        {
            RestRequest request = new RestRequest("transcribe_file", Method.POST);
            request.AddFile("audio_file", filePath);
            return await ExecuteAsync<TranscriptionResult>(request).ConfigureAwait(false);
        }
    }
}
