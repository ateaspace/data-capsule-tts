using RestSharp;
using System;
using System.Threading.Tasks;

namespace ApiTest
{
    public class Program
    {
        public static void Main()
        {
            new Program().MainAsync().Wait();
        }

        public async Task MainAsync()
        {
            KoreroMaoriApi api = new KoreroMaoriApi();
            TranscriptionResult t = await api.GetTranscription("testFile.wav").ConfigureAwait(false);
            Console.WriteLine("Trancription: " + t.Transcription);

            //var client = new RestClient("https://asr.koreromaori.io/transcribe_file/");
            //client.FollowRedirects = true;
            //client.Timeout = -1;
            //var request = new RestRequest(Method.POST);
            //request.AddHeader("Authorization", "Basic d2Fpa2F0bzplN2I0ZDA3NGM3NTM0OWNlYjJlZjkxYTY4YTViNDdlZTI4M2M5ZTIyODAwMjAzOWFkZmYwZmE3Zjk0MDk2NjI5");
            //request.AddFile("audio_file", "C:/Users/carls/Music/espeak-out/output.wav");
            //IRestResponse response = client.Execute(request);
            //Console.WriteLine(response.Content);
        }
    }
}
