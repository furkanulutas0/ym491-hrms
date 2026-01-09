"use client";

import React from "react";
import { useParams, useRouter } from "next/navigation";
import JobPostingForm from "@/components/recruitment/JobPostingForm";
import { useJob } from "@/features/recruitment/hooks/use-jobs";

export default function EditJobPage() {
  const params = useParams();
  const router = useRouter();
  const jobId = Number(params.id);

  const { data: job, isLoading, error } = useJob(jobId);

  if (isLoading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="flex flex-col items-center gap-4">
          <div className="animate-spin h-8 w-8 border-4 border-primary border-t-transparent rounded-full"></div>
          <p className="text-text-secondary-light dark:text-text-secondary-dark">Loading job details...</p>
        </div>
      </div>
    );
  }

  if (error || !job) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="flex flex-col items-center gap-4 text-center">
          <span className="material-symbols-outlined text-5xl text-red-500">error</span>
          <p className="text-text-primary-light dark:text-text-primary-dark font-bold">Job posting not found</p>
          <button 
            onClick={() => router.back()}
            className="px-4 py-2 bg-primary text-white rounded-lg font-bold hover:bg-primary/90 transition-colors"
          >
            Go Back
          </button>
        </div>
      </div>
    );
  }

  return (
    <div className="flex flex-col gap-8">
      <div className="flex flex-col gap-1">
        <h1 className="text-3xl font-bold tracking-tight text-text-primary-light dark:text-text-primary-dark">
          Edit Job Posting
        </h1>
        <p className="text-text-secondary-light dark:text-text-secondary-dark text-base font-normal">
          Update job details and requirements.
        </p>
      </div>

      <JobPostingForm initialData={job} jobId={jobId} />
    </div>
  );
}

