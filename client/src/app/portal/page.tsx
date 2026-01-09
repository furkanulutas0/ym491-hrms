"use client";

import { motion } from "motion/react";
import Link from "next/link";
import { useCandidateAuth } from "@/providers/candidate-auth-provider";
import { useCandidateApplications } from "@/features/candidate/hooks/use-candidate-applications";
import { PIPELINE_STAGES, PipelineStage } from "@/features/candidate/types";

export default function CandidatePortalDashboard() {
  const { candidate } = useCandidateAuth();
  const { data: applications, isLoading } = useCandidateApplications();

  const getStageInfo = (stage: PipelineStage) => {
    return PIPELINE_STAGES.find(s => s.stage === stage) || PIPELINE_STAGES[0];
  };

  const getStageIndex = (stage: PipelineStage) => {
    return PIPELINE_STAGES.findIndex(s => s.stage === stage);
  };

  // Calculate stats
  const stats = {
    total: applications?.length || 0,
    active: applications?.filter(a => !['Hired', 'Rejected', 'Declined'].includes(a.status)).length || 0,
    inReview: applications?.filter(a => ['ai_review'].includes(a.pipeline_stage)).length || 0,
    actionRequired: applications?.filter(a => 
      (a.pipeline_stage === 'exam' && a.exam_assigned && !a.exam_completed) ||
      (a.pipeline_stage === 'ai_interview' && a.interview_scheduled && !a.interview_completed) ||
      (a.pipeline_stage === 'cv_verification') ||
      (a.pipeline_stage === 'proposal' && a.proposal_sent && a.proposal_accepted === null)
    ).length || 0,
  };

  return (
    <div className="space-y-8">
      {/* Welcome Section */}
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        className="bg-gradient-to-r from-emerald-500/10 to-teal-500/10 border border-emerald-500/20 rounded-2xl p-6 sm:p-8"
      >
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
          <div>
            <h1 className="text-2xl sm:text-3xl font-bold text-white mb-2">
              Welcome back, {candidate?.full_name?.split(' ')[0] || 'there'}! 👋
            </h1>
            <p className="text-gray-400">
              Track your job applications and stay updated on your progress.
            </p>
          </div>
          <Link
            href="/careers"
            className="inline-flex items-center gap-2 px-6 py-3 bg-emerald-500 text-white font-bold rounded-lg hover:bg-emerald-600 transition-colors shrink-0"
          >
            <span className="material-symbols-outlined">search</span>
            Browse Jobs
          </Link>
        </div>
      </motion.div>

      {/* Stats Grid */}
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ delay: 0.1 }}
        className="grid grid-cols-2 lg:grid-cols-4 gap-4"
      >
        <div className="bg-[#111827] border border-white/10 rounded-xl p-5">
          <div className="flex items-center gap-3 mb-3">
            <div className="w-10 h-10 rounded-lg bg-blue-500/10 flex items-center justify-center">
              <span className="material-symbols-outlined text-blue-400">description</span>
            </div>
          </div>
          <p className="text-2xl font-bold text-white">{stats.total}</p>
          <p className="text-sm text-gray-400">Total Applications</p>
        </div>

        <div className="bg-[#111827] border border-white/10 rounded-xl p-5">
          <div className="flex items-center gap-3 mb-3">
            <div className="w-10 h-10 rounded-lg bg-emerald-500/10 flex items-center justify-center">
              <span className="material-symbols-outlined text-emerald-400">trending_up</span>
            </div>
          </div>
          <p className="text-2xl font-bold text-white">{stats.active}</p>
          <p className="text-sm text-gray-400">Active</p>
        </div>

        <div className="bg-[#111827] border border-white/10 rounded-xl p-5">
          <div className="flex items-center gap-3 mb-3">
            <div className="w-10 h-10 rounded-lg bg-purple-500/10 flex items-center justify-center">
              <span className="material-symbols-outlined text-purple-400">smart_toy</span>
            </div>
          </div>
          <p className="text-2xl font-bold text-white">{stats.inReview}</p>
          <p className="text-sm text-gray-400">In Review</p>
        </div>

        <div className="bg-[#111827] border border-white/10 rounded-xl p-5">
          <div className="flex items-center gap-3 mb-3">
            <div className="w-10 h-10 rounded-lg bg-orange-500/10 flex items-center justify-center">
              <span className="material-symbols-outlined text-orange-400">notification_important</span>
            </div>
          </div>
          <p className="text-2xl font-bold text-white">{stats.actionRequired}</p>
          <p className="text-sm text-gray-400">Action Required</p>
        </div>
      </motion.div>

      {/* Recent Applications */}
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ delay: 0.2 }}
        className="bg-[#111827] border border-white/10 rounded-2xl overflow-hidden"
      >
        <div className="p-6 border-b border-white/10 flex items-center justify-between">
          <h2 className="text-lg font-bold text-white">Recent Applications</h2>
          <Link
            href="/portal/applications"
            className="text-sm text-emerald-400 hover:text-emerald-300 transition-colors flex items-center gap-1"
          >
            View All
            <span className="material-symbols-outlined text-sm">arrow_forward</span>
          </Link>
        </div>

        {isLoading ? (
          <div className="p-12 flex items-center justify-center">
            <div className="w-8 h-8 border-4 border-emerald-500/30 border-t-emerald-500 rounded-full animate-spin" />
          </div>
        ) : applications && applications.length > 0 ? (
          <div className="divide-y divide-white/5">
            {applications.slice(0, 5).map((app) => {
              const stageInfo = getStageInfo(app.pipeline_stage);
              const stageIndex = getStageIndex(app.pipeline_stage);
              const progress = ((stageIndex + 1) / PIPELINE_STAGES.length) * 100;

              return (
                <Link
                  key={app.id}
                  href={`/portal/applications/${app.id}`}
                  className="block p-5 hover:bg-white/5 transition-colors"
                >
                  <div className="flex items-start justify-between gap-4 mb-3">
                    <div>
                      <h3 className="font-bold text-white mb-1">{app.job_title}</h3>
                      <p className="text-sm text-gray-400">
                        {app.department && `${app.department} • `}
                        {app.location || app.company_name}
                      </p>
                    </div>
                    <span className={`inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-medium ${stageInfo.color} bg-current/10`}>
                      <span className="material-symbols-outlined text-sm">{stageInfo.icon}</span>
                      {stageInfo.label}
                    </span>
                  </div>

                  {/* Progress bar */}
                  <div className="mb-2">
                    <div className="h-1.5 bg-white/10 rounded-full overflow-hidden">
                      <div
                        className="h-full bg-gradient-to-r from-emerald-500 to-teal-500 rounded-full transition-all duration-500"
                        style={{ width: `${progress}%` }}
                      />
                    </div>
                  </div>

                  <div className="flex items-center justify-between text-xs text-gray-500">
                    <span>Applied {new Date(app.applied_at).toLocaleDateString()}</span>
                    <span className="flex items-center gap-1">
                      <span className="material-symbols-outlined text-sm">arrow_forward</span>
                      View Details
                    </span>
                  </div>
                </Link>
              );
            })}
          </div>
        ) : (
          <div className="p-12 text-center">
            <span className="material-symbols-outlined text-5xl text-gray-600 mb-4">inbox</span>
            <h3 className="text-lg font-bold text-white mb-2">No applications yet</h3>
            <p className="text-gray-400 mb-6">
              Start exploring opportunities and apply for your dream job!
            </p>
            <Link
              href="/careers"
              className="inline-flex items-center gap-2 px-6 py-3 bg-emerald-500 text-white font-bold rounded-lg hover:bg-emerald-600 transition-colors"
            >
              <span className="material-symbols-outlined">search</span>
              Browse Jobs
            </Link>
          </div>
        )}
      </motion.div>

      {/* Quick Actions */}
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ delay: 0.3 }}
        className="grid sm:grid-cols-2 lg:grid-cols-3 gap-4"
      >
        <Link
          href="/portal/applications"
          className="group bg-[#111827] border border-white/10 rounded-xl p-5 hover:border-emerald-500/50 transition-colors"
        >
          <div className="w-12 h-12 rounded-xl bg-blue-500/10 flex items-center justify-center mb-4 group-hover:scale-110 transition-transform">
            <span className="material-symbols-outlined text-2xl text-blue-400">work</span>
          </div>
          <h3 className="font-bold text-white mb-1">My Applications</h3>
          <p className="text-sm text-gray-400">View all your job applications and their status</p>
        </Link>

        <Link
          href="/portal/profile"
          className="group bg-[#111827] border border-white/10 rounded-xl p-5 hover:border-emerald-500/50 transition-colors"
        >
          <div className="w-12 h-12 rounded-xl bg-purple-500/10 flex items-center justify-center mb-4 group-hover:scale-110 transition-transform">
            <span className="material-symbols-outlined text-2xl text-purple-400">person</span>
          </div>
          <h3 className="font-bold text-white mb-1">Edit Profile</h3>
          <p className="text-sm text-gray-400">Update your contact information and links</p>
        </Link>

        <Link
          href="/careers"
          className="group bg-[#111827] border border-white/10 rounded-xl p-5 hover:border-emerald-500/50 transition-colors sm:col-span-2 lg:col-span-1"
        >
          <div className="w-12 h-12 rounded-xl bg-emerald-500/10 flex items-center justify-center mb-4 group-hover:scale-110 transition-transform">
            <span className="material-symbols-outlined text-2xl text-emerald-400">search</span>
          </div>
          <h3 className="font-bold text-white mb-1">Find More Jobs</h3>
          <p className="text-sm text-gray-400">Explore new opportunities and apply</p>
        </Link>
      </motion.div>
    </div>
  );
}

