"use client";

import { useParams } from "next/navigation";
import { motion } from "motion/react";
import Link from "next/link";
import { useCandidateApplication } from "@/features/candidate/hooks/use-candidate-applications";
import { PIPELINE_STAGES, PipelineStage } from "@/features/candidate/types";

export default function ApplicationDetailPage() {
  const params = useParams();
  const appId = Number(params.id);
  const { data: application, isLoading, error } = useCandidateApplication(appId);

  const getStageIndex = (stage: PipelineStage) => {
    return PIPELINE_STAGES.findIndex(s => s.stage === stage);
  };

  if (isLoading) {
    return (
      <div className="flex items-center justify-center min-h-[400px]">
        <div className="w-10 h-10 border-4 border-emerald-500/30 border-t-emerald-500 rounded-full animate-spin" />
      </div>
    );
  }

  if (error || !application) {
    return (
      <div className="text-center py-20">
        <span className="material-symbols-outlined text-6xl text-gray-600 mb-4">error</span>
        <h3 className="text-xl font-bold text-white mb-2">Application Not Found</h3>
        <p className="text-gray-400 mb-6">
          This application doesn&apos;t exist or you don&apos;t have access to it.
        </p>
        <Link
          href="/portal/applications"
          className="inline-flex items-center gap-2 text-emerald-400 hover:text-emerald-300"
        >
          <span className="material-symbols-outlined">arrow_back</span>
          Back to Applications
        </Link>
      </div>
    );
  }

  const currentStageIndex = getStageIndex(application.pipeline_stage);

  const getStageAction = (stage: typeof PIPELINE_STAGES[0], index: number) => {
    if (index > currentStageIndex) return null;
    
    switch (stage.stage) {
      case 'exam':
        if (application.exam_assigned && !application.exam_completed) {
          return { label: 'Take Exam', href: `/portal/applications/${appId}/exam`, variant: 'primary' };
        }
        break;
      case 'ai_interview':
        if (application.interview_scheduled && !application.interview_completed) {
          return { label: 'Join Interview', href: `/portal/applications/${appId}/interview`, variant: 'primary' };
        }
        break;
      case 'cv_verification':
        if (index === currentStageIndex) {
          return { label: 'Upload Documents', href: `/portal/applications/${appId}/documents`, variant: 'primary' };
        }
        break;
      case 'proposal':
        if (application.proposal_sent && application.proposal_accepted === null) {
          return { label: 'View Offer', href: `/portal/applications/${appId}/proposal`, variant: 'primary' };
        }
        break;
    }
    return null;
  };

  return (
    <div className="space-y-8">
      {/* Back Button */}
      <Link
        href="/portal/applications"
        className="inline-flex items-center gap-2 text-gray-400 hover:text-white transition-colors"
      >
        <span className="material-symbols-outlined">arrow_back</span>
        Back to Applications
      </Link>

      {/* Header */}
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        className="bg-[#111827] border border-white/10 rounded-2xl p-6 sm:p-8"
      >
        <div className="flex flex-col sm:flex-row gap-6">
          <div className="w-16 h-16 rounded-xl bg-gradient-to-br from-emerald-500/20 to-teal-500/20 flex items-center justify-center shrink-0">
            <span className="material-symbols-outlined text-3xl text-emerald-400">work</span>
          </div>
          <div className="flex-1">
            <h1 className="text-2xl sm:text-3xl font-bold text-white mb-2">
              {application.job_title}
            </h1>
            <p className="text-gray-400 mb-4">
              {application.company_name}
              {application.department && ` • ${application.department}`}
              {application.location && ` • ${application.location}`}
            </p>
            <div className="flex flex-wrap gap-3">
              <span className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-medium bg-blue-500/10 text-blue-400">
                <span className="material-symbols-outlined text-sm">schedule</span>
                Applied {new Date(application.applied_at).toLocaleDateString()}
              </span>
              <span className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-medium bg-emerald-500/10 text-emerald-400">
                <span className="material-symbols-outlined text-sm">trending_up</span>
                {application.status}
              </span>
            </div>
          </div>
        </div>
      </motion.div>

      {/* Timeline */}
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ delay: 0.1 }}
        className="bg-[#111827] border border-white/10 rounded-2xl p-6 sm:p-8"
      >
        <h2 className="text-lg font-bold text-white mb-6">Application Progress</h2>
        
        <div className="space-y-0">
          {PIPELINE_STAGES.map((stage, index) => {
            const isCompleted = index < currentStageIndex;
            const isCurrent = index === currentStageIndex;
            const isPending = index > currentStageIndex;
            const action = getStageAction(stage, index);

            return (
              <div key={stage.stage} className="relative">
                {/* Connector Line */}
                {index < PIPELINE_STAGES.length - 1 && (
                  <div
                    className={`absolute left-5 top-10 w-0.5 h-full ${
                      isCompleted ? 'bg-emerald-500' : 'bg-white/10'
                    }`}
                  />
                )}

                <div className={`relative flex gap-4 pb-8 ${isPending ? 'opacity-40' : ''}`}>
                  {/* Icon */}
                  <div
                    className={`relative z-10 w-10 h-10 rounded-full flex items-center justify-center shrink-0 ${
                      isCompleted
                        ? 'bg-emerald-500'
                        : isCurrent
                        ? 'bg-emerald-500/20 ring-2 ring-emerald-500'
                        : 'bg-white/10'
                    }`}
                  >
                    {isCompleted ? (
                      <span className="material-symbols-outlined text-white text-sm">check</span>
                    ) : (
                      <span className={`material-symbols-outlined text-sm ${
                        isCurrent ? 'text-emerald-400' : 'text-gray-500'
                      }`}>
                        {stage.icon}
                      </span>
                    )}
                  </div>

                  {/* Content */}
                  <div className="flex-1 pt-1">
                    <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-2">
                      <div>
                        <h3 className={`font-bold ${isCurrent ? 'text-emerald-400' : 'text-white'}`}>
                          {stage.label}
                          {isCurrent && (
                            <span className="ml-2 text-xs font-normal text-emerald-400/70">
                              (Current Stage)
                            </span>
                          )}
                        </h3>
                        <p className="text-sm text-gray-400">{stage.description}</p>
                      </div>

                      {action && (
                        <Link
                          href={action.href}
                          className={`inline-flex items-center gap-2 px-4 py-2 rounded-lg text-sm font-bold transition-colors ${
                            action.variant === 'primary'
                              ? 'bg-emerald-500 text-white hover:bg-emerald-600'
                              : 'bg-white/10 text-white hover:bg-white/20'
                          }`}
                        >
                          {action.label}
                          <span className="material-symbols-outlined text-sm">arrow_forward</span>
                        </Link>
                      )}
                    </div>

                    {/* Stage-specific info */}
                    {stage.stage === 'exam' && application.exam_completed && application.exam_score !== null && (
                      <div className="mt-3 p-3 bg-white/5 rounded-lg">
                        <p className="text-sm text-gray-400">
                          Score: <span className="text-white font-bold">{application.exam_score}%</span>
                        </p>
                      </div>
                    )}

                    {stage.stage === 'ai_interview' && application.interview_scheduled_at && (
                      <div className="mt-3 p-3 bg-white/5 rounded-lg">
                        <p className="text-sm text-gray-400">
                          {application.interview_completed ? 'Completed' : 'Scheduled'}: {' '}
                          <span className="text-white">
                            {new Date(application.interview_scheduled_at).toLocaleString()}
                          </span>
                        </p>
                        {application.interview_type && (
                          <p className="text-sm text-gray-400">
                            Type: <span className="text-white capitalize">{application.interview_type}</span>
                          </p>
                        )}
                      </div>
                    )}

                    {stage.stage === 'cv_verification' && isCurrent && (
                      <div className="mt-3 p-3 bg-white/5 rounded-lg">
                        <p className="text-sm text-gray-400">
                          Documents: {application.documents_approved} approved, {application.documents_pending} pending
                        </p>
                      </div>
                    )}

                    {stage.stage === 'proposal' && application.proposal_sent && (
                      <div className="mt-3 p-3 bg-white/5 rounded-lg">
                        {application.proposal_accepted === null ? (
                          <p className="text-sm text-yellow-400">
                            ⏳ Waiting for your response
                          </p>
                        ) : application.proposal_accepted ? (
                          <p className="text-sm text-emerald-400">
                            ✓ Offer accepted - Welcome to the team!
                          </p>
                        ) : (
                          <p className="text-sm text-gray-400">
                            Offer declined
                          </p>
                        )}
                      </div>
                    )}
                  </div>
                </div>
              </div>
            );
          })}
        </div>
      </motion.div>

      {/* Quick Actions */}
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ delay: 0.2 }}
        className="grid sm:grid-cols-2 lg:grid-cols-4 gap-4"
      >
        {application.exam_assigned && (
          <Link
            href={`/portal/applications/${appId}/exam`}
            className="bg-[#111827] border border-white/10 rounded-xl p-4 hover:border-orange-500/50 transition-colors group"
          >
            <div className="w-10 h-10 rounded-lg bg-orange-500/10 flex items-center justify-center mb-3">
              <span className="material-symbols-outlined text-orange-400">quiz</span>
            </div>
            <h3 className="font-bold text-white mb-1">Assessment</h3>
            <p className="text-xs text-gray-400">
              {application.exam_completed ? 'View Results' : 'Take Exam'}
            </p>
          </Link>
        )}

        {application.interview_scheduled && (
          <Link
            href={`/portal/applications/${appId}/interview`}
            className="bg-[#111827] border border-white/10 rounded-xl p-4 hover:border-cyan-500/50 transition-colors group"
          >
            <div className="w-10 h-10 rounded-lg bg-cyan-500/10 flex items-center justify-center mb-3">
              <span className="material-symbols-outlined text-cyan-400">videocam</span>
            </div>
            <h3 className="font-bold text-white mb-1">Interview</h3>
            <p className="text-xs text-gray-400">
              {application.interview_completed ? 'View Details' : 'Join Interview'}
            </p>
          </Link>
        )}

        <Link
          href={`/portal/applications/${appId}/documents`}
          className="bg-[#111827] border border-white/10 rounded-xl p-4 hover:border-green-500/50 transition-colors group"
        >
          <div className="w-10 h-10 rounded-lg bg-green-500/10 flex items-center justify-center mb-3">
            <span className="material-symbols-outlined text-green-400">folder</span>
          </div>
          <h3 className="font-bold text-white mb-1">Documents</h3>
          <p className="text-xs text-gray-400">Upload & manage</p>
        </Link>

        {application.proposal_sent && (
          <Link
            href={`/portal/applications/${appId}/proposal`}
            className="bg-[#111827] border border-white/10 rounded-xl p-4 hover:border-emerald-500/50 transition-colors group"
          >
            <div className="w-10 h-10 rounded-lg bg-emerald-500/10 flex items-center justify-center mb-3">
              <span className="material-symbols-outlined text-emerald-400">handshake</span>
            </div>
            <h3 className="font-bold text-white mb-1">Job Offer</h3>
            <p className="text-xs text-gray-400">
              {application.proposal_accepted === null ? 'Review Offer' : 'View Details'}
            </p>
          </Link>
        )}
      </motion.div>
    </div>
  );
}

