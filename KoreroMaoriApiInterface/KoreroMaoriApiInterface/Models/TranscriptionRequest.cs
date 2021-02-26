using KoreroMaoriApiInterface.Attributes;
using Microsoft.AspNetCore.Components.Forms;
using System.ComponentModel.DataAnnotations;

namespace KoreroMaoriApiInterface.Models
{
    public class TranscriptionRequest
    {
        [Required]
        [FileValidation(maximumSize: 31457280)] // 30mb
        public IBrowserFile File { get; set; }
    }
}
