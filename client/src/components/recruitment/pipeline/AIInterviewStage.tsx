"use client";

import React, { useState } from "react";
import { motion, AnimatePresence } from "motion/react";
import { JobApplication } from "@/features/recruitment/types";
import { useScheduleInterview, useAdvanceApplication, useSimulateInterviewComplete } from "@/features/recruitment/hooks/use-pipeline";
import StageCard from "./StageCard";
import StageActions from "./StageActions";
import ProgressIndicator from "./ProgressIndicator";

interface AIInterviewStageProps {
  applications: JobApplication[];
  isLoading: boolean;
  jobId: number;
}

// Mock interview results for simulation
const generateMockInterviewResults = () => {
  const scores = {
    communication: Math.floor(Math.random() * 30) + 70,
    technicalKnowledge: Math.floor(Math.random() * 35) + 65,
    problemSolving: Math.floor(Math.random() * 30) + 70,
    enthusiasm: Math.floor(Math.random() * 25) + 75,
    cultureFit: Math.floor(Math.random() * 30) + 70,
  };
  
  const overallScore = Math.round(
    (scores.communication + scores.technicalKnowledge + scores.problemSolving + scores.enthusiasm + scores.cultureFit) / 5
  );

  const strengths = [
    "Clear and articulate communication style",
    "Demonstrates strong understanding of core concepts",
    "Shows genuine enthusiasm for the role",
    "Provides thoughtful and structured responses",
    "Exhibits strong analytical thinking"
  ].sort(() => Math.random() - 0.5).slice(0, 3);

  const improvements = [
    "Could elaborate more on specific examples",
    "Consider providing more quantifiable achievements",
    "Could better highlight leadership experiences",
    "May benefit from more concise answers"
  ].sort(() => Math.random() - 0.5).slice(0, 2);

  return { scores, overallScore, strengths, improvements };
};

