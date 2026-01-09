"use client";

import { useState, useCallback, useEffect } from "react";
import { CVUploadStep } from "./CVUploadStep";
import { CoverageResultStep } from "./CoverageResultStep";
import { MissingFieldsForm } from "./MissingFieldsForm";
import { AnalyzingStep } from "./AnalyzingStep";
import { SuccessStep } from "./SuccessStep";
import { ErrorStep } from "./ErrorStep";
import {
  useUploadAndCheckCoverage,
  useAnalyzeCV,
  useCreateApplication,
} from "@/features/applications/hooks/use-application";
import type {
  ApplicationStep,
  CoverageResponse,
  AdditionalFields,
  AnalyzedCVData,
} from "@/features/applications/types";

interface ApplicationModalProps {
  isOpen: boolean;
  onClose: () => void;
  jobId: number;
  jobTitle: string;
}

export function ApplicationModal({
  isOpen,
  onClose,
  jobId,
  jobTitle,
}: ApplicationModalProps) {
  const [step, setStep] = useState<ApplicationStep>("upload");
  const [fileUrl, setFileUrl] = useState<string>("");
  const [coverage, setCoverage] = useState<CoverageResponse | null>(null);
  const [analyzedData, setAnalyzedData] = useState<AnalyzedCVData | null>(null);
  const [error, setError] = useState<string>("");

  const uploadMutation = useUploadAndCheckCoverage();
  const analyzeMutation = useAnalyzeCV();
  const createApplicationMutation = useCreateApplication();

  // Reset state when modal closes
  useEffect(() => {
    if (!isOpen) {
      setStep("upload");
      setFileUrl("");
      setCoverage(null);
      setAnalyzedData(null);
      setError("");
    }
  }, [isOpen]);

  const handleFileSelect = useCallback(
    async (file: File) => {
      setStep("checking");
      setError("");

      try {
        const result = await uploadMutation.mutateAsync(file);

        if (result.success && result.coverage) {
          setFileUrl(result.file_url);
          setCoverage(result.coverage);

          // If coverage is high enough, go directly to analysis
          if (result.coverage.cover_rate >= 80) {
            setStep("coverage-result");
          } else {
            setStep("coverage-result");
          }
        } else {
          setError(result.error || "Failed to check CV coverage");
          setStep("error");
        }
      } catch (err) {
        setError(err instanceof Error ? err.message : "An error occurred");
        setStep("error");
      }
    },
    [uploadMutation]
  );

  const handleContinueToAnalysis = useCallback(
    async (additionalFields?: AdditionalFields) => {
      setStep("analyzing");
      setError("");

      try {
        const result = await analyzeMutation.mutateAsync({
          fileUrl,
          additionalFields,
        });

        if (result.success && result.data) {
          setAnalyzedData(result.data);

          // Create the application
          const candidateName = result.data.full_name || "Candidate";
          const email = result.data.email || "";
          const phone = result.data.phone;
          const linkedinUrl = result.data.linkedin_url;

          await createApplicationMutation.mutateAsync({
            job_posting_id: jobId,
            candidate_name: candidateName,
            email: email,
            phone: phone,
            resume_url: fileUrl,
            linkedin_url: linkedinUrl,
            source: "Career Page",
            analyzed_cv_data: result.data, // Pass the analyzed data so it can be saved
          });

          setStep("success");
        } else {
          setError(result.error || "Failed to analyze CV");
          setStep("error");
        }
      } catch (err) {
        setError(err instanceof Error ? err.message : "An error occurred");
        setStep("error");
      }
    },
    [analyzeMutation, createApplicationMutation, fileUrl, jobId]
  );

  const handleFillMissingFields = useCallback(() => {
    setStep("missing-fields");
  }, []);

  const handleMissingFieldsSubmit = useCallback(
    (fields: AdditionalFields) => {
      handleContinueToAnalysis(fields);
    },
    [handleContinueToAnalysis]
  );

  const handleRetry = useCallback(() => {
    if (coverage && fileUrl) {
      setStep("coverage-result");
    } else {
      setStep("upload");
    }
    setError("");
  }, [coverage, fileUrl]);

  const handleClose = useCallback(() => {
    onClose();
  }, [onClose]);

  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      {/* Backdrop */}
      <div
        className="absolute inset-0 bg-black/60 backdrop-blur-sm"
        onClick={step === "success" || step === "upload" ? handleClose : undefined}
      />

      {/* Modal */}
      <div className="relative w-full max-w-lg mx-4 max-h-[90vh] overflow-y-auto rounded-2xl border border-border-dark bg-card-dark shadow-2xl">
        {/* Header */}
        <div className="sticky top-0 z-10 flex items-center justify-between border-b border-border-dark bg-card-dark px-6 py-4">
          <div>
            <h2 className="text-lg font-bold text-white">Apply for Position</h2>
            <p className="text-sm text-gray-400 truncate max-w-[280px]">
              {jobTitle}
            </p>
          </div>
          <button
            onClick={handleClose}
            className="flex size-8 items-center justify-center rounded-full bg-[#243047] text-gray-400 hover:bg-[#2f3e5b] hover:text-white transition-colors"
          >
            <span className="material-symbols-outlined text-lg">close</span>
          </button>
        </div>

        {/* Progress Indicator */}
        {step !== "success" && step !== "error" && (
          <div className="px-6 pt-4">
            <div className="flex items-center gap-2">
              {["upload", "checking", "coverage-result", "missing-fields", "analyzing"].map(
                (s, i) => {
                  const steps: ApplicationStep[] = [
                    "upload",
                    "checking",
                    "coverage-result",
                    "missing-fields",
                    "analyzing",
                  ];
                  const currentIndex = steps.indexOf(step);
                  const isActive = i === currentIndex;
                  const isCompleted = i < currentIndex;

                  // Skip missing-fields if not in that path
                  if (s === "missing-fields" && step !== "missing-fields") {
                    return null;
                  }

                  return (
                    <div key={s} className="flex items-center gap-2">
                      <div
                        className={`size-2 rounded-full transition-colors ${
                          isCompleted
                            ? "bg-primary"
                            : isActive
                            ? "bg-primary animate-pulse"
                            : "bg-gray-600"
                        }`}
                      />
                      {i < steps.length - 1 && s !== "missing-fields" && (
                        <div
                          className={`h-0.5 w-8 transition-colors ${
                            isCompleted ? "bg-primary" : "bg-gray-600"
                          }`}
                        />
                      )}
                    </div>
                  );
                }
              )}
            </div>
          </div>
        )}

        {/* Content */}
        <div className="p-6">
          {step === "upload" && (
            <CVUploadStep
              onFileSelect={handleFileSelect}
              isUploading={uploadMutation.isPending}
            />
          )}

          {step === "checking" && (
            <AnalyzingStep message="Checking CV coverage..." />
          )}

          {step === "coverage-result" && coverage && (
            <CoverageResultStep
              coverage={coverage}
              onContinue={() => handleContinueToAnalysis()}
              onFillMissingFields={handleFillMissingFields}
            />
          )}

          {step === "missing-fields" && coverage && (
            <MissingFieldsForm
              coverageDetails={coverage.details}
              onSubmit={handleMissingFieldsSubmit}
              onBack={() => setStep("coverage-result")}
              isSubmitting={analyzeMutation.isPending || createApplicationMutation.isPending}
            />
          )}

          {step === "analyzing" && (
            <AnalyzingStep message="Processing your application..." />
          )}

          {step === "success" && (
            <SuccessStep
              candidateName={analyzedData?.full_name || "Candidate"}
              jobTitle={jobTitle}
              onClose={handleClose}
            />
          )}

          {step === "error" && (
            <ErrorStep
              error={error}
              onRetry={handleRetry}
              onClose={handleClose}
            />
          )}
        </div>
      </div>
    </div>
  );
}

