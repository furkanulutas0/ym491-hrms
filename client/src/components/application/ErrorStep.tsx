"use client";

interface ErrorStepProps {
  error: string;
  onRetry: () => void;
  onClose: () => void;
}

export function ErrorStep({ error, onRetry, onClose }: ErrorStepProps) {
  return (
    <div className="flex flex-col items-center justify-center py-8 space-y-6">
      {/* Error Icon */}
      <div className="size-20 rounded-full bg-red-500/10 flex items-center justify-center">
        <span className="material-symbols-outlined text-4xl text-red-400">
          error
        </span>
      </div>

      {/* Message */}
      <div className="text-center space-y-3">
        <h3 className="text-xl font-bold text-white">Something Went Wrong</h3>
        <p className="text-sm text-gray-400 max-w-sm">
          We encountered an error while processing your application. Please try again.
        </p>
        {error && (
          <div className="mt-4 rounded-lg bg-red-500/10 px-4 py-3 text-sm text-red-400 text-left">
            <p className="font-medium mb-1">Error details:</p>
            <p className="text-xs opacity-80">{error}</p>
          </div>
        )}
      </div>

      {/* Action Buttons */}
      <div className="flex w-full gap-3">
        <button
          onClick={onClose}
          className="flex-1 rounded-lg bg-[#243047] py-3 text-sm font-bold text-gray-300 transition-colors hover:bg-[#2f3e5b]"
        >
          Cancel
        </button>
        <button
          onClick={onRetry}
          className="flex-1 rounded-lg bg-primary py-3 text-sm font-bold text-white shadow-lg shadow-primary/25 transition-all hover:bg-primary/90"
        >
          Try Again
        </button>
      </div>
    </div>
  );
}

