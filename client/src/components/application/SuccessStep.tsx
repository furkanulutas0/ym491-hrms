"use client";

interface SuccessStepProps {
  candidateName: string;
  jobTitle: string;
  onClose: () => void;
}

export function SuccessStep({ candidateName, jobTitle, onClose }: SuccessStepProps) {
  return (
    <div className="flex flex-col items-center justify-center py-8 space-y-6">
      {/* Success Animation */}
      <div className="relative">
        <div className="size-24 rounded-full bg-green-500/10 flex items-center justify-center animate-[scale-in_0.3s_ease-out]">
          <span className="material-symbols-outlined text-5xl text-green-400">
            check_circle
          </span>
        </div>
        {/* Confetti-like decorations */}
        <div className="absolute -top-2 -left-2 size-4 rounded-full bg-primary/60 animate-ping"></div>
        <div className="absolute -top-1 -right-3 size-3 rounded-full bg-green-400/60 animate-ping delay-100"></div>
        <div className="absolute -bottom-2 -right-1 size-3 rounded-full bg-amber-400/60 animate-ping delay-200"></div>
      </div>

      {/* Message */}
      <div className="text-center space-y-3">
        <h3 className="text-2xl font-bold text-white">Application Submitted!</h3>
        <p className="text-gray-400 max-w-sm">
          Thank you, <span className="text-white font-medium">{candidateName}</span>! 
          Your application for{" "}
          <span className="text-primary font-medium">{jobTitle}</span> has been 
          successfully submitted.
        </p>
      </div>

      {/* What's Next */}
      <div className="w-full rounded-xl border border-border-dark bg-card-dark/50 p-5 space-y-4">
        <h4 className="text-sm font-semibold text-gray-300 flex items-center gap-2">
          <span className="material-symbols-outlined text-primary text-lg">
            arrow_forward
          </span>
          What&apos;s Next?
        </h4>
        <ul className="space-y-3 text-sm text-gray-400">
          <li className="flex items-start gap-3">
            <span className="mt-0.5 flex size-5 items-center justify-center rounded-full bg-primary/10 text-xs font-bold text-primary">
              1
            </span>
            <span>Our team will review your application within 5-7 business days.</span>
          </li>
          <li className="flex items-start gap-3">
            <span className="mt-0.5 flex size-5 items-center justify-center rounded-full bg-primary/10 text-xs font-bold text-primary">
              2
            </span>
            <span>You&apos;ll receive an email confirmation shortly.</span>
          </li>
          <li className="flex items-start gap-3">
            <span className="mt-0.5 flex size-5 items-center justify-center rounded-full bg-primary/10 text-xs font-bold text-primary">
              3
            </span>
            <span>If shortlisted, we&apos;ll contact you to schedule an interview.</span>
          </li>
        </ul>
      </div>

      {/* Close Button */}
      <button
        onClick={onClose}
        className="w-full rounded-lg bg-primary py-3 text-sm font-bold text-white shadow-lg shadow-primary/25 transition-all hover:bg-primary/90"
      >
        Done
      </button>
    </div>
  );
}

