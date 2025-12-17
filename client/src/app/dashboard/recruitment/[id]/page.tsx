"use client";

import React, { useState, useMemo } from "react";
import Link from "next/link";
import { useParams } from "next/navigation";
import { motion, AnimatePresence } from "motion/react";
import { useJobApplications } from "@/features/recruitment/hooks/use-applications";
import { useJob } from "@/features/recruitment/hooks/use-jobs";

export default function JobDetailsPage() {
  const params = useParams();
  const jobId = Number(params.id);
  const [activeTab, setActiveTab] = useState("overview");
  
  // Fetch job details and applications from database
  const { data: jobDetails, isLoading: isLoadingJob, error: jobError } = useJob(jobId);
  const { data: applications = [], isLoading: isLoadingApplications } = useJobApplications(jobId);

  // Calculate stats from real data
  const stats = useMemo(() => {
    const totalApplications = applications.length;
    const newApplications = applications.filter(app => app.status === "New").length;
    const shortlisted = applications.filter(app => app.status === "Shortlisted").length;
    const interviewed = applications.filter(app => app.status === "Interview").length;
    
    // Calculate new applications in last 7 days
    const sevenDaysAgo = new Date();
    sevenDaysAgo.setDate(sevenDaysAgo.getDate() - 7);
    const newInLast7Days = applications.filter(app => {
      const appliedDate = new Date(app.applied_at);
      return appliedDate >= sevenDaysAgo;
    }).length;

    return [
      { label: "Total Applications", value: totalApplications.toString() },
      { label: "New (7 days)", value: newInLast7Days.toString() },
      { label: "Total Views", value: "-" }, // Not tracked yet
      { label: "Conversion Rate", value: "-" }, // Not calculated yet
      { label: "Shortlisted", value: shortlisted.toString() },
      { label: "Interviewed", value: interviewed.toString() },
    ];
  }, [applications]);

  // Format salary range
  const formatSalaryRange = (min: number | null, max: number | null, currency: string | null) => {
    if (!min && !max) return "Not specified";
    const curr = currency || "USD";
    if (min && max) return `${curr} ${min.toLocaleString()} - ${max.toLocaleString()}`;
    if (min) return `${curr} ${min.toLocaleString()}+`;
    return `Up to ${curr} ${max?.toLocaleString()}`;
  };

  // Loading state
  if (isLoadingJob) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="flex flex-col items-center gap-4">
          <div className="animate-spin h-8 w-8 border-4 border-primary border-t-transparent rounded-full"></div>
          <p className="text-text-secondary-light dark:text-text-secondary-dark">Loading job details...</p>
        </div>
      </div>
    );
  }

  // Error state
  if (jobError || !jobDetails) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="flex flex-col items-center gap-4 text-center">
          <span className="material-symbols-outlined text-5xl text-red-500">error</span>
          <p className="text-text-primary-light dark:text-text-primary-dark font-bold">Job posting not found</p>
          <p className="text-text-secondary-light dark:text-text-secondary-dark">The job posting you're looking for doesn't exist or has been removed.</p>
          <Link href="/dashboard/recruitment" className="px-4 py-2 bg-primary text-white rounded-lg font-bold hover:bg-primary/90 transition-colors">
            Back to Recruitment
          </Link>
        </div>
      </div>
    );
  }

  return (
    <div className="flex flex-col gap-6 w-full max-w-7xl mx-auto">
      {/* 1. Header Section */}
      <header className="flex flex-wrap justify-between items-start gap-4 pt-4">
        <div className="flex flex-col gap-2">
          <div className="flex items-center gap-4">
            <h1 className="text-3xl md:text-4xl font-black text-text-primary-light dark:text-text-primary-dark tracking-tight">
              {jobDetails.title}
            </h1>
            <span className={`inline-flex items-center px-3 py-1 rounded-full text-sm font-medium ring-1 ring-inset ${
              jobDetails.status === "Active" 
                ? "bg-green-100 dark:bg-green-500/10 text-green-800 dark:text-green-400 ring-green-500/20"
                : jobDetails.status === "Draft"
                ? "bg-gray-100 dark:bg-gray-500/10 text-gray-800 dark:text-gray-400 ring-gray-500/20"
                : "bg-yellow-100 dark:bg-yellow-500/10 text-yellow-800 dark:text-yellow-400 ring-yellow-500/20"
            }`}>
              {jobDetails.status || "Draft"}
            </span>
          </div>
          <p className="text-text-secondary-light dark:text-text-secondary-dark text-base font-normal">
            {jobDetails.department || "Not specified"} • {jobDetails.location || "Remote"} • {jobDetails.work_type || "Full-time"}
          </p>
        </div>
        <div className="flex gap-3 flex-wrap">
          <button className="flex items-center justify-center h-10 px-4 rounded-lg bg-primary text-white text-sm font-bold hover:bg-primary/90 transition-colors">
            Edit Job
          </button>
          <button className="flex items-center justify-center h-10 px-4 rounded-lg bg-card-light dark:bg-card-dark border border-border-light dark:border-border-dark text-text-primary-light dark:text-text-primary-dark text-sm font-bold hover:bg-background-light dark:hover:bg-gray-800 transition-colors">
            Pause Posting
          </button>
          <button className="flex items-center justify-center h-10 px-4 rounded-lg bg-card-light dark:bg-card-dark border border-border-light dark:border-border-dark text-text-primary-light dark:text-text-primary-dark text-sm font-bold hover:bg-background-light dark:hover:bg-gray-800 transition-colors">
            Copy Job Link
          </button>
        </div>
      </header>

      {/* 2. KPI Summary Cards */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-6 gap-4">
        {stats.map((stat, index) => (
          <div
            key={index}
            className="flex flex-col gap-2 rounded-xl p-6 bg-card-light dark:bg-card-dark border border-border-light dark:border-border-dark hover:border-primary/50 dark:hover:border-primary/50 hover:shadow-lg hover:shadow-primary/5 transition-all duration-300 group"
          >
            <p className="text-text-secondary-light dark:text-text-secondary-dark text-sm font-medium">
              {stat.label}
            </p>
            <p className="text-text-primary-light dark:text-text-primary-dark text-2xl font-bold tracking-tight group-hover:text-primary transition-colors">
              {stat.value}
            </p>
          </div>
        ))}
      </div>

      {/* 3. Tab System */}
      <div className="border-b border-border-light dark:border-border-dark mt-2">
        <div className="flex gap-8">
          {["Overview", "Applications", "Analytics", "Internal Notes"].map((tab) => {
            const tabKey = tab.toLowerCase().replace(" ", "-");
            const isActive = activeTab === tabKey;
            return (
              <button
                key={tab}
                onClick={() => setActiveTab(tabKey)}
                className={`pb-4 pt-2 text-sm font-bold relative transition-colors ${
                  isActive
                    ? "text-primary"
                    : "text-text-secondary-light dark:text-text-secondary-dark hover:text-text-primary-light dark:hover:text-text-primary-dark"
                }`}
              >
                {tab}
                {isActive && (
                  <motion.div
                    layoutId="activeTab"
                    className="absolute bottom-0 left-0 right-0 h-0.5 bg-primary shadow-[0_0_10px_rgba(48,110,232,0.5)]"
                  />
                )}
              </button>
            );
          })}
        </div>
      </div>

      {/* Tab Content */}
      <div className="py-4">
        <AnimatePresence mode="wait">
          {activeTab === "overview" && (
            <OverviewTab key="overview" job={jobDetails} salaryRange={formatSalaryRange(jobDetails.salary_range_min, jobDetails.salary_range_max, jobDetails.salary_currency)} />
          )}
          {activeTab === "applications" && (
            <ApplicationsTab key="applications" applications={applications} isLoading={isLoadingApplications} />
          )}
          {activeTab === "analytics" && (
            <AnalyticsTab key="analytics" />
          )}
          {activeTab === "internal-notes" && (
            <InternalNotesTab key="notes" />
          )}
        </AnimatePresence>
      </div>
    </div>
  );
}

