"use client";

import { useCallback, useState } from "react";

interface CVUploadStepProps {
  onFileSelect: (file: File) => void;
  isUploading: boolean;
}

export function CVUploadStep({ onFileSelect, isUploading }: CVUploadStepProps) {
  const [isDragging, setIsDragging] = useState(false);
  const [selectedFile, setSelectedFile] = useState<File | null>(null);
  const [error, setError] = useState<string | null>(null);

  const validateFile = (file: File): boolean => {
    if (!file.name.toLowerCase().endsWith(".pdf")) {
      setError("Please upload a PDF file");
      return false;
    }
    if (file.size > 10 * 1024 * 1024) {
      setError("File size must be less than 10MB");
      return false;
    }
    setError(null);
    return true;
  };

  const handleDragOver = useCallback((e: React.DragEvent) => {
    e.preventDefault();
    setIsDragging(true);
  }, []);

  const handleDragLeave = useCallback((e: React.DragEvent) => {
    e.preventDefault();
    setIsDragging(false);
  }, []);

  const handleDrop = useCallback((e: React.DragEvent) => {
    e.preventDefault();
    setIsDragging(false);

    const file = e.dataTransfer.files[0];
    if (file && validateFile(file)) {
      setSelectedFile(file);
    }
  }, []);

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file && validateFile(file)) {
      setSelectedFile(file);
    }
  };

  const handleUpload = () => {
    if (selectedFile) {
      onFileSelect(selectedFile);
    }
  };

  const handleRemoveFile = () => {
    setSelectedFile(null);
    setError(null);
  };

  return (
    <div className="space-y-6">
      <div className="text-center space-y-2">
        <div className="mx-auto flex size-16 items-center justify-center rounded-full bg-primary/10">
          <span className="material-symbols-outlined text-3xl text-primary">
            upload_file
          </span>
        </div>
        <h3 className="text-xl font-bold text-white">Upload Your CV</h3>
        <p className="text-sm text-gray-400">
          Upload your resume in PDF format to get started
        </p>
      </div>

      {/* Drop Zone */}
      <div
        onDragOver={handleDragOver}
        onDragLeave={handleDragLeave}
        onDrop={handleDrop}
        className={`
          relative rounded-xl border-2 border-dashed p-8 text-center transition-all
          ${isDragging 
            ? "border-primary bg-primary/5" 
            : "border-border-dark hover:border-primary/50 hover:bg-card-dark/50"
          }
          ${selectedFile ? "border-green-500/50 bg-green-500/5" : ""}
        `}
      >
        {selectedFile ? (
          <div className="space-y-4">
            <div className="flex items-center justify-center gap-3">
              <div className="flex size-12 items-center justify-center rounded-lg bg-green-500/10">
                <span className="material-symbols-outlined text-2xl text-green-400">
                  description
                </span>
              </div>
              <div className="text-left">
                <p className="font-medium text-white truncate max-w-[200px]">
                  {selectedFile.name}
                </p>
                <p className="text-xs text-gray-400">
                  {(selectedFile.size / 1024 / 1024).toFixed(2)} MB
                </p>
              </div>
              <button
                onClick={handleRemoveFile}
                className="ml-2 flex size-8 items-center justify-center rounded-full bg-red-500/10 text-red-400 hover:bg-red-500/20 transition-colors"
                disabled={isUploading}
              >
                <span className="material-symbols-outlined text-lg">close</span>
              </button>
            </div>
          </div>
        ) : (
          <div className="space-y-4">
            <div className="mx-auto flex size-12 items-center justify-center rounded-lg bg-[#243047]">
              <span className="material-symbols-outlined text-2xl text-gray-400">
                cloud_upload
              </span>
            </div>
            <div>
              <p className="text-gray-300">
                Drag and drop your CV here, or{" "}
                <label className="text-primary cursor-pointer hover:underline">
                  browse
                  <input
                    type="file"
                    accept=".pdf"
                    onChange={handleFileChange}
                    className="hidden"
                  />
                </label>
              </p>
              <p className="mt-1 text-xs text-gray-500">PDF only, max 10MB</p>
            </div>
          </div>
        )}
      </div>

      {/* Error Message */}
      {error && (
        <div className="flex items-center gap-2 rounded-lg bg-red-500/10 px-4 py-3 text-sm text-red-400">
          <span className="material-symbols-outlined text-lg">error</span>
          {error}
        </div>
      )}

      {/* Upload Button */}
      <button
        onClick={handleUpload}
        disabled={!selectedFile || isUploading}
        className={`
          w-full rounded-lg py-3 text-sm font-bold transition-all
          ${selectedFile && !isUploading
            ? "bg-primary text-white shadow-lg shadow-primary/25 hover:bg-primary/90"
            : "bg-[#243047] text-gray-400 cursor-not-allowed"
          }
        `}
      >
        {isUploading ? (
          <span className="flex items-center justify-center gap-2">
            <span className="material-symbols-outlined animate-spin text-lg">
              progress_activity
            </span>
            Uploading & Analyzing...
          </span>
        ) : (
          "Upload CV"
        )}
      </button>
    </div>
  );
}

