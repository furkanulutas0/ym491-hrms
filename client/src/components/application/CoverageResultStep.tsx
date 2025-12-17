"use client";

import type { CoverageResponse, CoverageDetails } from "@/features/applications/types";

interface CoverageResultStepProps {
  coverage: CoverageResponse;
  onContinue: () => void;
  onFillMissingFields: () => void;
}

// Helper to get fillable missing fields
function getFillableMissingFields(details: CoverageDetails): string[] {
  const fillable: string[] = [];
  
  // Personal information
  if (details.personal_information?.missing_fields) {
    details.personal_information.missing_fields.forEach(field => {
      if (field.includes('city') || field.includes('country')) {
        fillable.push(field);
      }
    });
  }
  
  // Skills - languages
  if (details.skills?.missing_fields?.includes('languages')) {
    fillable.push('languages');
  }
  
  // Additional information
  if (details.additional_information?.missing_fields) {
    fillable.push(...details.additional_information.missing_fields);
  }
  
  return fillable;
}

// Format field name for display
function formatFieldName(field: string): string {
  return field
    .replace(/_/g, ' ')
    .replace(/\./g, ' - ')
    .replace(/\b\w/g, l => l.toUpperCase());
}

export function CoverageResultStep({
  coverage,
  onContinue,
  onFillMissingFields,
}: CoverageResultStepProps) {
  const isHighCoverage = coverage.cover_rate >= 80;
  const fillableFields = getFillableMissingFields(coverage.details);
  const hasFillableFields = fillableFields.length > 0;

  return (
    <div className="space-y-6">
      {/* Coverage Score */}
      <div className="text-center space-y-4">
        <div
          className={`mx-auto flex size-20 items-center justify-center rounded-full ${
            isHighCoverage ? "bg-green-500/10" : "bg-amber-500/10"
          }`}
        >
          <span
            className={`material-symbols-outlined text-4xl ${
              isHighCoverage ? "text-green-400" : "text-amber-400"
            }`}
          >
            {isHighCoverage ? "check_circle" : "info"}
          </span>
        </div>
        <div>
          <h3 className="text-xl font-bold text-white">CV Analysis Complete</h3>
          <p className="mt-1 text-sm text-gray-400">
            Your CV coverage score is
          </p>
          <p
            className={`mt-2 text-4xl font-black ${
              isHighCoverage ? "text-green-400" : "text-amber-400"
            }`}
          >
            {coverage.cover_rate.toFixed(0)}%
          </p>
        </div>
      </div>

      {/* Breakdown */}
      <div className="rounded-xl border border-border-dark bg-card-dark/50 p-4">
        <h4 className="mb-3 text-sm font-semibold text-gray-300">
          Coverage Breakdown
        </h4>
        <div className="grid grid-cols-2 gap-2 text-xs">
          {Object.entries(coverage.breakdown).map(([key, value]) => (
            <div
              key={key}
              className="flex items-center justify-between rounded-lg bg-background-dark/50 px-3 py-2"
            >
              <span className="text-gray-400 capitalize">
                {key.replace(/_/g, " ")}
              </span>
              <span
                className={`font-medium ${
                  value > 0 ? "text-green-400" : "text-gray-500"
                }`}
              >
                {value > 0 ? `+${value}` : "0"}
              </span>
            </div>
          ))}
        </div>
      </div>

      {/* Missing Fields Notice */}
      {!isHighCoverage && hasFillableFields && (
        <div className="rounded-xl border border-amber-500/20 bg-amber-500/5 p-4">
          <div className="flex items-start gap-3">
            <span className="material-symbols-outlined text-amber-400 shrink-0">
              lightbulb
            </span>
            <div className="space-y-2">
              <p className="text-sm text-amber-200">
                You can improve your application by providing some additional information:
              </p>
              <ul className="space-y-1">
                {fillableFields.slice(0, 5).map((field) => (
                  <li
                    key={field}
                    className="flex items-center gap-2 text-xs text-gray-400"
                  >
                    <span className="size-1 rounded-full bg-amber-400"></span>
                    {formatFieldName(field)}
                  </li>
                ))}
                {fillableFields.length > 5 && (
                  <li className="text-xs text-gray-500">
                    +{fillableFields.length - 5} more fields
                  </li>
                )}
              </ul>
            </div>
          </div>
        </div>
      )}

      {/* Action Buttons */}
      <div className="space-y-3">
        {isHighCoverage ? (
          <button
            onClick={onContinue}
            className="w-full rounded-lg bg-primary py-3 text-sm font-bold text-white shadow-lg shadow-primary/25 transition-all hover:bg-primary/90"
          >
            Continue with Application
          </button>
        ) : (
          <>
            {hasFillableFields && (
              <button
                onClick={onFillMissingFields}
                className="w-full rounded-lg bg-primary py-3 text-sm font-bold text-white shadow-lg shadow-primary/25 transition-all hover:bg-primary/90"
              >
                Fill Missing Information
              </button>
            )}
            <button
              onClick={onContinue}
              className={`w-full rounded-lg py-3 text-sm font-bold transition-all ${
                hasFillableFields
                  ? "bg-[#243047] text-gray-300 hover:bg-[#2f3e5b]"
                  : "bg-primary text-white shadow-lg shadow-primary/25 hover:bg-primary/90"
              }`}
            >
              {hasFillableFields ? "Skip & Continue Anyway" : "Continue with Application"}
            </button>
          </>
        )}
      </div>
    </div>
  );
}

