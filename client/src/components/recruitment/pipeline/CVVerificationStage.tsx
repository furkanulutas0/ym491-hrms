"use client";

import React, { useState } from "react";
import { motion } from "motion/react";
import { JobApplication, DocumentRequirement } from "@/features/recruitment/types";
import { useAdvanceApplication } from "@/features/recruitment/hooks/use-pipeline";
import { useDocumentsForReview } from "@/features/recruitment/hooks/use-document-review";
import StageCard from "./StageCard";
import StageActions from "./StageActions";
import ProgressIndicator from "./ProgressIndicator";
import DocumentReviewModal from "./DocumentReviewModal";

interface CVVerificationStageProps {
  applications: JobApplication[];
  isLoading: boolean;
  jobId: number;
}

export default function CVVerificationStage({ applications, isLoading, jobId }: CVVerificationStageProps) {
  const advanceMutation = useAdvanceApplication();
  const [reviewingAppId, setReviewingAppId] = useState<number | null>(null);
  const [reviewingAppName, setReviewingAppName] = useState<string>("");

  const handleAdvance = (appId: number) => {
    advanceMutation.mutate({
      appId,
      stageUpdate: { stage: "proposal", notes: "All documents verified and approved" }
    });
  };

  const openReviewModal = (appId: number, candidateName: string) => {
    setReviewingAppId(appId);
    setReviewingAppName(candidateName);
  };

  const closeReviewModal = () => {
    setReviewingAppId(null);
    setReviewingAppName("");
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
          verified
        </span>
        <div>
          <p className="text-lg font-bold text-text-primary-light dark:text-text-primary-dark">
            No applications in verification stage
          </p>
          <p className="text-sm text-text-secondary-light dark:text-text-secondary-dark">
            Applications will appear here after completing the interview
          </p>
        </div>
      </motion.div>
    );
  }

  // Sample document checklist
  const defaultDocuments: DocumentRequirement[] = [
    { document_type: "id_card", title: "Government-issued ID", description: "Passport, Driver's License, or National ID", required: true, submitted: false },
    { document_type: "diploma", title: "Educational Diploma", description: "Degree certificate or diploma", required: true, submitted: false },
    { document_type: "certificate", title: "Professional Certificates", description: "Relevant certifications", required: false, submitted: false },
    { document_type: "reference", title: "Professional References", description: "2-3 professional references", required: true, submitted: false },
  ];

  return (
    <>
      <motion.div
        initial={{ opacity: 0, y: 10 }}
        animate={{ opacity: 1, y: 0 }}
        className="flex flex-col gap-4"
      >
        {applications.map((app) => (
          <ApplicationVerificationCard
            key={app.id}
            application={app}
            defaultDocuments={defaultDocuments}
            onAdvance={handleAdvance}
            onOpenReview={openReviewModal}
            isAdvancing={advanceMutation.isPending}
          />
        ))}
      </motion.div>

      {/* Document Review Modal */}
      {reviewingAppId && (
        <DocumentReviewModal
          isOpen={!!reviewingAppId}
          onClose={closeReviewModal}
          applicationId={reviewingAppId}
          candidateName={reviewingAppName}
        />
      )}
    </>
  );
}

