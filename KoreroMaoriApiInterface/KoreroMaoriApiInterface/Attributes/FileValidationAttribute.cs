using Microsoft.AspNetCore.Components.Forms;
using System;
using System.ComponentModel.DataAnnotations;
using System.Linq;

namespace KoreroMaoriApiInterface.Attributes
{
    [AttributeUsage(AttributeTargets.Property, AllowMultiple = false)]
    public class FileValidationAttribute : ValidationAttribute
    {
        private readonly string[] _allowedExtensions;
        private readonly int _maximumSize;

        public FileValidationAttribute(int maximumSize = 512000, string[] allowedExtensions = null)
        {
            _maximumSize = maximumSize;
            _allowedExtensions = allowedExtensions;
        }

        protected override ValidationResult IsValid(object value, ValidationContext validationContext)
        {
            var file = (IBrowserFile)value;
            var extension = System.IO.Path.GetExtension(file.Name);

            if (_allowedExtensions is not null && !_allowedExtensions.Contains(extension, StringComparer.OrdinalIgnoreCase))
                return new ValidationResult($"File must have one of the following extensions: {string.Join(", ", _allowedExtensions)}.", new[] { validationContext.MemberName });

            if (file.Size > _maximumSize)
                return new ValidationResult($"File must be smaller than {(float)_maximumSize / 1048576} mb", new[] { validationContext.MemberName });

            return ValidationResult.Success;
        }
    }
}
