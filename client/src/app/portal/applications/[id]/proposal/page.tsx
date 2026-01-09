"use client";

import { useState } from "react";
import { useParams, useRouter } from "next/navigation";
import { motion, AnimatePresence } from "motion/react";
import Link from "next/link";
import { useProposalInfo, useRespondToProposal, useCandidateApplication } from "@/features/candidate/hooks/use-candidate-applications";

export default function ProposalPage() {
  const params = useParams();
  const router = useRouter();
  const appId = Number(params.id);
  const { data: proposal, isLoading } = useProposalInfo(appId);
  const { data: application } = useCandidateApplication(appId);
  const respondMutation = useRespondToProposal();

  const [showConfirmModal, setShowConfirmModal] = useState<'accept' | 'decline' | null>(null);

  const handleRespond = async (accepted: boolean) => {
    try {
      await respondMutation.mutateAsync({
        appId,
        response: { accepted },
      });
      setShowConfirmModal(null);
    } catch (error) {
      console.error('Failed to respond to proposal:', error);
    }
  };

  const formatSalary = (amount: number | null, currency: string) => {
    if (!amount) return 'Competitive';
    return new Intl.NumberFormat('en-US', {
      style: 'currency',
      currency,
      maximumFractionDigits: 0,
    }).format(amount);
  };

  if (isLoading) {
    return (
      <div className="flex items-center justify-center min-h-[400px]">
        <div className="w-10 h-10 border-4 border-emerald-500/30 border-t-emerald-500 rounded-full animate-spin" />
      </div>
    );
  }

  const hasSentProposal = proposal?.sent_at !== null;
  const hasResponded = proposal?.accepted !== null;

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
        <h1 className="text-2xl font-bold text-white mb-2">Job Offer</h1>
        <p className="text-gray-400">
          Review your job offer details
        </p>
      </motion.div>

      {!hasSentProposal ? (
        /* No Proposal Yet */
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="bg-[#111827] border border-white/10 rounded-2xl p-8 text-center"
        >
          <div className="w-20 h-20 mx-auto mb-6 rounded-full bg-emerald-500/10 flex items-center justify-center">
            <span className="material-symbols-outlined text-4xl text-emerald-400">
              hourglass_empty
            </span>
          </div>
          <h2 className="text-xl font-bold text-white mb-3">
            No Offer Yet
          </h2>
          <p className="text-gray-400 max-w-md mx-auto">
            You haven&apos;t received a job offer for this position yet. 
            Keep checking back for updates!
          </p>
        </motion.div>
      ) : hasResponded ? (
        /* Already Responded */
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="space-y-6"
        >
          <div className={`rounded-2xl p-8 text-center ${
            proposal.accepted
              ? 'bg-emerald-500/10 border border-emerald-500/20'
              : 'bg-gray-500/10 border border-gray-500/20'
          }`}>
            <div className={`w-20 h-20 mx-auto mb-6 rounded-full flex items-center justify-center ${
              proposal.accepted ? 'bg-emerald-500/20' : 'bg-gray-500/20'
            }`}>
              <span className={`material-symbols-outlined text-4xl ${
                proposal.accepted ? 'text-emerald-400' : 'text-gray-400'
              }`}>
                {proposal.accepted ? 'celebration' : 'close'}
              </span>
            </div>
            <h2 className="text-2xl font-bold text-white mb-3">
              {proposal.accepted ? '🎉 Congratulations!' : 'Offer Declined'}
            </h2>
            <p className="text-gray-400 max-w-md mx-auto">
              {proposal.accepted
                ? 'Welcome to the team! We\'re excited to have you on board. Our HR team will reach out with next steps.'
                : 'You have declined this offer. We appreciate your consideration and wish you the best in your career journey.'}
            </p>
          </div>

          {proposal.accepted && (
            <div className="bg-[#111827] border border-white/10 rounded-2xl p-6">
              <h3 className="font-bold text-white mb-4">What&apos;s Next?</h3>
              <div className="space-y-3">
                <div className="flex items-start gap-3">
                  <div className="w-8 h-8 rounded-full bg-blue-500/10 flex items-center justify-center shrink-0">
                    <span className="material-symbols-outlined text-sm text-blue-400">mail</span>
                  </div>
                  <div>
                    <p className="text-white font-medium">Official Offer Letter</p>
                    <p className="text-sm text-gray-400">You&apos;ll receive the official offer letter via email</p>
                  </div>
                </div>
                <div className="flex items-start gap-3">
                  <div className="w-8 h-8 rounded-full bg-purple-500/10 flex items-center justify-center shrink-0">
                    <span className="material-symbols-outlined text-sm text-purple-400">edit_document</span>
                  </div>
                  <div>
                    <p className="text-white font-medium">Paperwork</p>
                    <p className="text-sm text-gray-400">Complete the necessary onboarding documents</p>
                  </div>
                </div>
                <div className="flex items-start gap-3">
                  <div className="w-8 h-8 rounded-full bg-emerald-500/10 flex items-center justify-center shrink-0">
                    <span className="material-symbols-outlined text-sm text-emerald-400">event</span>
                  </div>
                  <div>
                    <p className="text-white font-medium">Start Date</p>
                    <p className="text-sm text-gray-400">Confirm your start date with HR</p>
                  </div>
                </div>
              </div>
            </div>
          )}
        </motion.div>
      ) : (
        /* Pending Response */
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="space-y-6"
        >
          {/* Offer Card */}
          <div className="bg-gradient-to-br from-emerald-500/10 to-teal-500/10 border border-emerald-500/20 rounded-2xl overflow-hidden">
            <div className="p-8">
              <div className="flex items-center gap-3 mb-6">
                <div className="w-12 h-12 rounded-xl bg-emerald-500/20 flex items-center justify-center">
                  <span className="material-symbols-outlined text-2xl text-emerald-400">
                    handshake
                  </span>
                </div>
                <div>
                  <p className="text-emerald-400 text-sm font-medium">Job Offer</p>
                  <h2 className="text-xl font-bold text-white">{proposal.position || application?.job_title}</h2>
                </div>
              </div>

              {/* Salary */}
              <div className="bg-white/5 rounded-xl p-6 mb-6">
                <p className="text-sm text-gray-400 mb-2">Annual Compensation</p>
                <p className="text-4xl font-bold text-white">
                  {formatSalary(proposal.salary_offer, proposal.salary_currency)}
                </p>
              </div>

              {/* Details Grid */}
              <div className="grid sm:grid-cols-2 gap-4 mb-6">
                {proposal.start_date && (
                  <div className="bg-white/5 rounded-xl p-4">
                    <p className="text-sm text-gray-400 mb-1">Start Date</p>
                    <p className="text-white font-medium flex items-center gap-2">
                      <span className="material-symbols-outlined text-sm text-emerald-400">event</span>
                      {proposal.start_date}
                    </p>
                  </div>
                )}
                <div className="bg-white/5 rounded-xl p-4">
                  <p className="text-sm text-gray-400 mb-1">Offer Sent</p>
                  <p className="text-white font-medium flex items-center gap-2">
                    <span className="material-symbols-outlined text-sm text-blue-400">schedule</span>
                    {new Date(proposal.sent_at!).toLocaleDateString()}
                  </p>
                </div>
              </div>

              {/* Benefits */}
              {proposal.benefits && proposal.benefits.length > 0 && (
                <div className="mb-6">
                  <p className="text-sm text-gray-400 mb-3">Benefits Package</p>
                  <div className="grid sm:grid-cols-2 gap-2">
                    {proposal.benefits.map((benefit, index) => (
                      <div key={index} className="flex items-center gap-2 text-white">
                        <span className="material-symbols-outlined text-sm text-emerald-400">check_circle</span>
                        {benefit}
                      </div>
                    ))}
                  </div>
                </div>
              )}

              {/* Notes */}
              {proposal.additional_notes && (
                <div className="bg-white/5 rounded-xl p-4">
                  <p className="text-sm text-gray-400 mb-2">Message from HR</p>
                  <p className="text-white">{proposal.additional_notes}</p>
                </div>
              )}
            </div>

            {/* Action Buttons */}
            <div className="border-t border-white/10 p-6 bg-[#111827]">
              <div className="flex flex-col sm:flex-row gap-3">
                <button
                  onClick={() => setShowConfirmModal('accept')}
                  className="flex-1 py-4 px-6 bg-emerald-500 text-white font-bold rounded-xl hover:bg-emerald-600 transition-colors flex items-center justify-center gap-2"
                >
                  <span className="material-symbols-outlined">check</span>
                  Accept Offer
                </button>
                <button
                  onClick={() => setShowConfirmModal('decline')}
                  className="flex-1 py-4 px-6 bg-white/10 text-white font-bold rounded-xl hover:bg-white/20 transition-colors flex items-center justify-center gap-2"
                >
                  <span className="material-symbols-outlined">close</span>
                  Decline
                </button>
              </div>
            </div>
          </div>

          {/* Tips */}
          <div className="bg-blue-500/10 border border-blue-500/20 rounded-2xl p-6">
            <h3 className="font-bold text-white mb-3 flex items-center gap-2">
              <span className="material-symbols-outlined text-blue-400">lightbulb</span>
              Things to Consider
            </h3>
            <ul className="space-y-2 text-sm text-gray-400">
              <li className="flex items-start gap-2">
                <span className="text-blue-400">•</span>
                Review the entire compensation package, not just salary
              </li>
              <li className="flex items-start gap-2">
                <span className="text-blue-400">•</span>
                Consider the career growth opportunities
              </li>
              <li className="flex items-start gap-2">
                <span className="text-blue-400">•</span>
                Take time to make a thoughtful decision
              </li>
              <li className="flex items-start gap-2">
                <span className="text-blue-400">•</span>
                Contact HR if you have any questions
              </li>
            </ul>
          </div>
        </motion.div>
      )}

      {/* Confirmation Modal */}
      <AnimatePresence>
        {showConfirmModal && (
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/60"
            onClick={() => setShowConfirmModal(null)}
          >
            <motion.div
              initial={{ scale: 0.95, opacity: 0 }}
              animate={{ scale: 1, opacity: 1 }}
              exit={{ scale: 0.95, opacity: 0 }}
              onClick={(e) => e.stopPropagation()}
              className="w-full max-w-md bg-[#111827] border border-white/10 rounded-2xl p-6"
            >
              <div className={`w-16 h-16 mx-auto mb-4 rounded-full flex items-center justify-center ${
                showConfirmModal === 'accept' ? 'bg-emerald-500/20' : 'bg-red-500/20'
              }`}>
                <span className={`material-symbols-outlined text-3xl ${
                  showConfirmModal === 'accept' ? 'text-emerald-400' : 'text-red-400'
                }`}>
                  {showConfirmModal === 'accept' ? 'check' : 'close'}
                </span>
              </div>

              <h3 className="text-xl font-bold text-white text-center mb-2">
                {showConfirmModal === 'accept' ? 'Accept This Offer?' : 'Decline This Offer?'}
              </h3>
              <p className="text-gray-400 text-center mb-6">
                {showConfirmModal === 'accept'
                  ? 'By accepting, you agree to join the team. This action cannot be undone.'
                  : 'Are you sure you want to decline? This action cannot be undone.'}
              </p>

              <div className="flex gap-3">
                <button
                  onClick={() => setShowConfirmModal(null)}
                  className="flex-1 py-3 px-4 bg-white/10 text-white font-bold rounded-xl hover:bg-white/20 transition-colors"
                >
                  Cancel
                </button>
                <button
                  onClick={() => handleRespond(showConfirmModal === 'accept')}
                  disabled={respondMutation.isPending}
                  className={`flex-1 py-3 px-4 font-bold rounded-xl transition-colors flex items-center justify-center gap-2 ${
                    showConfirmModal === 'accept'
                      ? 'bg-emerald-500 text-white hover:bg-emerald-600'
                      : 'bg-red-500 text-white hover:bg-red-600'
                  }`}
                >
                  {respondMutation.isPending ? (
                    <div className="w-5 h-5 border-2 border-white/30 border-t-white rounded-full animate-spin" />
                  ) : showConfirmModal === 'accept' ? (
                    'Accept'
                  ) : (
                    'Decline'
                  )}
                </button>
              </div>
            </motion.div>
          </motion.div>
        )}
      </AnimatePresence>
    </div>
  );
}

