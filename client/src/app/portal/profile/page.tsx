"use client";

import { useState, useEffect } from "react";
import { motion } from "motion/react";
import { useCandidateAuth } from "@/providers/candidate-auth-provider";
import { useUpdateCandidateProfile } from "@/features/candidate/hooks/use-candidate-auth";

export default function ProfilePage() {
  const { candidate } = useCandidateAuth();
  const updateMutation = useUpdateCandidateProfile();

  const [formData, setFormData] = useState({
    full_name: "",
    phone: "",
    linkedin_url: "",
    portfolio_url: "",
  });
  const [hasChanges, setHasChanges] = useState(false);
  const [showSuccess, setShowSuccess] = useState(false);

  // Initialize form with candidate data
  useEffect(() => {
    if (candidate) {
      setFormData({
        full_name: candidate.full_name || "",
        phone: candidate.phone || "",
        linkedin_url: candidate.linkedin_url || "",
        portfolio_url: candidate.portfolio_url || "",
      });
    }
  }, [candidate]);

  // Check for changes
  useEffect(() => {
    if (candidate) {
      const changed =
        formData.full_name !== (candidate.full_name || "") ||
        formData.phone !== (candidate.phone || "") ||
        formData.linkedin_url !== (candidate.linkedin_url || "") ||
        formData.portfolio_url !== (candidate.portfolio_url || "");
      setHasChanges(changed);
    }
  }, [formData, candidate]);

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setFormData((prev) => ({ ...prev, [e.target.name]: e.target.value }));
    setShowSuccess(false);
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    try {
      await updateMutation.mutateAsync({
        full_name: formData.full_name || undefined,
        phone: formData.phone || undefined,
        linkedin_url: formData.linkedin_url || undefined,
        portfolio_url: formData.portfolio_url || undefined,
      });
      setHasChanges(false);
      setShowSuccess(true);
      setTimeout(() => setShowSuccess(false), 3000);
    } catch (error) {
      console.error("Failed to update profile:", error);
    }
  };

  return (
    <div className="max-w-2xl mx-auto space-y-8">
      {/* Header */}
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
      >
        <h1 className="text-2xl font-bold text-white mb-2">Profile Settings</h1>
        <p className="text-gray-400">
          Manage your personal information and preferences
        </p>
      </motion.div>

      {/* Profile Card */}
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ delay: 0.1 }}
        className="bg-[#111827] border border-white/10 rounded-2xl overflow-hidden"
      >
        {/* Avatar Section */}
        <div className="p-6 border-b border-white/10 bg-gradient-to-r from-emerald-500/10 to-teal-500/10">
          <div className="flex items-center gap-4">
            <div className="w-20 h-20 rounded-full bg-emerald-500/20 flex items-center justify-center">
              <span className="text-3xl font-bold text-emerald-400">
                {candidate?.full_name?.charAt(0) ||
                  candidate?.email?.charAt(0) ||
                  "?"}
              </span>
            </div>
            <div>
              <h2 className="text-xl font-bold text-white">
                {candidate?.full_name || "Candidate"}
              </h2>
              <p className="text-gray-400">{candidate?.email}</p>
              {candidate?.email_verified ? (
                <span className="inline-flex items-center gap-1 mt-2 text-xs text-emerald-400">
                  <span className="material-symbols-outlined text-sm">
                    verified
                  </span>
                  Email Verified
                </span>
              ) : (
                <span className="inline-flex items-center gap-1 mt-2 text-xs text-yellow-400">
                  <span className="material-symbols-outlined text-sm">
                    warning
                  </span>
                  Email Not Verified
                </span>
              )}
            </div>
          </div>
        </div>

        {/* Form */}
        <form onSubmit={handleSubmit} className="p-6 space-y-6">
          {/* Success Message */}
          {showSuccess && (
            <motion.div
              initial={{ opacity: 0, y: -10 }}
              animate={{ opacity: 1, y: 0 }}
              exit={{ opacity: 0 }}
              className="p-4 bg-emerald-500/10 border border-emerald-500/20 rounded-lg"
            >
              <p className="text-sm text-emerald-400 flex items-center gap-2">
                <span className="material-symbols-outlined text-sm">
                  check_circle
                </span>
                Profile updated successfully!
              </p>
            </motion.div>
          )}

          {/* Full Name */}
          <div>
            <label className="block text-sm font-medium text-gray-300 mb-2">
              Full Name
            </label>
            <div className="relative">
              <span className="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-gray-500">
                badge
              </span>
              <input
                type="text"
                name="full_name"
                value={formData.full_name}
                onChange={handleChange}
                placeholder="John Doe"
                className="w-full pl-10 pr-4 py-3 bg-[#1a2234] border border-white/10 rounded-lg text-white placeholder-gray-500 focus:outline-none focus:border-emerald-500 focus:ring-1 focus:ring-emerald-500 transition-all"
              />
            </div>
          </div>

          {/* Email (Read-only) */}
          <div>
            <label className="block text-sm font-medium text-gray-300 mb-2">
              Email Address
            </label>
            <div className="relative">
              <span className="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-gray-500">
                mail
              </span>
              <input
                type="email"
                value={candidate?.email || ""}
                disabled
                className="w-full pl-10 pr-4 py-3 bg-[#1a2234]/50 border border-white/10 rounded-lg text-gray-500 cursor-not-allowed"
              />
            </div>
            <p className="text-xs text-gray-500 mt-1">
              Email cannot be changed
            </p>
          </div>

          {/* Phone */}
          <div>
            <label className="block text-sm font-medium text-gray-300 mb-2">
              Phone Number
            </label>
            <div className="relative">
              <span className="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-gray-500">
                phone
              </span>
              <input
                type="tel"
                name="phone"
                value={formData.phone}
                onChange={handleChange}
                placeholder="+1 (555) 000-0000"
                className="w-full pl-10 pr-4 py-3 bg-[#1a2234] border border-white/10 rounded-lg text-white placeholder-gray-500 focus:outline-none focus:border-emerald-500 focus:ring-1 focus:ring-emerald-500 transition-all"
              />
            </div>
          </div>

          {/* LinkedIn URL */}
          <div>
            <label className="block text-sm font-medium text-gray-300 mb-2">
              LinkedIn Profile
            </label>
            <div className="relative">
              <span className="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-gray-500">
                link
              </span>
              <input
                type="url"
                name="linkedin_url"
                value={formData.linkedin_url}
                onChange={handleChange}
                placeholder="https://linkedin.com/in/yourprofile"
                className="w-full pl-10 pr-4 py-3 bg-[#1a2234] border border-white/10 rounded-lg text-white placeholder-gray-500 focus:outline-none focus:border-emerald-500 focus:ring-1 focus:ring-emerald-500 transition-all"
              />
            </div>
          </div>

          {/* Portfolio URL */}
          <div>
            <label className="block text-sm font-medium text-gray-300 mb-2">
              Portfolio Website
            </label>
            <div className="relative">
              <span className="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-gray-500">
                language
              </span>
              <input
                type="url"
                name="portfolio_url"
                value={formData.portfolio_url}
                onChange={handleChange}
                placeholder="https://yourportfolio.com"
                className="w-full pl-10 pr-4 py-3 bg-[#1a2234] border border-white/10 rounded-lg text-white placeholder-gray-500 focus:outline-none focus:border-emerald-500 focus:ring-1 focus:ring-emerald-500 transition-all"
              />
            </div>
          </div>

          {/* Submit Button */}
          <div className="pt-4">
            <button
              type="submit"
              disabled={!hasChanges || updateMutation.isPending}
              className="w-full py-3 px-4 bg-emerald-500 text-white font-bold rounded-lg hover:bg-emerald-600 disabled:opacity-50 disabled:cursor-not-allowed transition-all flex items-center justify-center gap-2"
            >
              {updateMutation.isPending ? (
                <>
                  <div className="w-5 h-5 border-2 border-white/30 border-t-white rounded-full animate-spin" />
                  Saving...
                </>
              ) : (
                <>
                  <span className="material-symbols-outlined">save</span>
                  Save Changes
                </>
              )}
            </button>
          </div>
        </form>
      </motion.div>

      {/* Account Info */}
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ delay: 0.2 }}
        className="bg-[#111827] border border-white/10 rounded-2xl p-6"
      >
        <h3 className="font-bold text-white mb-4">Account Information</h3>
        <div className="space-y-3 text-sm">
          <div className="flex justify-between">
            <span className="text-gray-400">Member Since</span>
            <span className="text-white">
              {candidate?.created_at
                ? new Date(candidate.created_at).toLocaleDateString("en-US", {
                    year: "numeric",
                    month: "long",
                    day: "numeric",
                  })
                : "-"}
            </span>
          </div>
          <div className="flex justify-between">
            <span className="text-gray-400">Account Status</span>
            <span
              className={
                candidate?.is_active ? "text-emerald-400" : "text-red-400"
              }
            >
              {candidate?.is_active ? "Active" : "Inactive"}
            </span>
          </div>
        </div>
      </motion.div>

      {/* Danger Zone */}
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ delay: 0.3 }}
        className="bg-[#111827] border border-red-500/20 rounded-2xl p-6"
      >
        <h3 className="font-bold text-white mb-2">Danger Zone</h3>
        <p className="text-sm text-gray-400 mb-4">
          These actions are irreversible. Please proceed with caution.
        </p>
        <button className="px-4 py-2 bg-red-500/10 text-red-400 border border-red-500/20 rounded-lg text-sm font-medium hover:bg-red-500/20 transition-colors">
          Delete Account
        </button>
      </motion.div>
    </div>
  );
}