// Separate component to handle document status fetching per application
function ApplicationVerificationCard({
  application,
  defaultDocuments,
  onAdvance,
  onOpenReview,
  isAdvancing,
}: {
  application: JobApplication;
  defaultDocuments: DocumentRequirement[];
  onAdvance: (appId: number) => void;
  onOpenReview: (appId: number, candidateName: string) => void;
  isAdvancing: boolean;
}) {
  const { data: reviewData, isLoading: isLoadingReview } = useDocumentsForReview(application.id);
  
  const documents = application.documents_required || defaultDocuments;
  const submittedDocuments = application.documents_submitted || [];
  const totalRequired = documents.filter(d => d.required).length;
  
  // Calculate uploaded and approved counts from review data
  const uploadedDocs = reviewData?.documents || [];
  const approvedDocs = uploadedDocs.filter(d => d.status === 'approved');
  const pendingDocs = uploadedDocs.filter(d => d.status === 'pending');
  const rejectedDocs = uploadedDocs.filter(d => d.status === 'rejected');
  
  // Check if all required documents are approved
  const requiredDocTypes = documents.filter(d => d.required).map(d => d.document_type);
  const allRequiredApproved = requiredDocTypes.every(docType => 
    uploadedDocs.some(d => d.document_type === docType && d.status === 'approved')
  );
  
  const hasUploadedDocuments = uploadedDocs.length > 0;
  const hasPendingDocuments = pendingDocs.length > 0;

  const getDocumentStatus = (docType: string) => {
    const doc = uploadedDocs.find(d => d.document_type === docType);
    if (!doc) return 'not_uploaded';
    return doc.status;
  };

  const getStatusIcon = (status: string) => {
    switch (status) {
      case 'approved':
        return <span className="material-symbols-outlined text-sm text-emerald-400">check_circle</span>;
      case 'rejected':
        return <span className="material-symbols-outlined text-sm text-red-400">cancel</span>;
      case 'pending':
        return <span className="material-symbols-outlined text-sm text-yellow-400">pending</span>;
      default:
        return <span className="material-symbols-outlined text-sm text-gray-400">radio_button_unchecked</span>;
    }
  };

  const getStatusLabel = (status: string) => {
    switch (status) {
      case 'approved':
        return 'Approved';
      case 'rejected':
        return 'Rejected';
      case 'pending':
        return 'Pending Review';
      default:
        return 'Not Uploaded';
    }
  };

  const getStatusBgClass = (status: string) => {
    switch (status) {
      case 'approved':
        return 'bg-emerald-500/10 border-emerald-500/30';
      case 'rejected':
        return 'bg-red-500/10 border-red-500/30';
      case 'pending':
        return 'bg-yellow-500/10 border-yellow-500/30';
      default:
        return 'bg-gray-500/10 border-gray-500/30';
    }
  };

  return (
    <StageCard application={application}>
      <div className="flex flex-col gap-4">
        <ProgressIndicator currentStage={application.pipeline_stage} />
        
        {/* Document Verification Checklist */}
        <div className="bg-background-light dark:bg-background-dark rounded-lg p-4">
          <div className="flex items-center justify-between mb-4">
            <div>
              <p className="text-sm font-bold text-text-primary-light dark:text-text-primary-dark">
                Document Verification
              </p>
              {isLoadingReview ? (
                <p className="text-xs text-text-secondary-light dark:text-text-secondary-dark mt-1">
                  Loading status...
                </p>
              ) : (
                <p className="text-xs text-text-secondary-light dark:text-text-secondary-dark mt-1">
                  {approvedDocs.length} approved, {pendingDocs.length} pending, {rejectedDocs.length} rejected
                </p>
              )}
            </div>
            
            {/* Review Documents Button */}
            {hasUploadedDocuments && (
              <button
                onClick={() => onOpenReview(application.id, application.candidate_name)}
                className="flex items-center gap-2 px-3 py-1.5 bg-primary/10 hover:bg-primary/20 text-primary rounded-lg text-sm font-medium transition-colors"
              >
                <span className="material-symbols-outlined text-sm">rate_review</span>
                Review Documents
                {hasPendingDocuments && (
                  <span className="w-5 h-5 bg-yellow-500 text-white text-xs rounded-full flex items-center justify-center">
                    {pendingDocs.length}
                  </span>
                )}
              </button>
            )}
          </div>
          
          <div className="space-y-3">
            {documents.map((doc, idx) => {
              const status = getDocumentStatus(doc.document_type);
              const uploadedDoc = uploadedDocs.find(d => d.document_type === doc.document_type);

              return (
                <div 
                  key={idx} 
                  className={`flex items-start gap-3 p-3 rounded-lg border ${getStatusBgClass(status)}`}
                >
                  <div className="flex-shrink-0 w-6 h-6 rounded-full flex items-center justify-center">
                    {getStatusIcon(status)}
                  </div>
                  <div className="flex-1">
                    <div className="flex items-center gap-2">
                      <p className="text-sm font-bold text-text-primary-light dark:text-text-primary-dark">
                        {doc.title}
                      </p>
                      {doc.required && (
                        <span className="text-xs px-2 py-0.5 bg-red-100 dark:bg-red-900 text-red-800 dark:text-red-200 rounded">
                          Required
                        </span>
                      )}
                      <span className={`text-xs ml-auto ${
                        status === 'approved' ? 'text-emerald-400' :
                        status === 'rejected' ? 'text-red-400' :
                        status === 'pending' ? 'text-yellow-400' : 'text-gray-400'
                      }`}>
                        {getStatusLabel(status)}
                      </span>
                    </div>
                    {doc.description && (
                      <p className="text-xs text-text-secondary-light dark:text-text-secondary-dark mt-1">
                        {doc.description}
                      </p>
                    )}
                    {uploadedDoc && (
                      <div className="flex items-center gap-3 mt-2">
                        <a
                          href={`http://localhost:6060${uploadedDoc.file_url}`}
                          target="_blank"
                          rel="noopener noreferrer"
                          className="text-xs text-primary hover:underline inline-flex items-center gap-1"
                        >
                          <span className="material-symbols-outlined text-xs">open_in_new</span>
                          View Document
                        </a>
                        <span className="text-xs text-text-secondary-light dark:text-text-secondary-dark">
                          {uploadedDoc.file_name}
                        </span>
                      </div>
                    )}
                    {uploadedDoc?.reviewer_notes && (
                      <p className="text-xs text-text-secondary-light dark:text-text-secondary-dark mt-1 italic">
                        Note: {uploadedDoc.reviewer_notes}
                      </p>
                    )}
                  </div>
                </div>
              );
            })}
          </div>

          {/* Status Messages */}
          {!hasUploadedDocuments && (
            <div className="mt-4 p-3 bg-yellow-100 dark:bg-yellow-900/20 border border-yellow-500 rounded-lg">
              <p className="text-xs text-yellow-800 dark:text-yellow-400 flex items-center gap-2">
                <span className="material-symbols-outlined text-sm">hourglass_empty</span>
                Waiting for candidate to upload required documents
              </p>
            </div>
          )}

          {hasPendingDocuments && (
            <div className="mt-4 p-3 bg-blue-100 dark:bg-blue-900/20 border border-blue-500 rounded-lg">
              <p className="text-xs text-blue-800 dark:text-blue-400 flex items-center gap-2">
                <span className="material-symbols-outlined text-sm">info</span>
                {pendingDocs.length} document(s) pending your review
              </p>
            </div>
          )}

          {rejectedDocs.length > 0 && (
            <div className="mt-4 p-3 bg-red-100 dark:bg-red-900/20 border border-red-500 rounded-lg">
              <p className="text-xs text-red-800 dark:text-red-400 flex items-center gap-2">
                <span className="material-symbols-outlined text-sm">warning</span>
                {rejectedDocs.length} document(s) were rejected. Candidate needs to re-upload.
              </p>
            </div>
          )}

          {allRequiredApproved && (
            <div className="mt-4 p-3 bg-emerald-100 dark:bg-emerald-900/20 border border-emerald-500 rounded-lg">
              <p className="text-xs text-emerald-800 dark:text-emerald-400 flex items-center gap-2">
                <span className="material-symbols-outlined text-sm">check_circle</span>
                All required documents have been approved. Ready to send proposal.
              </p>
            </div>
          )}
        </div>

        {/* Actions */}
        <div className="flex justify-end gap-3">
          {hasUploadedDocuments && (
            <button
              onClick={() => onOpenReview(application.id, application.candidate_name)}
              className="px-4 py-2 bg-white/10 hover:bg-white/20 rounded-lg text-white text-sm font-medium transition-colors flex items-center gap-2"
            >
              <span className="material-symbols-outlined text-sm">visibility</span>
              View & Review
            </button>
          )}
          
          <StageActions
            onAdvance={() => onAdvance(application.id)}
            advanceLabel="Send Proposal"
            isLoading={isAdvancing}
            disabled={!allRequiredApproved}
            disabledReason={!allRequiredApproved ? "All required documents must be approved first" : undefined}
          />
        </div>
      </div>
    </StageCard>
  );
}