export default function AIInterviewStage({ applications, isLoading, jobId }: AIInterviewStageProps) {
  const scheduleInterviewMutation = useScheduleInterview();
  const advanceMutation = useAdvanceApplication();
  const simulateCompleteMutation = useSimulateInterviewComplete();
  
  const [showScheduleModal, setShowScheduleModal] = useState<number | null>(null);
  const [selectedInterviewType, setSelectedInterviewType] = useState<'video' | 'voice'>('video');
  const [scheduledDateTime, setScheduledDateTime] = useState('');
  const [simulatingInterview, setSimulatingInterview] = useState<number | null>(null);
  const [mockResults, setMockResults] = useState<Record<number, ReturnType<typeof generateMockInterviewResults>>>({});

  const handleScheduleInterview = (appId: number) => {
    const dateTime = scheduledDateTime || new Date(Date.now() + 24 * 60 * 60 * 1000).toISOString();
    scheduleInterviewMutation.mutate({
      appId,
      interviewData: {
        interview_type: selectedInterviewType,
        scheduled_at: dateTime,
        duration_minutes: 30,
        instructions: `Your ${selectedInterviewType === 'video' ? 'video' : 'voice'} AI interview has been scheduled. Please join on time.`
      }
    });
    setShowScheduleModal(null);
    setSelectedInterviewType('video');
    setScheduledDateTime('');
  };

  const handleSimulateInterview = async (appId: number) => {
    setSimulatingInterview(appId);
    
    // Simulate interview process with staged updates
    await new Promise(resolve => setTimeout(resolve, 1500));
    
    // Generate mock results
    const results = generateMockInterviewResults();
    setMockResults(prev => ({ ...prev, [appId]: results }));
    
    // Complete the interview in backend
    await simulateCompleteMutation.mutateAsync(appId);
    
    setSimulatingInterview(null);
  };

  const handleAdvance = (appId: number) => {
    advanceMutation.mutate({
      appId,
      stageUpdate: { stage: "cv_verification", notes: "Interview completed, ready for verification" }
    });
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
          video_chat
        </span>
        <div>
          <p className="text-lg font-bold text-text-primary-light dark:text-text-primary-dark">
            No applications in interview stage
          </p>
          <p className="text-sm text-text-secondary-light dark:text-text-secondary-dark">
            Applications will appear here after completing the exam
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
        const isScheduled = app.ai_interview_scheduled_at !== null;
        const isCompleted = app.ai_interview_completed_at !== null;
        const isSimulating = simulatingInterview === app.id;
        const interviewResults = mockResults[app.id];

        return (
          <StageCard key={app.id} application={app}>
            <div className="flex flex-col gap-4">
              <ProgressIndicator currentStage={app.pipeline_stage} />
              
              {/* Interview Status */}
              <div className="bg-background-light dark:bg-background-dark rounded-lg p-4">
                {!isScheduled ? (
                  <div className="flex items-center justify-between">
                    <div>
                      <p className="text-sm font-bold text-text-primary-light dark:text-text-primary-dark mb-1">
                        Ready to schedule AI interview
                      </p>
                      <p className="text-xs text-text-secondary-light dark:text-text-secondary-dark">
                        Choose between video or voice AI interview
                      </p>
                    </div>
                    <button
                      onClick={() => setShowScheduleModal(app.id)}
                      className="px-4 py-2 bg-primary text-white rounded-lg text-sm font-bold hover:bg-primary/90 transition-colors"
                    >
                      Schedule Interview
                    </button>
                  </div>
                ) : !isCompleted ? (
                  <div className="space-y-4">
                    <div>
                      <p className="text-sm font-bold text-text-primary-light dark:text-text-primary-dark mb-2">
                        Interview Scheduled
                      </p>
                      <div className="space-y-1 text-sm text-text-secondary-light dark:text-text-secondary-dark">
                        <p className="flex items-center gap-2">
                          <span className="material-symbols-outlined text-sm">
                            {app.ai_interview_type === 'video' ? 'videocam' : 'mic'}
                          </span>
                          Type: {app.ai_interview_type === 'video' ? 'Video Interview' : 'Voice Chat'}
                        </p>
                        <p className="flex items-center gap-2">
                          <span className="material-symbols-outlined text-sm">schedule</span>
                          Scheduled: {new Date(app.ai_interview_scheduled_at!).toLocaleString()}
                        </p>
                        <p className="flex items-center gap-2 text-yellow-600 dark:text-yellow-400">
                          <span className="material-symbols-outlined text-sm">pending</span>
                          Waiting for candidate...
                        </p>
                      </div>
                    </div>

                    {/* Simulation Controls */}
                    <div className="border-t border-border-light dark:border-border-dark pt-4">
                      <div className="flex items-center gap-2 mb-3">
                        <span className="material-symbols-outlined text-sm text-primary">science</span>
                        <p className="text-xs font-bold text-primary uppercase tracking-wide">
                          Simulation Mode
                        </p>
                      </div>
                      
                      {isSimulating ? (
                        <div className="bg-primary/10 rounded-lg p-4">
                          <div className="flex items-center gap-3 mb-3">
                            <div className="relative">
                              <div className="w-10 h-10 rounded-full bg-primary/20 flex items-center justify-center">
                                <span className="material-symbols-outlined text-primary animate-pulse">
                                  {app.ai_interview_type === 'video' ? 'videocam' : 'mic'}
                                </span>
                              </div>
                              <div className="absolute -top-1 -right-1 w-3 h-3 bg-red-500 rounded-full animate-pulse"></div>
                            </div>
                            <div>
                              <p className="text-sm font-bold text-text-primary-light dark:text-text-primary-dark">
                                Simulating AI Interview...
                              </p>
                              <p className="text-xs text-text-secondary-light dark:text-text-secondary-dark">
                                Generating mock responses and analysis
                              </p>
                            </div>
                          </div>
                          
                          <div className="space-y-2">
                            <div className="flex items-center gap-2">
                              <div className="w-4 h-4 border-2 border-primary border-t-transparent rounded-full animate-spin"></div>
                              <span className="text-xs text-text-secondary-light dark:text-text-secondary-dark">
                                Analyzing candidate responses...
                              </span>
                            </div>
                          </div>
                        </div>
                      ) : (
                        <button
                          onClick={() => handleSimulateInterview(app.id)}
                          disabled={simulateCompleteMutation.isPending}
                          className="w-full flex items-center justify-center gap-2 px-4 py-3 bg-gradient-to-r from-violet-500 to-purple-500 text-white rounded-lg text-sm font-bold hover:from-violet-600 hover:to-purple-600 transition-all shadow-lg hover:shadow-xl disabled:opacity-50 disabled:cursor-not-allowed"
                        >
                          <span className="material-symbols-outlined text-sm">play_arrow</span>
                          Simulate Interview Completion
                        </button>
                      )}
                    </div>
                  </div>
                ) : (
                  <div className="space-y-4">
                    <div>
                      <div className="flex items-center gap-2 mb-3">
                        <span className="material-symbols-outlined text-green-500">check_circle</span>
                        <p className="text-sm font-bold text-text-primary-light dark:text-text-primary-dark">
                          Interview Completed
                        </p>
                      </div>
                      <div className="space-y-1 text-sm text-text-secondary-light dark:text-text-secondary-dark">
                        <p>Completed: {new Date(app.ai_interview_completed_at!).toLocaleString()}</p>
                        <p>Type: {app.ai_interview_type === 'video' ? 'Video Interview' : 'Voice Chat'}</p>
                      </div>
                    </div>

                    {/* Mock Interview Results */}
                    {interviewResults && (
                      <motion.div
                        initial={{ opacity: 0, y: 10 }}
                        animate={{ opacity: 1, y: 0 }}
                        className="border border-border-light dark:border-border-dark rounded-lg overflow-hidden"
                      >
                        {/* Overall Score Header */}
                        <div className="bg-gradient-to-r from-violet-500 to-purple-500 p-4 text-white">
                          <div className="flex items-center justify-between">
                            <div>
                              <p className="text-xs uppercase tracking-wide opacity-80 mb-1">
                                AI Interview Analysis
                              </p>
                              <p className="text-lg font-bold">Overall Performance</p>
                            </div>
                            <div className="text-center">
                              <div className="text-4xl font-bold">{interviewResults.overallScore}</div>
                              <div className="text-xs opacity-80">/ 100</div>
                            </div>
                          </div>
                        </div>

                        <div className="p-4 space-y-4">
                          {/* Score Breakdown */}
                          <div>
                            <p className="text-xs font-bold text-text-secondary-light dark:text-text-secondary-dark uppercase tracking-wide mb-3">
                              Score Breakdown
                            </p>
                            <div className="space-y-3">
                              {Object.entries(interviewResults.scores).map(([key, value]) => (
                                <div key={key}>
                                  <div className="flex justify-between text-xs mb-1">
                                    <span className="text-text-primary-light dark:text-text-primary-dark capitalize">
                                      {key.replace(/([A-Z])/g, ' $1').trim()}
                                    </span>
                                    <span className="font-bold text-primary">{value}%</span>
                                  </div>
                                  <div className="h-2 bg-background-light dark:bg-background-dark rounded-full overflow-hidden">
                                    <motion.div
                                      initial={{ width: 0 }}
                                      animate={{ width: `${value}%` }}
                                      transition={{ duration: 0.8, delay: 0.2 }}
                                      className={`h-full rounded-full ${
                                        value >= 80 ? 'bg-green-500' : value >= 60 ? 'bg-yellow-500' : 'bg-red-500'
                                      }`}
                                    />
                                  </div>
                                </div>
                              ))}
                            </div>
                          </div>

                          {/* Strengths */}
                          <div>
                            <p className="text-xs font-bold text-text-secondary-light dark:text-text-secondary-dark uppercase tracking-wide mb-2">
                              Key Strengths
                            </p>
                            <div className="space-y-2">
                              {interviewResults.strengths.map((strength, index) => (
                                <div key={index} className="flex items-start gap-2">
                                  <span className="material-symbols-outlined text-green-500 text-sm mt-0.5">
                                    check_circle
                                  </span>
                                  <span className="text-sm text-text-primary-light dark:text-text-primary-dark">
                                    {strength}
                                  </span>
                                </div>
                              ))}
                            </div>
                          </div>

                          {/* Areas for Improvement */}
                          <div>
                            <p className="text-xs font-bold text-text-secondary-light dark:text-text-secondary-dark uppercase tracking-wide mb-2">
                              Areas for Follow-up
                            </p>
                            <div className="space-y-2">
                              {interviewResults.improvements.map((improvement, index) => (
                                <div key={index} className="flex items-start gap-2">
                                  <span className="material-symbols-outlined text-yellow-500 text-sm mt-0.5">
                                    info
                                  </span>
                                  <span className="text-sm text-text-primary-light dark:text-text-primary-dark">
                                    {improvement}
                                  </span>
                                </div>
                              ))}
                            </div>
                          </div>
                        </div>
                      </motion.div>
                    )}
                  </div>
                )}
              </div>

              {/* Schedule Interview Modal */}
              <AnimatePresence>
                {showScheduleModal === app.id && (
                  <motion.div
                    initial={{ opacity: 0, height: 0 }}
                    animate={{ opacity: 1, height: 'auto' }}
                    exit={{ opacity: 0, height: 0 }}
                    className="bg-background-light dark:bg-background-dark rounded-lg p-4 border-2 border-primary overflow-hidden"
                  >
                    <p className="text-sm font-bold text-text-primary-light dark:text-text-primary-dark mb-3">
                      Schedule AI Interview
                    </p>
                    <div className="space-y-4">
                      <div>
                        <label className="text-xs text-text-secondary-light dark:text-text-secondary-dark mb-2 block">
                          Interview Type
                        </label>
                        <div className="grid grid-cols-2 gap-3">
                          <button
                            type="button"
                            onClick={() => setSelectedInterviewType('video')}
                            className={`flex flex-col items-center gap-2 p-4 border-2 rounded-lg transition-all ${
                              selectedInterviewType === 'video'
                                ? 'border-primary bg-primary/10'
                                : 'border-border-light dark:border-border-dark hover:border-primary/50'
                            }`}
                          >
                            <span className={`material-symbols-outlined text-3xl ${
                              selectedInterviewType === 'video' ? 'text-primary' : 'text-text-secondary-light dark:text-text-secondary-dark'
                            }`}>
                              videocam
                            </span>
                            <span className={`text-sm font-bold ${
                              selectedInterviewType === 'video' ? 'text-primary' : 'text-text-primary-light dark:text-text-primary-dark'
                            }`}>
                              Video Interview
                            </span>
                            <span className="text-xs text-text-secondary-light dark:text-text-secondary-dark">
                              Face-to-face with AI
                            </span>
                          </button>
                          <button
                            type="button"
                            onClick={() => setSelectedInterviewType('voice')}
                            className={`flex flex-col items-center gap-2 p-4 border-2 rounded-lg transition-all ${
                              selectedInterviewType === 'voice'
                                ? 'border-primary bg-primary/10'
                                : 'border-border-light dark:border-border-dark hover:border-primary/50'
                            }`}
                          >
                            <span className={`material-symbols-outlined text-3xl ${
                              selectedInterviewType === 'voice' ? 'text-primary' : 'text-text-secondary-light dark:text-text-secondary-dark'
                            }`}>
                              mic
                            </span>
                            <span className={`text-sm font-bold ${
                              selectedInterviewType === 'voice' ? 'text-primary' : 'text-text-primary-light dark:text-text-primary-dark'
                            }`}>
                              Voice Chat
                            </span>
                            <span className="text-xs text-text-secondary-light dark:text-text-secondary-dark">
                              Audio-only interview
                            </span>
                          </button>
                        </div>
                      </div>
                      <div>
                        <label className="text-xs text-text-secondary-light dark:text-text-secondary-dark mb-1 block">
                          Date & Time (optional)
                        </label>
                        <input
                          type="datetime-local"
                          value={scheduledDateTime}
                          onChange={(e) => setScheduledDateTime(e.target.value)}
                          className="w-full px-3 py-2 rounded-lg border border-border-light dark:border-border-dark bg-card-light dark:bg-card-dark text-text-primary-light dark:text-text-primary-dark text-sm focus:border-primary focus:ring-1 focus:ring-primary outline-none transition-all"
                        />
                        <p className="text-xs text-text-secondary-light dark:text-text-secondary-dark mt-1">
                          Leave empty to schedule for 24 hours from now
                        </p>
                      </div>
                      <div className="flex gap-2">
                        <button
                          onClick={() => handleScheduleInterview(app.id)}
                          disabled={scheduleInterviewMutation.isPending}
                          className="flex-1 px-4 py-2 bg-primary text-white rounded-lg text-sm font-bold hover:bg-primary/90 transition-colors disabled:opacity-50"
                        >
                          {scheduleInterviewMutation.isPending ? 'Scheduling...' : 'Schedule Interview'}
                        </button>
                        <button
                          onClick={() => {
                            setShowScheduleModal(null);
                            setSelectedInterviewType('video');
                            setScheduledDateTime('');
                          }}
                          className="px-4 py-2 bg-background-light dark:bg-background-dark border border-border-light dark:border-border-dark rounded-lg text-sm font-bold hover:bg-card-light dark:hover:bg-card-dark transition-colors"
                        >
                          Cancel
                        </button>
                      </div>
                    </div>
                  </motion.div>
                )}
              </AnimatePresence>

              {/* Actions */}
              {isCompleted && (
                <div className="flex justify-end">
                  <StageActions
                    onAdvance={() => handleAdvance(app.id)}
                    advanceLabel="Proceed to Verification"
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