// Sub-components

function OverviewTab({ job, salaryRange }: { job: any; salaryRange: string }) {
  return (
    <motion.div
      initial={{ opacity: 0, y: 10 }}
      animate={{ opacity: 1, y: 0 }}
      exit={{ opacity: 0, y: -10 }}
      className="grid gap-6"
    >
      <CollapsibleCard title="Job Description">
        <p className="text-text-secondary-light dark:text-text-secondary-dark leading-relaxed">
          {job.description || "No description provided."}
        </p>
      </CollapsibleCard>

      {job.responsibilities && job.responsibilities.length > 0 && (
        <CollapsibleCard title="Responsibilities">
          <ul className="list-disc list-inside space-y-2 text-text-secondary-light dark:text-text-secondary-dark">
            {job.responsibilities.map((item: string, i: number) => (
              <li key={i}>{item}</li>
            ))}
          </ul>
        </CollapsibleCard>
      )}

      {job.requirements && job.requirements.length > 0 && (
        <CollapsibleCard title="Requirements">
          <ul className="list-disc list-inside space-y-2 text-text-secondary-light dark:text-text-secondary-dark">
            {job.requirements.map((item: string, i: number) => (
              <li key={i}>{item}</li>
            ))}
          </ul>
        </CollapsibleCard>
      )}

      {job.benefits && job.benefits.length > 0 && (
        <CollapsibleCard title="Benefits">
          <ul className="list-disc list-inside space-y-2 text-text-secondary-light dark:text-text-secondary-dark">
            {job.benefits.map((item: string, i: number) => (
              <li key={i}>{item}</li>
            ))}
          </ul>
        </CollapsibleCard>
      )}

      <CollapsibleCard title="Salary Range (Admin Only)">
        <p className="text-text-primary-light dark:text-text-primary-dark font-medium">
          {salaryRange}
        </p>
      </CollapsibleCard>
    </motion.div>
  );
}

