"use client";

import React from "react";

interface StageActionsProps {
  onApprove?: () => void;
  onReject?: () => void;
  onAdvance?: () => void;
  approveLabel?: string;
  rejectLabel?: string;
  advanceLabel?: string;
  isLoading?: boolean;
  disabled?: boolean;
  disabledReason?: string;
}

export default function StageActions({
  onApprove,
  onReject,
  onAdvance,
  approveLabel = "Approve",
  rejectLabel = "Reject",
  advanceLabel = "Move to Next Stage",
  isLoading = false,
  disabled = false,
  disabledReason,
}: StageActionsProps) {
  const isAdvanceDisabled = isLoading || disabled;

  return (
    <div className="flex flex-wrap items-center gap-2">
      {onAdvance && (
        <div className="relative group">
          <button
            onClick={onAdvance}
            disabled={isAdvanceDisabled}
            className="flex items-center gap-2 px-4 py-2 bg-primary text-white rounded-lg text-sm font-bold hover:bg-primary/90 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
          >
            <span className="material-symbols-outlined text-lg">arrow_forward</span>
            {advanceLabel}
          </button>
          {disabled && disabledReason && (
            <div className="absolute bottom-full left-1/2 -translate-x-1/2 mb-2 px-3 py-2 bg-gray-900 text-white text-xs rounded-lg whitespace-nowrap opacity-0 group-hover:opacity-100 transition-opacity pointer-events-none z-10">
              {disabledReason}
              <div className="absolute top-full left-1/2 -translate-x-1/2 border-4 border-transparent border-t-gray-900"></div>
            </div>
          )}
        </div>
      )}
      
      {onApprove && (
        <button
          onClick={onApprove}
          disabled={isLoading}
          className="flex items-center gap-2 px-4 py-2 bg-green-500 text-white rounded-lg text-sm font-bold hover:bg-green-600 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
        >
          <span className="material-symbols-outlined text-lg">check_circle</span>
          {approveLabel}
        </button>
      )}
      
      {onReject && (
        <button
          onClick={onReject}
          disabled={isLoading}
          className="flex items-center gap-2 px-4 py-2 bg-red-500 text-white rounded-lg text-sm font-bold hover:bg-red-600 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
        >
          <span className="material-symbols-outlined text-lg">cancel</span>
          {rejectLabel}
        </button>
      )}
    </div>
  );
}
