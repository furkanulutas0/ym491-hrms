"use client";

import { useParams } from "next/navigation";
import { motion } from "motion/react";
import Link from "next/link";
import { useInterviewInfo, useCandidateApplication } from "@/features/candidate/hooks/use-candidate-applications";

export default function InterviewPage() {
  const params = useParams();
  const appId = Number(params.id);
  const { data: interview, isLoading } = useInterviewInfo(appId);
  const { data: application } = useCandidateApplication(appId);

  if (isLoading) {
    return (
      <div className="flex items-center justify-center min-h-[400px]">
        <div className="w-10 h-10 border-4 border-emerald-500/30 border-t-emerald-500 rounded-full animate-spin" />
      </div>
    );
  }

  const isScheduled = interview?.scheduled_at !== null;
  const isCompleted = interview?.completed_at !== null;
  const scheduledDate = interview?.scheduled_at ? new Date(interview.scheduled_at) : null;
  const isUpcoming = scheduledDate && scheduledDate > new Date();

  return (
    <div className="space-y-8">
      {/* Back Button */}
      <Link
        href={`/portal/applications/${appId}`}
        className="inline-flex items-center gap-2 text-gray-400 hover:text-white transition-colors"
      >
        <span className="material-symbols-outlined">arrow_back</span>
        Back to Application
      </Link>

      {/* Header */}
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
      >
        <h1 className="text-2xl font-bold text-white mb-2">AI Interview</h1>
        <p className="text-gray-400">
          Your AI-powered interview experience
        </p>
      </motion.div>

      {!isScheduled ? (
        /* Not Scheduled */
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="bg-[#111827] border border-white/10 rounded-2xl p-8 text-center"
        >
          <div className="w-20 h-20 mx-auto mb-6 rounded-full bg-cyan-500/10 flex items-center justify-center">
            <span className="material-symbols-outlined text-4xl text-cyan-400">
              schedule
            </span>
          </div>
          <h2 className="text-xl font-bold text-white mb-3">
            Interview Not Yet Scheduled
          </h2>
          <p className="text-gray-400 max-w-md mx-auto">
            Your interview hasn&apos;t been scheduled yet. You&apos;ll receive a notification 
            once it&apos;s ready. Check back later!
          </p>
        </motion.div>
      ) : isCompleted ? (
        /* Completed */
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="space-y-6"
        >
          <div className="bg-emerald-500/10 border border-emerald-500/20 rounded-2xl p-8 text-center">
            <div className="w-20 h-20 mx-auto mb-6 rounded-full bg-emerald-500/20 flex items-center justify-center">
              <span className="material-symbols-outlined text-4xl text-emerald-400">
                check_circle
              </span>
            </div>
            <h2 className="text-xl font-bold text-white mb-3">
              Interview Completed
            </h2>
            <p className="text-gray-400 max-w-md mx-auto mb-4">
              Great job! Your interview has been completed successfully. 
              The results are being processed.
            </p>
            <div className="inline-flex items-center gap-4 text-sm text-gray-400">
              <span className="flex items-center gap-1">
                <span className="material-symbols-outlined text-sm">
                  {interview.interview_type === 'video' ? 'videocam' : 'mic'}
                </span>
                {interview.interview_type === 'video' ? 'Video Interview' : 'Voice Interview'}
              </span>
              <span className="flex items-center gap-1">
                <span className="material-symbols-outlined text-sm">event</span>
                {new Date(interview.completed_at!).toLocaleDateString()}
              </span>
            </div>
          </div>

          <div className="bg-[#111827] border border-white/10 rounded-2xl p-6">
            <h3 className="font-bold text-white mb-4">What&apos;s Next?</h3>
            <div className="space-y-3">
              <div className="flex items-start gap-3">
                <div className="w-8 h-8 rounded-full bg-purple-500/10 flex items-center justify-center shrink-0">
                  <span className="material-symbols-outlined text-sm text-purple-400">smart_toy</span>
                </div>
                <div>
                  <p className="text-white font-medium">AI Analysis</p>
                  <p className="text-sm text-gray-400">Your interview is being analyzed by our AI</p>
                </div>
              </div>
              <div className="flex items-start gap-3">
                <div className="w-8 h-8 rounded-full bg-blue-500/10 flex items-center justify-center shrink-0">
                  <span className="material-symbols-outlined text-sm text-blue-400">rate_review</span>
                </div>
                <div>
                  <p className="text-white font-medium">HR Review</p>
                  <p className="text-sm text-gray-400">Our team will review the results</p>
                </div>
              </div>
              <div className="flex items-start gap-3">
                <div className="w-8 h-8 rounded-full bg-emerald-500/10 flex items-center justify-center shrink-0">
                  <span className="material-symbols-outlined text-sm text-emerald-400">notification_important</span>
                </div>
                <div>
                  <p className="text-white font-medium">Next Steps</p>
                  <p className="text-sm text-gray-400">You&apos;ll be notified when there&apos;s an update</p>
                </div>
              </div>
            </div>
          </div>
        </motion.div>
      ) : (
        /* Scheduled - Show Details */
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="space-y-6"
        >
          {/* Interview Card */}
          <div className="bg-gradient-to-br from-cyan-500/10 to-blue-500/10 border border-cyan-500/20 rounded-2xl p-8">
            <div className="flex flex-col md:flex-row md:items-center justify-between gap-6">
              <div className="flex items-center gap-6">
                <div className="w-20 h-20 rounded-2xl bg-cyan-500/20 flex items-center justify-center">
                  <span className="material-symbols-outlined text-4xl text-cyan-400">
                    {interview.interview_type === 'video' ? 'videocam' : 'mic'}
                  </span>
                </div>
                <div>
                  <h2 className="text-xl font-bold text-white mb-2">
                    {interview.interview_type === 'video' ? 'Video Interview' : 'Voice Interview'}
                  </h2>
                  <div className="space-y-1">
                    <p className="text-cyan-400 flex items-center gap-2">
                      <span className="material-symbols-outlined text-sm">event</span>
                      {scheduledDate?.toLocaleDateString('en-US', {
                        weekday: 'long',
                        year: 'numeric',
                        month: 'long',
                        day: 'numeric'
                      })}
                    </p>
                    <p className="text-cyan-400 flex items-center gap-2">
                      <span className="material-symbols-outlined text-sm">schedule</span>
                      {scheduledDate?.toLocaleTimeString('en-US', {
                        hour: '2-digit',
                        minute: '2-digit'
                      })}
                    </p>
                  </div>
                </div>
              </div>

              {isUpcoming && (
                <button className="px-8 py-4 bg-cyan-500 text-white font-bold rounded-xl hover:bg-cyan-600 transition-colors flex items-center gap-2 shadow-lg shadow-cyan-500/25">
                  <span className="material-symbols-outlined">
                    {interview.interview_type === 'video' ? 'videocam' : 'mic'}
                  </span>
                  Join Interview
                </button>
              )}
            </div>
          </div>

          {/* Countdown or Status */}
          {isUpcoming && (
            <div className="bg-[#111827] border border-white/10 rounded-2xl p-6">
              <div className="flex items-center gap-3 mb-4">
                <span className="material-symbols-outlined text-yellow-400">timer</span>
                <h3 className="font-bold text-white">Time Until Interview</h3>
              </div>
              <div className="grid grid-cols-4 gap-4 text-center">
                {(() => {
                  const diff = scheduledDate!.getTime() - new Date().getTime();
                  const days = Math.floor(diff / (1000 * 60 * 60 * 24));
                  const hours = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                  const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
                  const seconds = Math.floor((diff % (1000 * 60)) / 1000);

                  return (
                    <>
                      <div className="bg-white/5 rounded-xl p-4">
                        <div className="text-3xl font-bold text-white">{days}</div>
                        <div className="text-xs text-gray-400">Days</div>
                      </div>
                      <div className="bg-white/5 rounded-xl p-4">
                        <div className="text-3xl font-bold text-white">{hours}</div>
                        <div className="text-xs text-gray-400">Hours</div>
                      </div>
                      <div className="bg-white/5 rounded-xl p-4">
                        <div className="text-3xl font-bold text-white">{minutes}</div>
                        <div className="text-xs text-gray-400">Minutes</div>
                      </div>
                      <div className="bg-white/5 rounded-xl p-4">
                        <div className="text-3xl font-bold text-white">{seconds}</div>
                        <div className="text-xs text-gray-400">Seconds</div>
                      </div>
                    </>
                  );
                })()}
              </div>
            </div>
          )}

          {/* Instructions */}
          <div className="bg-[#111827] border border-white/10 rounded-2xl p-6">
            <h3 className="font-bold text-white mb-4 flex items-center gap-2">
              <span className="material-symbols-outlined text-blue-400">info</span>
              Interview Instructions
            </h3>
            <div className="space-y-4 text-gray-400">
              <p>{interview.instructions || "Please ensure you have a stable internet connection and are in a quiet environment."}</p>
              <ul className="space-y-2">
                <li className="flex items-start gap-2">
                  <span className="material-symbols-outlined text-emerald-400 text-sm mt-0.5">check_circle</span>
                  Test your {interview.interview_type === 'video' ? 'camera and microphone' : 'microphone'} before the interview
                </li>
                <li className="flex items-start gap-2">
                  <span className="material-symbols-outlined text-emerald-400 text-sm mt-0.5">check_circle</span>
                  Find a quiet, well-lit space
                </li>
                <li className="flex items-start gap-2">
                  <span className="material-symbols-outlined text-emerald-400 text-sm mt-0.5">check_circle</span>
                  Have your resume and job description handy
                </li>
                <li className="flex items-start gap-2">
                  <span className="material-symbols-outlined text-emerald-400 text-sm mt-0.5">check_circle</span>
                  Join 5 minutes early to settle in
                </li>
              </ul>
            </div>
          </div>
        </motion.div>
      )}
    </div>
  );
}

