"use client";

import { useState } from "react";
import { motion } from "motion/react";
import Link from "next/link";
import { useCandidateApplications } from "@/features/candidate/hooks/use-candidate-applications";
import { PIPELINE_STAGES, PipelineStage } from "@/features/candidate/types";

export default function ApplicationsPage() {
  const { data: applications, isLoading } = useCandidateApplications();
  const [filter, setFilter] = useState<'all' | 'active' | 'completed'>('all');

  const getStageInfo = (stage: PipelineStage) => {
    return PIPELINE_STAGES.find(s => s.stage === stage) || PIPELINE_STAGES[0];
  };

  const getStageIndex = (stage: PipelineStage) => {
    return PIPELINE_STAGES.findIndex(s => s.stage === stage);
  };

  const filteredApplications = applications?.filter(app => {
    if (filter === 'all') return true;
    if (filter === 'active') return !['Hired', 'Rejected', 'Declined'].includes(app.status);
    if (filter === 'completed') return ['Hired', 'Rejected', 'Declined'].includes(app.status);
    return true;
  });

  const getActionBadge = (app: typeof applications[0]) => {
    if (app.pipeline_stage === 'exam' && app.exam_assigned && !app.exam_completed) {
      return { label: 'Take Exam', color: 'bg-orange-500/10 text-orange-400' };
    }
    if (app.pipeline_stage === 'ai_interview' && app.interview_scheduled && !app.interview_completed) {
      return { label: 'Join Interview', color: 'bg-cyan-500/10 text-cyan-400' };
    }
    if (app.pipeline_stage === 'cv_verification') {
      return { label: 'Upload Documents', color: 'bg-yellow-500/10 text-yellow-400' };
    }
    if (app.pipeline_stage === 'proposal' && app.proposal_sent && app.proposal_accepted === null) {
      return { label: 'Review Offer', color: 'bg-emerald-500/10 text-emerald-400' };
    }
    return null;
  };

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-white">My Applications</h1>
          <p className="text-gray-400 mt-1">Track the progress of all your job applications</p>
        </div>
        <Link
          href="/careers"
          className="inline-flex items-center gap-2 px-4 py-2 bg-emerald-500 text-white text-sm font-bold rounded-lg hover:bg-emerald-600 transition-colors"
        >
          <span className="material-symbols-outlined text-sm">add</span>
          Apply for More
        </Link>
      </div>

      {/* Filter Tabs */}
      <div className="flex gap-2 border-b border-white/10 pb-4">
        {[
          { key: 'all', label: 'All', count: applications?.length || 0 },
          { key: 'active', label: 'Active', count: applications?.filter(a => !['Hired', 'Rejected', 'Declined'].includes(a.status)).length || 0 },
          { key: 'completed', label: 'Completed', count: applications?.filter(a => ['Hired', 'Rejected', 'Declined'].includes(a.status)).length || 0 },
        ].map(tab => (
          <button
            key={tab.key}
            onClick={() => setFilter(tab.key as any)}
            className={`px-4 py-2 rounded-lg text-sm font-medium transition-colors ${
              filter === tab.key
                ? 'bg-emerald-500/10 text-emerald-400'
                : 'text-gray-400 hover:text-white hover:bg-white/5'
            }`}
          >
            {tab.label} ({tab.count})
          </button>
        ))}
      </div>

      {/* Applications List */}
      {isLoading ? (
        <div className="flex items-center justify-center py-20">
          <div className="w-10 h-10 border-4 border-emerald-500/30 border-t-emerald-500 rounded-full animate-spin" />
        </div>
      ) : filteredApplications && filteredApplications.length > 0 ? (
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          className="grid gap-4"
        >
          {filteredApplications.map((app, index) => {
            const stageInfo = getStageInfo(app.pipeline_stage);
            const stageIndex = getStageIndex(app.pipeline_stage);
            const progress = ((stageIndex + 1) / PIPELINE_STAGES.length) * 100;
            const actionBadge = getActionBadge(app);

            return (
              <motion.div
                key={app.id}
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: index * 0.05 }}
              >
                <Link
                  href={`/portal/applications/${app.id}`}
                  className="block bg-[#111827] border border-white/10 rounded-xl p-6 hover:border-emerald-500/30 transition-all group"
                >
                  <div className="flex flex-col lg:flex-row lg:items-center justify-between gap-4">
                    {/* Job Info */}
                    <div className="flex-1">
                      <div className="flex items-start gap-3 mb-3">
                        <div className="w-12 h-12 rounded-xl bg-gradient-to-br from-emerald-500/20 to-teal-500/20 flex items-center justify-center shrink-0">
                          <span className="material-symbols-outlined text-emerald-400">work</span>
                        </div>
                        <div>
                          <h3 className="font-bold text-white text-lg group-hover:text-emerald-400 transition-colors">
                            {app.job_title}
                          </h3>
                          <p className="text-sm text-gray-400">
                            {app.company_name}
                            {app.department && ` • ${app.department}`}
                            {app.location && ` • ${app.location}`}
                          </p>
                        </div>
                      </div>

                      {/* Progress Timeline */}
                      <div className="mb-3">
                        <div className="flex items-center gap-1 mb-2">
                          {PIPELINE_STAGES.map((stage, i) => {
                            const isActive = i <= stageIndex;
                            const isCurrent = stage.stage === app.pipeline_stage;
                            
                            return (
                              <div key={stage.stage} className="flex-1 flex items-center">
                                <div
                                  className={`h-1.5 flex-1 rounded-full transition-colors ${
                                    isActive
                                      ? 'bg-gradient-to-r from-emerald-500 to-teal-500'
                                      : 'bg-white/10'
                                  }`}
                                />
                                {isCurrent && (
                                  <div className="w-3 h-3 rounded-full bg-emerald-500 ring-4 ring-emerald-500/20 ml-1" />
                                )}
                              </div>
                            );
                          })}
                        </div>
                        <div className="flex items-center gap-2">
                          <span className={`material-symbols-outlined text-sm ${stageInfo.color}`}>
                            {stageInfo.icon}
                          </span>
                          <span className="text-sm text-gray-400">
                            {stageInfo.label}: {stageInfo.description}
                          </span>
                        </div>
                      </div>

                      <p className="text-xs text-gray-500">
                        Applied on {new Date(app.applied_at).toLocaleDateString('en-US', {
                          year: 'numeric',
                          month: 'long',
                          day: 'numeric'
                        })}
                      </p>
                    </div>

                    {/* Status & Action */}
                    <div className="flex flex-col items-end gap-3">
                      {actionBadge && (
                        <span className={`inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full text-xs font-bold ${actionBadge.color}`}>
                          <span className="material-symbols-outlined text-sm">priority_high</span>
                          {actionBadge.label}
                        </span>
                      )}
                      <span className="text-emerald-400 text-sm font-medium flex items-center gap-1 opacity-0 group-hover:opacity-100 transition-opacity">
                        View Details
                        <span className="material-symbols-outlined text-sm">arrow_forward</span>
                      </span>
                    </div>
                  </div>
                </Link>
              </motion.div>
            );
          })}
        </motion.div>
      ) : (
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          className="text-center py-20"
        >
          <span className="material-symbols-outlined text-6xl text-gray-600 mb-4">inbox</span>
          <h3 className="text-xl font-bold text-white mb-2">No applications found</h3>
          <p className="text-gray-400 mb-6">
            {filter === 'all'
              ? "You haven't applied to any jobs yet."
              : `No ${filter} applications.`}
          </p>
          <Link
            href="/careers"
            className="inline-flex items-center gap-2 px-6 py-3 bg-emerald-500 text-white font-bold rounded-lg hover:bg-emerald-600 transition-colors"
          >
            <span className="material-symbols-outlined">search</span>
            Browse Jobs
          </Link>
        </motion.div>
      )}
    </div>
  );
}

