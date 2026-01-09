"use client";

import React, { useState } from "react";
import { motion, AnimatePresence } from "motion/react";
import {
  useDocumentsForReview,
  useReviewDocument,
} from "@/features/recruitment/hooks/use-document-review";
import { PortalDocument, CandidateVerificationInfo } from "@/features/recruitment/types";

interface DocumentReviewModalProps {
  isOpen: boolean;
  onClose: () => void;
  applicationId: number;
  candidateName: string;
}

export default function DocumentReviewModal({
  isOpen,
  onClose,
  applicationId,
  candidateName,
}: DocumentReviewModalProps) {
  const { data, isLoading, error } = useDocumentsForReview(applicationId);
  const reviewMutation = useReviewDocument();

  const [selectedDoc, setSelectedDoc] = useState<PortalDocument | null>(null);
  const [reviewNotes, setReviewNotes] = useState("");
  const [activeTab, setActiveTab] = useState<"documents" | "candidate">("documents");

  if (!isOpen) return null;

  const handleReview = async (docId: number, status: "approved" | "rejected") => {
    await reviewMutation.mutateAsync({
      appId: applicationId,
      docId,
      review: {
        status,
        reviewer_notes: reviewNotes || undefined,
      },
    });
    setReviewNotes("");
    setSelectedDoc(null);
  };

  const getStatusBadge = (status: string) => {
    switch (status) {
      case "approved":
        return (
          <span className="inline-flex items-center gap-1 px-2 py-1 rounded-full text-xs font-medium bg-emerald-500/10 text-emerald-400">
            <span className="material-symbols-outlined text-sm">check_circle</span>
            Approved
          </span>
        );
      case "rejected":
        return (
          <span className="inline-flex items-center gap-1 px-2 py-1 rounded-full text-xs font-medium bg-red-500/10 text-red-400">
            <span className="material-symbols-outlined text-sm">cancel</span>
            Rejected
          </span>
        );
      default:
        return (
          <span className="inline-flex items-center gap-1 px-2 py-1 rounded-full text-xs font-medium bg-yellow-500/10 text-yellow-400">
            <span className="material-symbols-outlined text-sm">pending</span>
            Pending
          </span>
        );
    }
  };

  const getDocumentTypeLabel = (type: string) => {
    const labels: Record<string, string> = {
      id_card: "Government ID",
      diploma: "Educational Diploma",
      certificate: "Professional Certificate",
      reference: "Professional References",
    };
    return labels[type] || type.replace(/_/g, " ").replace(/\b\w/g, (l) => l.toUpperCase());
  };

  return (
    <AnimatePresence>
      <motion.div
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        exit={{ opacity: 0 }}
        className="fixed inset-0 bg-black/60 backdrop-blur-sm z-50 flex items-center justify-center p-4"
        onClick={onClose}
      >
        <motion.div
          initial={{ opacity: 0, scale: 0.95, y: 20 }}
          animate={{ opacity: 1, scale: 1, y: 0 }}
          exit={{ opacity: 0, scale: 0.95, y: 20 }}
          className="bg-[#0f1729] border border-white/10 rounded-2xl w-full max-w-7xl max-h-[95vh] overflow-hidden flex flex-col"
          onClick={(e) => e.stopPropagation()}
        >
          {/* Header */}
          <div className="flex items-center justify-between px-6 py-4 border-b border-white/10">
            <div>
              <h2 className="text-xl font-bold text-white">Document Review</h2>
              <p className="text-sm text-gray-400 mt-1">
                Review documents for {candidateName}
              </p>
            </div>
            <button
              onClick={onClose}
              className="p-2 rounded-lg hover:bg-white/5 transition-colors"
            >
              <span className="material-symbols-outlined text-gray-400">close</span>
            </button>
          </div>

          {/* Tabs */}
          <div className="flex border-b border-white/10">
            <button
              onClick={() => setActiveTab("documents")}
              className={`px-6 py-3 text-sm font-medium transition-colors ${
                activeTab === "documents"
                  ? "text-emerald-400 border-b-2 border-emerald-400"
                  : "text-gray-400 hover:text-white"
              }`}
            >
              <span className="material-symbols-outlined text-sm mr-2 align-middle">folder</span>
              Documents ({data?.documents.length || 0})
            </button>
            <button
              onClick={() => setActiveTab("candidate")}
              className={`px-6 py-3 text-sm font-medium transition-colors ${
                activeTab === "candidate"
                  ? "text-emerald-400 border-b-2 border-emerald-400"
                  : "text-gray-400 hover:text-white"
              }`}
            >
              <span className="material-symbols-outlined text-sm mr-2 align-middle">person</span>
              Candidate Info
            </button>
          </div>

          {/* Content */}
          <div className="flex-1 overflow-auto p-6">
            {isLoading ? (
              <div className="flex items-center justify-center py-12">
                <div className="w-10 h-10 border-4 border-emerald-500/30 border-t-emerald-500 rounded-full animate-spin" />
              </div>
            ) : error ? (
              <div className="text-center py-12">
                <span className="material-symbols-outlined text-4xl text-red-400 mb-2">error</span>
                <p className="text-red-400">Failed to load documents</p>
              </div>
            ) : activeTab === "documents" ? (
              <DocumentsTab
                documents={data?.documents || []}
                selectedDoc={selectedDoc}
                setSelectedDoc={setSelectedDoc}
                reviewNotes={reviewNotes}
                setReviewNotes={setReviewNotes}
                handleReview={handleReview}
                isReviewing={reviewMutation.isPending}
                getStatusBadge={getStatusBadge}
                getDocumentTypeLabel={getDocumentTypeLabel}
              />
            ) : (
              <CandidateInfoTab candidateInfo={data?.candidate_info || null} />
            )}
          </div>

          {/* Footer */}
          <div className="px-6 py-4 border-t border-white/10 flex items-center justify-between bg-white/5">
            <div className="text-sm text-gray-400">
              {data?.all_required_approved ? (
                <span className="text-emerald-400 flex items-center gap-2">
                  <span className="material-symbols-outlined text-sm">check_circle</span>
                  All required documents approved
                </span>
              ) : (
                <span className="text-yellow-400 flex items-center gap-2">
                  <span className="material-symbols-outlined text-sm">info</span>
                  Some documents still require review
                </span>
              )}
            </div>
            <button
              onClick={onClose}
              className="px-4 py-2 bg-white/10 hover:bg-white/20 rounded-lg text-white text-sm font-medium transition-colors"
            >
              Close
            </button>
          </div>
        </motion.div>
      </motion.div>
    </AnimatePresence>
  );
}

