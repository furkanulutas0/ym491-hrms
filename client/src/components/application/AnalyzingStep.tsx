"use client";

interface AnalyzingStepProps {
  message?: string;
}

export function AnalyzingStep({ message = "Analyzing your CV..." }: AnalyzingStepProps) {
  return (
    <div className="flex flex-col items-center justify-center py-12 space-y-6">
      {/* Animated Loader */}
      <div className="relative">
        <div className="size-20 rounded-full border-4 border-primary/20"></div>
        <div className="absolute inset-0 size-20 rounded-full border-4 border-transparent border-t-primary animate-spin"></div>
        <div className="absolute inset-0 flex items-center justify-center">
          <span className="material-symbols-outlined text-3xl text-primary animate-pulse">
            psychology
          </span>
        </div>
      </div>

      {/* Message */}
      <div className="text-center space-y-2">
        <h3 className="text-xl font-bold text-white">{message}</h3>
        <p className="text-sm text-gray-400">
          This may take a moment. Please don&apos;t close this window.
        </p>
      </div>

      {/* Progress Steps */}
      <div className="w-full max-w-xs space-y-3">
        <div className="flex items-center gap-3 text-sm">
          <span className="material-symbols-outlined text-green-400">check_circle</span>
          <span className="text-gray-300">CV uploaded successfully</span>
        </div>
        <div className="flex items-center gap-3 text-sm">
          <span className="material-symbols-outlined text-primary animate-pulse">
            pending
          </span>
          <span className="text-gray-300">Extracting information...</span>
        </div>
        <div className="flex items-center gap-3 text-sm">
          <span className="material-symbols-outlined text-gray-500">
            radio_button_unchecked
          </span>
          <span className="text-gray-500">Creating application</span>
        </div>
      </div>
    </div>
  );
}