function CollapsibleCard({ title, children }: { title: string; children: React.ReactNode }) {
  const [isOpen, setIsOpen] = useState(true);

  return (
    <div className="bg-card-light dark:bg-card-dark border border-border-light dark:border-border-dark rounded-xl overflow-hidden">
      <button
        onClick={() => setIsOpen(!isOpen)}
        className="w-full flex items-center justify-between p-6 hover:bg-background-light dark:hover:bg-background-dark/50 transition-colors"
      >
        <h3 className="text-lg font-bold text-text-primary-light dark:text-text-primary-dark">
          {title}
        </h3>
        <span
          className={`material-symbols-outlined transition-transform duration-200 ${
            isOpen ? "rotate-180" : ""
          }`}
        >
          expand_more
        </span>
      </button>
      <AnimatePresence>
        {isOpen && (
          <motion.div
            initial={{ height: 0, opacity: 0 }}
            animate={{ height: "auto", opacity: 1 }}
            exit={{ height: 0, opacity: 0 }}
            className="overflow-hidden"
          >
            <div className="p-6 pt-0">{children}</div>
          </motion.div>
        )}
      </AnimatePresence>
    </div>
  );
}

function ApplicationsTab({ applications, isLoading }: { applications: any[]; isLoading: boolean }) {
  const formatDate = (dateString: string) => {
    const date = new Date(dateString);
    return date.toLocaleDateString('en-US', { year: 'numeric', month: '2-digit', day: '2-digit' });
  };

  return (
    <motion.div
      initial={{ opacity: 0, y: 10 }}
      animate={{ opacity: 1, y: 0 }}
      exit={{ opacity: 0, y: -10 }}
      className="flex flex-col gap-6"
    >
      <div className="flex flex-col sm:flex-row gap-4 justify-between items-center">
        <div className="relative w-full sm:max-w-xs">
          <span className="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-text-secondary-light dark:text-text-secondary-dark">
            search
          </span>
          <input
            className="w-full pl-10 pr-4 py-2 text-sm border border-border-light dark:border-border-dark rounded-lg bg-card-light dark:bg-card-dark text-text-primary-light dark:text-text-primary-dark focus:outline-none focus:ring-2 focus:ring-primary/50"
            placeholder="Search candidates..."
          />
        </div>
        <div className="flex gap-4 w-full sm:w-auto">
          <select className="h-10 rounded-lg border border-border-light dark:border-border-dark bg-card-light dark:bg-card-dark text-text-primary-light dark:text-text-primary-dark px-3 text-sm focus:outline-none focus:ring-2 focus:ring-primary/50 w-full sm:w-auto">
            <option>All Statuses</option>
            <option>New</option>
            <option>Shortlisted</option>
            <option>Interview</option>
            <option>Hired</option>
            <option>Rejected</option>
          </select>
          <input
            type="date"
            className="h-10 rounded-lg border border-border-light dark:border-border-dark bg-card-light dark:bg-card-dark text-text-primary-light dark:text-text-primary-dark px-3 text-sm focus:outline-none focus:ring-2 focus:ring-primary/50 w-full sm:w-auto"
          />
        </div>
      </div>

      <div className="overflow-x-auto rounded-xl border border-border-light dark:border-border-dark bg-card-light dark:bg-card-dark">
        <table className="w-full text-sm text-left">
          <thead className="text-xs uppercase bg-background-light dark:bg-background-dark/50 text-text-secondary-light dark:text-text-secondary-dark border-b border-border-light dark:border-border-dark">
            <tr>
              <th className="px-6 py-4 font-bold">Candidate Name</th>
              <th className="px-6 py-4 font-bold">Email</th>
              <th className="px-6 py-4 font-bold">Phone</th>
              <th className="px-6 py-4 font-bold">Applied Date</th>
              <th className="px-6 py-4 font-bold">Source</th>
              <th className="px-6 py-4 font-bold">Status</th>
              <th className="px-6 py-4 font-bold text-center">Actions</th>
            </tr>
          </thead>
          <tbody>
            {isLoading ? (
              <tr>
                <td colSpan={7} className="px-6 py-12 text-center text-text-secondary-light dark:text-text-secondary-dark">
                  <div className="flex items-center justify-center gap-2">
                    <div className="animate-spin h-5 w-5 border-2 border-primary border-t-transparent rounded-full"></div>
                    Loading applications...
                  </div>
                </td>
              </tr>
            ) : applications.length === 0 ? (
              <tr>
                <td colSpan={7} className="px-6 py-12 text-center text-text-secondary-light dark:text-text-secondary-dark">
                  No applications found for this job posting.
                </td>
              </tr>
            ) : (
              applications.map((app) => (
                <tr
                  key={app.id}
                  className="border-b border-border-light dark:border-border-dark hover:bg-background-light dark:hover:bg-background-dark/50 transition-colors"
                >
                  <td className="px-6 py-4 font-medium text-text-primary-light dark:text-text-primary-dark">
                    <Link href="#" className="hover:text-primary transition-colors">
                      {app.candidate_name}
                    </Link>
                  </td>
                  <td className="px-6 py-4 text-text-secondary-light dark:text-text-secondary-dark">
                    {app.email}
                  </td>
                  <td className="px-6 py-4 text-text-secondary-light dark:text-text-secondary-dark">
                    {app.phone || 'N/A'}
                  </td>
                  <td className="px-6 py-4 text-text-secondary-light dark:text-text-secondary-dark">
                    {formatDate(app.applied_at)}
                  </td>
                  <td className="px-6 py-4 text-text-secondary-light dark:text-text-secondary-dark">
                    {app.source || 'Direct'}
                  </td>
                  <td className="px-6 py-4">
                    <StatusBadge status={app.status} />
                  </td>
                  <td className="px-6 py-4">
                    <div className="flex justify-center items-center gap-2">
                      <button className="p-2 text-text-secondary-light dark:text-text-secondary-dark hover:text-primary transition-colors rounded-lg hover:bg-primary/10">
                        <span className="material-symbols-outlined text-xl">visibility</span>
                      </button>
                      <button className="p-2 text-text-secondary-light dark:text-text-secondary-dark hover:text-yellow-500 transition-colors rounded-lg hover:bg-yellow-500/10">
                        <span className="material-symbols-outlined text-xl">star</span>
                      </button>
                      <button className="p-2 text-text-secondary-light dark:text-text-secondary-dark hover:text-red-500 transition-colors rounded-lg hover:bg-red-500/10">
                        <span className="material-symbols-outlined text-xl">thumb_down</span>
                      </button>
                    </div>
                  </td>
                </tr>
              ))
            )}
          </tbody>
        </table>
      </div>
    </motion.div>
  );
}

