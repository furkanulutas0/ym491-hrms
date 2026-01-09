"use client";

import Link from "next/link";

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
            <span>Our AI will review your application and match it to the job requirements.</span>
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
            <span>Track your application progress in the <span className="text-emerald-400 font-medium">Candidate Portal</span>.</span>
          </li>
        </ul>
      </div>

      {/* Candidate Portal CTA */}
      <div className="w-full rounded-xl border border-emerald-500/20 bg-emerald-500/5 p-5">
        <div className="flex items-start gap-4">
          <div className="w-10 h-10 rounded-lg bg-emerald-500/10 flex items-center justify-center shrink-0">
            <span className="material-symbols-outlined text-emerald-400">dashboard</span>
          </div>
          <div className="flex-1">
            <h4 className="text-sm font-semibold text-white mb-1">Track Your Application</h4>
            <p className="text-xs text-gray-400 mb-3">
              Create a free account to track your application status, complete assessments, 
              attend interviews, and upload documents.
            </p>
            <Link
              href="/portal/register"
              className="inline-flex items-center gap-1 text-sm font-medium text-emerald-400 hover:text-emerald-300 transition-colors"
            >
              Go to Candidate Portal
              <span className="material-symbols-outlined text-sm">arrow_forward</span>
            </Link>
          </div>
        </div>
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
