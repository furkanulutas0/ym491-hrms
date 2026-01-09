"use client";

import { useParams } from "next/navigation";
import { motion } from "motion/react";
import Link from "next/link";
import { useExamInfo, useCandidateApplication } from "@/features/candidate/hooks/use-candidate-applications";

export default function ExamPage() {
  const params = useParams();
  const appId = Number(params.id);
  const { data: exam, isLoading } = useExamInfo(appId);
  const { data: application } = useCandidateApplication(appId);

  if (isLoading) {
    return (
      <div className="flex items-center justify-center min-h-[400px]">
        <div className="w-10 h-10 border-4 border-emerald-500/30 border-t-emerald-500 rounded-full animate-spin" />
      </div>
    );
  }

  const isAssigned = exam?.assigned;
  const isCompleted = exam?.completed_at !== null;
  const isStarted = exam?.started_at !== null;

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
        <h1 className="text-2xl font-bold text-white mb-2">Skills Assessment</h1>
        <p className="text-gray-400">
          Complete your assessment to showcase your skills
        </p>
      </motion.div>

      {!isAssigned ? (
        /* Not Assigned */
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="bg-[#111827] border border-white/10 rounded-2xl p-8 text-center"
        >
          <div className="w-20 h-20 mx-auto mb-6 rounded-full bg-orange-500/10 flex items-center justify-center">
            <span className="material-symbols-outlined text-4xl text-orange-400">
              quiz
            </span>
          </div>
          <h2 className="text-xl font-bold text-white mb-3">
            Assessment Not Yet Assigned
          </h2>
          <p className="text-gray-400 max-w-md mx-auto">
            Your assessment hasn&apos;t been assigned yet. You&apos;ll receive a notification 
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
          <div className="bg-emerald-500/10 border border-emerald-500/20 rounded-2xl p-8">
            <div className="flex flex-col md:flex-row items-center justify-between gap-6">
              <div className="flex items-center gap-6">
                <div className="w-20 h-20 rounded-2xl bg-emerald-500/20 flex items-center justify-center">
                  <span className="material-symbols-outlined text-4xl text-emerald-400">
                    check_circle
                  </span>
                </div>
                <div>
                  <h2 className="text-xl font-bold text-white mb-2">
                    Assessment Completed
                  </h2>
                  <p className="text-gray-400">
                    Completed on {new Date(exam.completed_at!).toLocaleDateString()}
                  </p>
                </div>
              </div>

              {exam.score !== null && (
                <div className="text-center">
                  <div className="text-5xl font-bold text-emerald-400">{exam.score}%</div>
                  <div className="text-sm text-gray-400">Your Score</div>
                </div>
              )}
            </div>
          </div>

          {/* Score Breakdown */}
          {exam.score !== null && (
            <div className="bg-[#111827] border border-white/10 rounded-2xl p-6">
              <h3 className="font-bold text-white mb-4">Score Analysis</h3>
              <div className="space-y-4">
                <div>
                  <div className="flex justify-between text-sm mb-2">
                    <span className="text-gray-400">Overall Performance</span>
                    <span className="text-white font-medium">{exam.score}%</span>
                  </div>
                  <div className="h-3 bg-white/10 rounded-full overflow-hidden">
                    <div
                      className={`h-full rounded-full transition-all duration-1000 ${
                        exam.score >= 80
                          ? 'bg-emerald-500'
                          : exam.score >= 60
                          ? 'bg-yellow-500'
                          : 'bg-red-500'
                      }`}
                      style={{ width: `${exam.score}%` }}
                    />
                  </div>
                </div>
                <p className={`text-sm ${
                  exam.score >= 80
                    ? 'text-emerald-400'
                    : exam.score >= 60
                    ? 'text-yellow-400'
                    : 'text-red-400'
                }`}>
                  {exam.score >= 80
                    ? '🎉 Excellent performance! You demonstrated strong skills.'
                    : exam.score >= 60
                    ? '👍 Good job! You showed solid understanding.'
                    : 'Keep practicing! Every experience is a learning opportunity.'}
                </p>
              </div>
            </div>
          )}

          {/* Next Steps */}
          <div className="bg-[#111827] border border-white/10 rounded-2xl p-6">
            <h3 className="font-bold text-white mb-4">What&apos;s Next?</h3>
            <div className="space-y-3">
              <div className="flex items-start gap-3">
                <div className="w-8 h-8 rounded-full bg-purple-500/10 flex items-center justify-center shrink-0">
                  <span className="material-symbols-outlined text-sm text-purple-400">rate_review</span>
                </div>
                <div>
                  <p className="text-white font-medium">Results Review</p>
                  <p className="text-sm text-gray-400">Your assessment is being reviewed by our team</p>
                </div>
              </div>
              <div className="flex items-start gap-3">
                <div className="w-8 h-8 rounded-full bg-cyan-500/10 flex items-center justify-center shrink-0">
                  <span className="material-symbols-outlined text-sm text-cyan-400">videocam</span>
                </div>
                <div>
                  <p className="text-white font-medium">AI Interview</p>
                  <p className="text-sm text-gray-400">If selected, you&apos;ll be invited for an AI interview</p>
                </div>
              </div>
            </div>
          </div>
        </motion.div>
      ) : (
        /* Ready to Take */
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="space-y-6"
        >
          {/* Exam Card */}
          <div className="bg-gradient-to-br from-orange-500/10 to-amber-500/10 border border-orange-500/20 rounded-2xl p-8">
            <div className="flex flex-col md:flex-row md:items-center justify-between gap-6">
              <div className="flex items-center gap-6">
                <div className="w-20 h-20 rounded-2xl bg-orange-500/20 flex items-center justify-center">
                  <span className="material-symbols-outlined text-4xl text-orange-400">
                    quiz
                  </span>
                </div>
                <div>
                  <h2 className="text-xl font-bold text-white mb-2">
                    Skills Assessment
                  </h2>
                  <div className="space-y-1 text-gray-400">
                    <p className="flex items-center gap-2">
                      <span className="material-symbols-outlined text-sm">timer</span>
                      Duration: 60 minutes
                    </p>
                    {exam.access_code && (
                      <p className="flex items-center gap-2">
                        <span className="material-symbols-outlined text-sm">key</span>
                        Access Code: <span className="font-mono text-orange-400">{exam.access_code}</span>
                      </p>
                    )}
                  </div>
                </div>
              </div>

              <Link
                href={exam.exam_url || `/exam/${exam.access_code}`}
                className="px-8 py-4 bg-orange-500 text-white font-bold rounded-xl hover:bg-orange-600 transition-colors flex items-center gap-2 shadow-lg shadow-orange-500/25"
              >
                <span className="material-symbols-outlined">play_arrow</span>
                {isStarted ? 'Continue Exam' : 'Start Exam'}
              </Link>
            </div>
          </div>

          {/* Instructions */}
          <div className="bg-[#111827] border border-white/10 rounded-2xl p-6">
            <h3 className="font-bold text-white mb-4 flex items-center gap-2">
              <span className="material-symbols-outlined text-blue-400">info</span>
              Before You Begin
            </h3>
            <div className="space-y-4 text-gray-400">
              <p>{exam.instructions || "Please read the following instructions carefully before starting your assessment."}</p>
              <ul className="space-y-2">
                <li className="flex items-start gap-2">
                  <span className="material-symbols-outlined text-yellow-400 text-sm mt-0.5">warning</span>
                  Once started, the timer cannot be paused
                </li>
                <li className="flex items-start gap-2">
                  <span className="material-symbols-outlined text-emerald-400 text-sm mt-0.5">check_circle</span>
                  Ensure you have a stable internet connection
                </li>
                <li className="flex items-start gap-2">
                  <span className="material-symbols-outlined text-emerald-400 text-sm mt-0.5">check_circle</span>
                  Find a quiet place without distractions
                </li>
                <li className="flex items-start gap-2">
                  <span className="material-symbols-outlined text-emerald-400 text-sm mt-0.5">check_circle</span>
                  Close all unnecessary browser tabs
                </li>
                <li className="flex items-start gap-2">
                  <span className="material-symbols-outlined text-emerald-400 text-sm mt-0.5">check_circle</span>
                  Have a pen and paper ready for notes
                </li>
              </ul>
            </div>
          </div>

          {/* Tips */}
          <div className="bg-blue-500/10 border border-blue-500/20 rounded-2xl p-6">
            <h3 className="font-bold text-white mb-4 flex items-center gap-2">
              <span className="material-symbols-outlined text-blue-400">lightbulb</span>
              Pro Tips
            </h3>
            <div className="grid sm:grid-cols-2 gap-4 text-sm text-gray-400">
              <div className="flex items-start gap-2">
                <span className="text-blue-400">•</span>
                Read each question carefully before answering
              </div>
              <div className="flex items-start gap-2">
                <span className="text-blue-400">•</span>
                Don&apos;t spend too long on difficult questions
              </div>
              <div className="flex items-start gap-2">
                <span className="text-blue-400">•</span>
                Review your answers if time permits
              </div>
              <div className="flex items-start gap-2">
                <span className="text-blue-400">•</span>
                Trust your instincts on uncertain questions
              </div>
            </div>
          </div>
        </motion.div>
      )}
    </div>
  );
}

