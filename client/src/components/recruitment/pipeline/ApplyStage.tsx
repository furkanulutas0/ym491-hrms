"use client";

import React from "react";
import { motion } from "motion/react";
import { JobApplication } from "@/features/recruitment/types";
import { useTriggerAIReview } from "@/features/recruitment/hooks/use-pipeline";
import StageCard from "./StageCard";
import StageActions from "./StageActions";
import ProgressIndicator from "./ProgressIndicator";

interface ApplyStageProps {
  applications: JobApplication[];
  isLoading: boolean;
  jobId: number;
}

export default function ApplyStage({ applications, isLoading, jobId }: ApplyStageProps) {
  const triggerAIReviewMutation = useTriggerAIReview();

  const handleAdvance = (appId: number) => {
    // Trigger AI review which will automatically move to ai_review stage
    triggerAIReviewMutation.mutate(appId);
  };

  if (isLoading) {
    return (
      <div className="flex items-center justify-center py-12">
        <div className="flex flex-col items-center gap-3">
          <div className="animate-spin h-8 w-8 border-4 border-primary border-t-transparent rounded-full"></div>
          <p className="text-text-secondary-light dark:text-text-secondary-dark">Loading applications...</p>
        </div>
      </div>
    );
  }

  if (applications.length === 0) {
    return (
      <motion.div
        initial={{ opacity: 0, y: 10 }}
        animate={{ opacity: 1, y: 0 }}
        className="flex flex-col items-center gap-4 py-12 text-center"
      >
        <span className="material-symbols-outlined text-6xl text-text-secondary-light dark:text-text-secondary-dark">
          person_search
        </span>
        <div>
          <p className="text-lg font-bold text-text-primary-light dark:text-text-primary-dark">
            No applications yet
          </p>
          <p className="text-sm text-text-secondary-light dark:text-text-secondary-dark">
            Applications will appear here once candidates apply
          </p>
        </div>
      </motion.div>
    );
  }

  return (
    <motion.div
      initial={{ opacity: 0, y: 10 }}
      animate={{ opacity: 1, y: 0 }}
      className="flex flex-col gap-4"
    >
      {applications.map((app) => (
        <StageCard key={app.id} application={app}>
          <div className="flex flex-col gap-4">
            <ProgressIndicator currentStage={app.pipeline_stage} />
            
            <div className="flex justify-between items-center">
              <div>
                <p className="text-sm text-text-secondary-light dark:text-text-secondary-dark">
                  New application received. Ready for AI review.
                </p>
              </div>
              <StageActions
                onAdvance={() => handleAdvance(app.id)}
                advanceLabel="Start AI Review"
                isLoading={triggerAIReviewMutation.isPending}
              />
            </div>
          </div>
        </StageCard>
      ))}
    </motion.div>
  );
}

