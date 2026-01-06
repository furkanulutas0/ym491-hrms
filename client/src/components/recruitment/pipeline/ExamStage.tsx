"use client";

import React, { useState } from "react";
import { motion } from "motion/react";
import { JobApplication } from "@/features/recruitment/types";
import { useAssignExamV2, useAdvanceApplication } from "@/features/recruitment/hooks/use-pipeline";
import StageCard from "./StageCard";
import StageActions from "./StageActions";
import ProgressIndicator from "./ProgressIndicator";

interface ExamStageProps {
  applications: JobApplication[];
  isLoading: boolean;
  jobId: number;
}

export default function ExamStage({ applications, isLoading, jobId }: ExamStageProps) {
  const assignExamMutation = useAssignExamV2();
  const advanceMutation = useAdvanceApplication();
  const [showAssignModal, setShowAssignModal] = useState<number | null>(null);
  const [examId, setExamId] = useState("");
  const [dueDate, setDueDate] = useState("");
  const [copiedCode, setCopiedCode] = useState<string | null>(null);

  const handleAssignExam = (appId: number) => {
    if (!examId.trim()) {
      alert("Please enter an Exam ID");
      return;
    }
    assignExamMutation.mutate({
      appId,
      examData: {
        platform: "LOOP Assessment",
        exam_id: examId,
        due_date: dueDate || undefined,
        instructions: "Complete the exam using the access code provided"
      }
    }, {
      onSuccess: () => {
        setExamId("");
        setDueDate("");
        setShowAssignModal(null);
      },
      onError: (error: any) => {
        alert(`Failed to assign exam: ${error.message || 'Unknown error'}`);
      }
    });
  };

  const handleAdvance = (appId: number) => {
    advanceMutation.mutate({
      appId,
      stageUpdate: { stage: "ai_interview", notes: "Exam completed successfully" }
    });
  };
  const copyAccessCode = (code: string) => {
    navigator.clipboard.writeText(code);
    setCopiedCode(code);
    setTimeout(() => setCopiedCode(null), 2000);
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
          quiz
        </span>
        <div>
          <p className="text-lg font-bold text-text-primary-light dark:text-text-primary-dark">
            No applications in exam stage
          </p>
          <p className="text-sm text-text-secondary-light dark:text-text-secondary-dark">
            Applications will appear here after AI review approval
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
      {applications.map((app) => {
        const hasExam = app.exam_assigned;
        const examStarted = app.exam_started_at !== null;
        const examCompleted = app.exam_completed_at !== null;
        const examGraded = app.exam_finalized_score !== null;

        return (
          <StageCard key={app.id} application={app}>
            <div className="flex flex-col gap-4">
              <ProgressIndicator currentStage={app.pipeline_stage} />
              
              {/* Exam Status */}
              <div className="bg-background-light dark:bg-background-dark rounded-lg p-4">
                {!hasExam ? (
                  <div className="flex items-center justify-between">
                    <div>
                      <p className="text-sm font-bold text-text-primary-light dark:text-text-primary-dark mb-1">
                        Ready to assign exam
                      </p>
                      <p className="text-xs text-text-secondary-light dark:text-text-secondary-dark">
                        Assign a technical assessment to evaluate candidate skills
                      </p>
                    </div>
                    <button
                      onClick={() => setShowAssignModal(app.id)}
                      className="px-4 py-2 bg-primary text-white rounded-lg text-sm font-bold hover:bg-primary/90 transition-colors"
                    >
                      Assign Exam
                    </button>
                  </div>
                  ): !examStarted ? (
                    <div>
                      <p className="text-sm font-bold text-text-primary-light dark:text-text-primary-dark mb-3">
                        Exam Assigned - Waiting for Candidate
                      </p>
                      
                      {/* Access Code Display */}
                      {app.exam_access_code && (
                        <div className="bg-card-light dark:bg-card-dark rounded-lg p-4 border-2 border-dashed border-primary/50 mb-3">
                          <p className="text-xs text-text-secondary-light dark:text-text-secondary-dark mb-2">
                            Candidate Access Code:
                          </p>
                          <div className="flex items-center gap-3">
                            <code className="text-2xl font-mono font-bold tracking-widest text-primary">
                              {app.exam_access_code}
                            </code>
                            <button
                              onClick={() => copyAccessCode(app.exam_access_code!)}
                              className="px-3 py-1 bg-primary/10 text-primary rounded-lg text-sm font-bold hover:bg-primary/20 transition-colors flex items-center gap-1"
                            >
                              <span className="material-symbols-outlined text-sm">
                                {copiedCode === app.exam_access_code ? 'check' : 'content_copy'}
                              </span>
                              {copiedCode === app.exam_access_code ? 'Copied!' : 'Copy'}
                            </button>
                          </div>
                          <p className="text-xs text-text-secondary-light dark:text-text-secondary-dark mt-2">
                            Share this code with the candidate to access the exam at <span className="font-mono text-primary">/candidate</span>
                          </p>
                        </div>
                      )}
                      
                      <div className="flex items-center gap-2 text-sm text-text-secondary-light dark:text-text-secondary-dark">
                        <span className="material-symbols-outlined text-sm text-yellow-500 animate-pulse">
                          hourglass_empty
                        </span>
                        Waiting for candidate to start the exam...
                      </div>
                    </div>
                ) : !examCompleted ? (
                  <div>
                    <p className="text-sm font-bold text-text-primary-light dark:text-text-primary-dark mb-2">
                    Exam In Progress
                    </p>
                    <div className="flex items-center gap-2 text-sm text-blue-600 dark:text-blue-400">
                      <span className="material-symbols-outlined text-sm animate-spin">
                        refresh
                      </span>
                      Candidate is taking the exam...
                    </div>
                    {app.exam_started_at && (
                      <p className="text-xs text-text-secondary-light dark:text-text-secondary-dark mt-2">
                        Started: {new Date(app.exam_started_at).toLocaleString()}
                      </p>
                                        )}
                                        </div>
                                      ) : !examGraded ? (
                                        <div>
                                          <p className="text-sm font-bold text-text-primary-light dark:text-text-primary-dark mb-2">
                                            Exam Submitted - Awaiting Grading
                                          </p>
                                          <div className="flex items-center gap-2 text-sm text-orange-600 dark:text-orange-400">
                                            <span className="material-symbols-outlined text-sm">
                                              rate_review
                                            </span>
                                            Exam needs to be graded in the exam system
                                          </div>
                                          <p className="text-xs text-text-secondary-light dark:text-text-secondary-dark mt-2">
                                            Submitted: {new Date(app.exam_completed_at!).toLocaleString()}
                                          </p>
                  </div>
                ) : (
                  <div>
                    <p className="text-sm font-bold text-text-primary-light dark:text-text-primary-dark mb-2">
                    Exam Graded
                    </p>
                    <div className="space-y-2">
                      <div className="flex items-center gap-2">
                        <span className="text-sm font-bold text-text-secondary-light dark:text-text-secondary-dark">
                          Score:
                        </span>
                        <div className={`px-3 py-1 rounded-full font-bold ${
                          (app.exam_finalized_score || app.exam_score || 0) >= 70
                            ? "bg-green-100 dark:bg-green-900 text-green-800 dark:text-green-200"
                            : (app.exam_finalized_score || app.exam_score || 0) >= 50
                            ? "bg-yellow-100 dark:bg-yellow-900 text-yellow-800 dark:text-yellow-200"
                            : "bg-red-100 dark:bg-red-900 text-red-800 dark:text-red-200"
                        }`}>
                          {app.exam_finalized_score || app.exam_score}%
                        </div>
                      </div>
                      <p className="text-xs text-text-secondary-light dark:text-text-secondary-dark">
                      Completed: {new Date(app.exam_completed_at!).toLocaleString()}
                      </p>
                    </div>
                  </div>
                )}
              </div>

              {/* Assign Exam Modal */}
              {showAssignModal === app.id && (
                <div className="bg-background-light dark:bg-background-dark rounded-lg p-4 border-2 border-primary">
                  <p className="text-sm font-bold text-text-primary-light dark:text-text-primary-dark mb-3">
                    Assign Technical Exam
                  </p>
                  <div className="space-y-3">
                    <div>
                      <label className="text-xs text-text-secondary-light dark:text-text-secondary-dark mb-1 block">
                      Exam ID (from LOOP Assessment System)
                      </label>
                      <input
                        type="text"
                        value={examId}
                        onChange={(e) => setExamId(e.target.value)}
                        placeholder="e.g., clx123abc456..."
                        className="w-full px-3 py-2 rounded-lg border border-border-light dark:border-border-dark bg-card-light dark:bg-card-dark text-text-primary-light dark:text-text-primary-dark text-sm"
                      />
                      <p className="text-xs text-text-secondary-light dark:text-text-secondary-dark mt-1">
                        Get this from the exam management dashboard
                      </p>
                    </div>
                    <div>
                      <label className="text-xs text-text-secondary-light dark:text-text-secondary-dark mb-1 block">
                      Due Date (Optional)
                      </label>
                      <input
                        type="datetime-local"
                        value={dueDate}
                        onChange={(e) => setDueDate(e.target.value)}
                        className="w-full px-3 py-2 rounded-lg border border-border-light dark:border-border-dark bg-card-light dark:bg-card-dark text-text-primary-light dark:text-text-primary-dark text-sm"
                      />
                    </div>
                    <div className="flex gap-2">
                      <button
                        onClick={() => handleAssignExam(app.id)}
                        disabled={assignExamMutation.isPending}
                        className="flex-1 px-4 py-2 bg-primary text-white rounded-lg text-sm font-bold hover:bg-primary/90 disabled:opacity-50 disabled:cursor-not-allowed"
                      >
                         {assignExamMutation.isPending ? 'Assigning...' : 'Assign Exam'}
                      </button>
                      <button
                                                onClick={() => {
                                                  setShowAssignModal(null);
                                                  setExamId("");
                                                  setDueDate("");
                                                }}
                        className="px-4 py-2 bg-background-light dark:bg-background-dark border border-border-light dark:border-border-dark rounded-lg text-sm font-bold"
                      >
                        Cancel
                      </button>
                    </div>
                  </div>
                </div>
              )}

              {/* Actions */}
              {examGraded && (
                <div className="flex justify-end">
                  <StageActions
                    onAdvance={() => handleAdvance(app.id)}
                    advanceLabel="Schedule Interview"
                    isLoading={advanceMutation.isPending}
                  />
                </div>
              )}
            </div>
          </StageCard>
        );
      })}
    </motion.div>
  );
}