// Documents Tab Component
function DocumentsTab({
  documents,
  selectedDoc,
  setSelectedDoc,
  reviewNotes,
  setReviewNotes,
  handleReview,
  isReviewing,
  getStatusBadge,
  getDocumentTypeLabel,
}: {
  documents: PortalDocument[];
  selectedDoc: PortalDocument | null;
  setSelectedDoc: (doc: PortalDocument | null) => void;
  reviewNotes: string;
  setReviewNotes: (notes: string) => void;
  handleReview: (docId: number, status: "approved" | "rejected") => void;
  isReviewing: boolean;
  getStatusBadge: (status: string) => React.ReactNode;
  getDocumentTypeLabel: (type: string) => string;
}) {
  if (documents.length === 0) {
    return (
      <div className="text-center py-12">
        <span className="material-symbols-outlined text-4xl text-gray-500 mb-2">folder_off</span>
        <p className="text-gray-400">No documents uploaded yet</p>
      </div>
    );
  }

  return (
    <div className="grid grid-cols-1 lg:grid-cols-5 gap-6 h-full">
      {/* Document List */}
      <div className="lg:col-span-2 space-y-4 overflow-auto max-h-[65vh]">
        <h3 className="text-sm font-medium text-gray-400 uppercase tracking-wide">
          Uploaded Documents
        </h3>
        {documents.map((doc) => (
          <motion.div
            key={doc.id}
            whileHover={{ scale: 1.01 }}
            className={`p-4 rounded-xl border cursor-pointer transition-all ${
              selectedDoc?.id === doc.id
                ? "bg-emerald-500/10 border-emerald-500/50"
                : "bg-white/5 border-white/10 hover:border-white/20"
            }`}
            onClick={() => setSelectedDoc(doc)}
          >
            <div className="flex items-start justify-between gap-4">
              <div className="flex items-start gap-3">
                <div className="w-10 h-10 rounded-lg bg-white/10 flex items-center justify-center">
                  <span className="material-symbols-outlined text-gray-400">description</span>
                </div>
                <div>
                  <p className="font-medium text-white">
                    {getDocumentTypeLabel(doc.document_type)}
                  </p>
                  <p className="text-sm text-gray-400 mt-0.5">{doc.file_name}</p>
                  <p className="text-xs text-gray-500 mt-1">
                    Uploaded {new Date(doc.uploaded_at).toLocaleDateString()}
                  </p>
                </div>
              </div>
              {getStatusBadge(doc.status)}
            </div>
          </motion.div>
        ))}
      </div>

      {/* Document Preview & Review */}
      <div className="lg:col-span-3 bg-white/5 rounded-xl border border-white/10 overflow-hidden flex flex-col">
        {selectedDoc ? (
          <div className="flex flex-col h-full">
            {/* Preview Header */}
            <div className="p-4 border-b border-white/10">
              <h3 className="font-medium text-white">
                {getDocumentTypeLabel(selectedDoc.document_type)}
              </h3>
              <p className="text-sm text-gray-400">{selectedDoc.file_name}</p>
            </div>

            {/* Document Preview */}
            <div className="flex-1 min-h-[500px] bg-black/30 flex items-center justify-center">
              {selectedDoc.mime_type?.includes("pdf") ? (
                <iframe
                  src={`http://localhost:6060${selectedDoc.file_url}`}
                  className="w-full h-full min-h-[500px]"
                  title="Document Preview"
                />
              ) : selectedDoc.mime_type?.includes("image") ? (
                <img
                  src={`http://localhost:6060${selectedDoc.file_url}`}
                  alt="Document"
                  className="max-w-full max-h-[600px] object-contain"
                />
              ) : (
                <div className="text-center p-8">
                  <span className="material-symbols-outlined text-4xl text-gray-500 mb-2">
                    preview_off
                  </span>
                  <p className="text-gray-400">Preview not available</p>
                  <a
                    href={`http://localhost:6060${selectedDoc.file_url}`}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="mt-4 inline-flex items-center gap-2 px-4 py-2 bg-emerald-500/10 text-emerald-400 rounded-lg text-sm hover:bg-emerald-500/20 transition-colors"
                  >
                    <span className="material-symbols-outlined text-sm">open_in_new</span>
                    Open Document
                  </a>
                </div>
              )}
            </div>

            {/* Review Actions */}
            {selectedDoc.status === "pending" && (
              <div className="p-4 border-t border-white/10 space-y-4">
                <textarea
                  value={reviewNotes}
                  onChange={(e) => setReviewNotes(e.target.value)}
                  placeholder="Add review notes (optional)..."
                  className="w-full px-3 py-2 bg-white/5 border border-white/10 rounded-lg text-white placeholder-gray-500 text-sm resize-none focus:outline-none focus:border-emerald-500/50"
                  rows={2}
                />
                <div className="flex gap-3">
                  <button
                    onClick={() => handleReview(selectedDoc.id, "approved")}
                    disabled={isReviewing}
                    className="flex-1 px-4 py-2 bg-emerald-500 hover:bg-emerald-600 disabled:opacity-50 rounded-lg text-white text-sm font-medium transition-colors flex items-center justify-center gap-2"
                  >
                    {isReviewing ? (
                      <div className="w-4 h-4 border-2 border-white/30 border-t-white rounded-full animate-spin" />
                    ) : (
                      <span className="material-symbols-outlined text-sm">check</span>
                    )}
                    Approve
                  </button>
                  <button
                    onClick={() => handleReview(selectedDoc.id, "rejected")}
                    disabled={isReviewing}
                    className="flex-1 px-4 py-2 bg-red-500 hover:bg-red-600 disabled:opacity-50 rounded-lg text-white text-sm font-medium transition-colors flex items-center justify-center gap-2"
                  >
                    {isReviewing ? (
                      <div className="w-4 h-4 border-2 border-white/30 border-t-white rounded-full animate-spin" />
                    ) : (
                      <span className="material-symbols-outlined text-sm">close</span>
                    )}
                    Reject
                  </button>
                </div>
              </div>
            )}

            {/* Already Reviewed */}
            {selectedDoc.status !== "pending" && (
              <div className="p-4 border-t border-white/10">
                <div
                  className={`p-3 rounded-lg ${
                    selectedDoc.status === "approved"
                      ? "bg-emerald-500/10 border border-emerald-500/20"
                      : "bg-red-500/10 border border-red-500/20"
                  }`}
                >
                  <p
                    className={`text-sm font-medium ${
                      selectedDoc.status === "approved" ? "text-emerald-400" : "text-red-400"
                    }`}
                  >
                    Document {selectedDoc.status === "approved" ? "Approved" : "Rejected"}
                    {selectedDoc.reviewed_at &&
                      ` on ${new Date(selectedDoc.reviewed_at).toLocaleDateString()}`}
                  </p>
                  {selectedDoc.reviewer_notes && (
                    <p className="text-sm text-gray-400 mt-1">{selectedDoc.reviewer_notes}</p>
                  )}
                </div>
              </div>
            )}
          </div>
        ) : (
          <div className="flex items-center justify-center h-full min-h-[500px] text-center">
            <div>
              <span className="material-symbols-outlined text-5xl text-gray-500 mb-3">
                touch_app
              </span>
              <p className="text-gray-400 text-lg">Select a document to preview and review</p>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}

// Candidate Info Tab Component
function CandidateInfoTab({
  candidateInfo,
}: {
  candidateInfo: CandidateVerificationInfo | null;
}) {
  if (!candidateInfo) {
    return (
      <div className="text-center py-12">
        <span className="material-symbols-outlined text-4xl text-gray-500 mb-2">person_off</span>
        <p className="text-gray-400">No candidate information available</p>
      </div>
    );
  }

  return (
    <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
      {/* Basic Info */}
      <div className="bg-white/5 rounded-xl border border-white/10 p-5">
        <h3 className="text-sm font-medium text-gray-400 uppercase tracking-wide mb-4 flex items-center gap-2">
          <span className="material-symbols-outlined text-sm">person</span>
          Basic Information
        </h3>
        <div className="space-y-3">
          <InfoRow label="Full Name" value={candidateInfo.full_name} />
          <InfoRow label="Email" value={candidateInfo.email} />
          <InfoRow label="Phone" value={candidateInfo.phone} />
          <InfoRow label="Current Position" value={candidateInfo.current_position} />
          <InfoRow label="Current Company" value={candidateInfo.current_company} />
          <InfoRow
            label="Total Experience"
            value={
              candidateInfo.total_experience_years
                ? `${candidateInfo.total_experience_years} years`
                : null
            }
          />
        </div>
      </div>

      {/* Education */}
      <div className="bg-white/5 rounded-xl border border-white/10 p-5">
        <h3 className="text-sm font-medium text-gray-400 uppercase tracking-wide mb-4 flex items-center gap-2">
          <span className="material-symbols-outlined text-sm">school</span>
          Education
        </h3>
        {candidateInfo.education.length > 0 ? (
          <div className="space-y-4">
            {candidateInfo.education.map((edu, idx) => (
              <div key={idx} className="border-l-2 border-emerald-500/50 pl-3">
                <p className="font-medium text-white">
                  {edu.degree || "Degree"} in {edu.field_of_study || "Field"}
                </p>
                <p className="text-sm text-gray-400">{edu.institution}</p>
                {(edu.start_date || edu.end_date) && (
                  <p className="text-xs text-gray-500 mt-1">
                    {edu.start_date} - {edu.end_date || "Present"}
                  </p>
                )}
              </div>
            ))}
          </div>
        ) : candidateInfo.highest_degree ? (
          <div className="border-l-2 border-emerald-500/50 pl-3">
            <p className="font-medium text-white">{candidateInfo.highest_degree}</p>
            {candidateInfo.field_of_study && (
              <p className="text-sm text-gray-400">{candidateInfo.field_of_study}</p>
            )}
            {candidateInfo.institution && (
              <p className="text-sm text-gray-400">{candidateInfo.institution}</p>
            )}
          </div>
        ) : (
          <p className="text-gray-500 text-sm">No education data available</p>
        )}
      </div>

      {/* Work Experience */}
      <div className="bg-white/5 rounded-xl border border-white/10 p-5">
        <h3 className="text-sm font-medium text-gray-400 uppercase tracking-wide mb-4 flex items-center gap-2">
          <span className="material-symbols-outlined text-sm">work</span>
          Work Experience
        </h3>
        {candidateInfo.work_experience.length > 0 ? (
          <div className="space-y-4">
            {candidateInfo.work_experience.map((work, idx) => (
              <div key={idx} className="border-l-2 border-blue-500/50 pl-3">
                <p className="font-medium text-white">{work.job_title}</p>
                <p className="text-sm text-gray-400">{work.company}</p>
                <p className="text-xs text-gray-500 mt-1">
                  {work.start_date} - {work.is_current ? "Present" : work.end_date || "N/A"}
                </p>
              </div>
            ))}
          </div>
        ) : (
          <p className="text-gray-500 text-sm">No work experience data available</p>
        )}
      </div>

      {/* Skills */}
      <div className="bg-white/5 rounded-xl border border-white/10 p-5">
        <h3 className="text-sm font-medium text-gray-400 uppercase tracking-wide mb-4 flex items-center gap-2">
          <span className="material-symbols-outlined text-sm">psychology</span>
          Skills
        </h3>
        {candidateInfo.skills.length > 0 ? (
          <div className="flex flex-wrap gap-2">
            {candidateInfo.skills.map((skill, idx) => (
              <span
                key={idx}
                className="px-3 py-1 bg-white/10 rounded-full text-sm text-white"
              >
                {skill}
              </span>
            ))}
          </div>
        ) : (
          <p className="text-gray-500 text-sm">No skills data available</p>
        )}
      </div>

      {/* Certifications */}
      {candidateInfo.certifications.length > 0 && (
        <div className="bg-white/5 rounded-xl border border-white/10 p-5 md:col-span-2">
          <h3 className="text-sm font-medium text-gray-400 uppercase tracking-wide mb-4 flex items-center gap-2">
            <span className="material-symbols-outlined text-sm">verified</span>
            Certifications
          </h3>
          <div className="flex flex-wrap gap-2">
            {candidateInfo.certifications.map((cert, idx) => (
              <span
                key={idx}
                className="px-3 py-1 bg-emerald-500/10 text-emerald-400 rounded-full text-sm"
              >
                {cert}
              </span>
            ))}
          </div>
        </div>
      )}
    </div>
  );
}

function InfoRow({ label, value }: { label: string; value: string | null | undefined }) {
  return (
    <div className="flex justify-between items-center py-2 border-b border-white/5 last:border-0">
      <span className="text-sm text-gray-400">{label}</span>
      <span className="text-sm text-white font-medium">{value || "-"}</span>
    </div>
  );
}