function StatusBadge({ status }: { status: string }) {
  const styles: Record<string, string> = {
    New: "bg-blue-100 text-blue-700 dark:bg-blue-500/10 dark:text-blue-400 ring-blue-500/20",
    Shortlisted: "bg-yellow-100 text-yellow-700 dark:bg-yellow-500/10 dark:text-yellow-400 ring-yellow-500/20",
    Interview: "bg-purple-100 text-purple-700 dark:bg-purple-500/10 dark:text-purple-400 ring-purple-500/20",
    Hired: "bg-green-100 text-green-700 dark:bg-green-500/10 dark:text-green-400 ring-green-500/20",
    Rejected: "bg-red-100 text-red-700 dark:bg-red-500/10 dark:text-red-400 ring-red-500/20",
  };

  const defaultStyle = "bg-gray-100 text-gray-700 dark:bg-gray-500/10 dark:text-gray-400 ring-gray-500/20";

  return (
    <span
      className={`inline-flex items-center rounded-full px-2 py-1 text-xs font-medium ring-1 ring-inset ${
        styles[status] || defaultStyle
      }`}
    >
      {status}
    </span>
  );
}

function AnalyticsTab() {
  return (
    <motion.div
      initial={{ opacity: 0, y: 10 }}
      animate={{ opacity: 1, y: 0 }}
      exit={{ opacity: 0, y: -10 }}
      className="grid grid-cols-1 lg:grid-cols-2 gap-6"
    >
      <div className="bg-card-light dark:bg-card-dark border border-border-light dark:border-border-dark rounded-xl p-6">
        <h3 className="text-lg font-bold mb-6 text-text-primary-light dark:text-text-primary-dark">
          Applications Over Time
        </h3>
        <div className="h-64 flex items-end justify-between gap-2 px-2">
            {/* Simple CSS Bar Chart Simulation */}
            {[40, 65, 45, 80, 55, 90, 70].map((h, i) => (
                <div key={i} className="flex flex-col items-center gap-2 flex-1 group">
                    <div className="w-full bg-primary/10 rounded-t-sm relative h-full overflow-hidden">
                        <motion.div 
                            initial={{ height: 0 }}
                            animate={{ height: `${h}%` }}
                            transition={{ duration: 1, delay: i * 0.1 }}
                            className="absolute bottom-0 left-0 right-0 bg-linear-to-t from-primary to-primary/60 rounded-t-sm group-hover:from-primary/80 group-hover:to-primary"
                        />
                    </div>
                    <span className="text-xs text-text-secondary-light dark:text-text-secondary-dark">
                        {['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][i]}
                    </span>
                </div>
            ))}
        </div>
      </div>

      <div className="bg-card-light dark:bg-card-dark border border-border-light dark:border-border-dark rounded-xl p-6">
        <h3 className="text-lg font-bold mb-6 text-text-primary-light dark:text-text-primary-dark">
          Source Distribution
        </h3>
        <div className="h-64 flex items-center justify-center">
            {/* Simple CSS Donut Chart Simulation */}
             <div className="relative size-48 rounded-full border-16 border-primary/20 flex items-center justify-center">
                <svg className="absolute inset-0 -rotate-90" viewBox="0 0 100 100">
                    <circle cx="50" cy="50" r="40" fill="none" stroke="currentColor" strokeWidth="16" className="text-primary" strokeDasharray="180 251" />
                    <circle cx="50" cy="50" r="40" fill="none" stroke="currentColor" strokeWidth="16" className="text-purple-500" strokeDasharray="50 251" strokeDashoffset="-180" />
                    <circle cx="50" cy="50" r="40" fill="none" stroke="currentColor" strokeWidth="16" className="text-green-500" strokeDasharray="21 251" strokeDashoffset="-230" />
                </svg>
                <div className="text-center">
                    <p className="text-2xl font-bold text-text-primary-light dark:text-text-primary-dark">Total</p>
                    <p className="text-sm text-text-secondary-light dark:text-text-secondary-dark">1,234</p>
                </div>
             </div>
        </div>
        <div className="flex justify-center gap-6 mt-4">
            <div className="flex items-center gap-2">
                <div className="size-3 rounded-full bg-primary"></div>
                <span className="text-sm text-text-secondary-light dark:text-text-secondary-dark">LinkedIn</span>
            </div>
            <div className="flex items-center gap-2">
                <div className="size-3 rounded-full bg-purple-500"></div>
                <span className="text-sm text-text-secondary-light dark:text-text-secondary-dark">Indeed</span>
            </div>
            <div className="flex items-center gap-2">
                <div className="size-3 rounded-full bg-green-500"></div>
                <span className="text-sm text-text-secondary-light dark:text-text-secondary-dark">Referral</span>
            </div>
        </div>
      </div>
    </motion.div>
  );
}

function InternalNotesTab() {
  const [notes, setNotes] = useState("");
  
  return (
    <motion.div
      initial={{ opacity: 0, y: 10 }}
      animate={{ opacity: 1, y: 0 }}
      exit={{ opacity: 0, y: -10 }}
      className="grid gap-6"
    >
      <div className="bg-card-light dark:bg-card-dark border border-border-light dark:border-border-dark rounded-xl p-6">
        <h3 className="text-lg font-bold mb-4 text-text-primary-light dark:text-text-primary-dark">
          Internal Notes
        </h3>
        <textarea
          value={notes}
          onChange={(e) => setNotes(e.target.value)}
          className="w-full h-32 p-4 rounded-lg bg-background-light dark:bg-background-dark border border-border-light dark:border-border-dark text-text-primary-light dark:text-text-primary-dark focus:outline-none focus:ring-2 focus:ring-primary/50 resize-none"
          placeholder="Add internal notes about this position..."
        ></textarea>
        <div className="flex justify-end mt-4">
            <button className="px-4 py-2 bg-primary text-white rounded-lg font-bold text-sm hover:bg-primary/90 transition-colors">
                Save Notes
            </button>
        </div>
      </div>

      <div className="bg-card-light dark:bg-card-dark border border-border-light dark:border-border-dark rounded-xl p-6">
        <h3 className="text-lg font-bold mb-4 text-text-primary-light dark:text-text-primary-dark">
          Activity Log
        </h3>
        <div className="flex flex-col gap-6">
            {[
                { action: "New candidate applied", detail: "Michael Brown applied via LinkedIn", time: "2 hours ago", icon: "person_add" },
                { action: "Status changed", detail: "Changed from Draft to Active", time: "1 day ago", icon: "sync" },
                { action: "Job updated", detail: "Updated salary range", time: "2 days ago", icon: "edit" },
            ].map((log, i) => (
                <div key={i} className="flex gap-4 relative">
                    {i !== 2 && <div className="absolute left-[19px] top-10 bottom-[-24px] w-0.5 bg-border-light dark:bg-border-dark"></div>}
                    <div className="size-10 rounded-full bg-primary/10 flex items-center justify-center shrink-0 text-primary">
                        <span className="material-symbols-outlined text-xl">{log.icon}</span>
                    </div>
                    <div className="flex flex-col pt-1">
                        <p className="text-sm font-bold text-text-primary-light dark:text-text-primary-dark">{log.action}</p>
                        <p className="text-sm text-text-secondary-light dark:text-text-secondary-dark">{log.detail}</p>
                        <p className="text-xs text-text-secondary-light dark:text-text-secondary-dark mt-1">{log.time}</p>
                    </div>
                </div>
            ))}
        </div>
      </div>
    </motion.div>
  );
}

