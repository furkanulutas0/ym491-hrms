"use client";

import { useState, useCallback } from "react";
import { useParams } from "next/navigation";
import { motion, AnimatePresence } from "motion/react";
import Link from "next/link";
import { useDropzone } from "react-dropzone";
import {
  useDocumentRequirements,
  useUploadDocument,
} from "@/features/candidate/hooks/use-candidate-applications";

export default function DocumentsPage() {
  const params = useParams();
  const appId = Number(params.id);
  const { data: requirements, isLoading } = useDocumentRequirements(appId);
  const uploadMutation = useUploadDocument();

  const [selectedDocType, setSelectedDocType] = useState<string | null>(null);
  const [uploadProgress, setUploadProgress] = useState<Record<string, number>>({});

  const onDrop = useCallback(
    async (acceptedFiles: File[], docType: string) => {
      if (acceptedFiles.length === 0) return;

      const file = acceptedFiles[0];
      setUploadProgress((prev) => ({ ...prev, [docType]: 0 }));

      try {
        // Simulate progress
        const progressInterval = setInterval(() => {
          setUploadProgress((prev) => {
            const current = prev[docType] || 0;
            if (current >= 90) {
              clearInterval(progressInterval);
              return prev;
            }
            return { ...prev, [docType]: current + 10 };
          });
        }, 200);

        await uploadMutation.mutateAsync({
          file,
          documentType: docType,
          applicationId: appId,
        });

        clearInterval(progressInterval);
        setUploadProgress((prev) => ({ ...prev, [docType]: 100 }));

        // Clear progress after animation
        setTimeout(() => {
          setUploadProgress((prev) => {
            const { [docType]: _, ...rest } = prev;
            return rest;
          });
        }, 1000);
      } catch (error) {
        setUploadProgress((prev) => {
          const { [docType]: _, ...rest } = prev;
          return rest;
        });
      }
    },
    [appId, uploadMutation]
  );

  const DocumentDropzone = ({
    docType,
    title,
    description,
    required,
    submitted,
    status,
  }: {
    docType: string;
    title: string;
    description?: string | null;
    required: boolean;
    submitted: boolean;
    status: string | null;
  }) => {
    const { getRootProps, getInputProps, isDragActive } = useDropzone({
      onDrop: (files) => onDrop(files, docType),
      accept: {
        "application/pdf": [".pdf"],
        "image/jpeg": [".jpg", ".jpeg"],
        "image/png": [".png"],
        "application/msword": [".doc"],
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document":
          [".docx"],
      },
      maxSize: 10 * 1024 * 1024, // 10MB
      multiple: false,
    });

    const progress = uploadProgress[docType];
    const isUploading = progress !== undefined && progress < 100;

    return (
      <motion.div
        initial={{ opacity: 0, y: 10 }}
        animate={{ opacity: 1, y: 0 }}
        className="bg-[#111827] border border-white/10 rounded-xl overflow-hidden"
      >
        <div className="p-5 border-b border-white/10">
          <div className="flex items-start justify-between gap-4">
            <div className="flex items-start gap-3">
              <div
                className={`w-10 h-10 rounded-lg flex items-center justify-center ${
                  submitted
                    ? status === "approved"
                      ? "bg-emerald-500/10"
                      : status === "rejected"
                      ? "bg-red-500/10"
                      : "bg-yellow-500/10"
                    : "bg-white/5"
                }`}
              >
                <span
                  className={`material-symbols-outlined ${
                    submitted
                      ? status === "approved"
                        ? "text-emerald-400"
                        : status === "rejected"
                        ? "text-red-400"
                        : "text-yellow-400"
                      : "text-gray-400"
                  }`}
                >
                  {submitted
                    ? status === "approved"
                      ? "check_circle"
                      : status === "rejected"
                      ? "cancel"
                      : "pending"
                    : "description"}
                </span>
              </div>
              <div>
                <h3 className="font-bold text-white flex items-center gap-2">
                  {title}
                  {required && (
                    <span className="text-xs px-2 py-0.5 rounded bg-red-500/10 text-red-400">
                      Required
                    </span>
                  )}
                </h3>
                {description && (
                  <p className="text-sm text-gray-400 mt-1">{description}</p>
                )}
              </div>
            </div>

            {submitted && (
              <span
                className={`text-xs font-medium px-3 py-1 rounded-full ${
                  status === "approved"
                    ? "bg-emerald-500/10 text-emerald-400"
                    : status === "rejected"
                    ? "bg-red-500/10 text-red-400"
                    : "bg-yellow-500/10 text-yellow-400"
                }`}
              >
                {status === "approved"
                  ? "Approved"
                  : status === "rejected"
                  ? "Rejected"
                  : "Pending Review"}
              </span>
            )}
          </div>
        </div>

        {/* Drop Zone */}
        <div
          {...getRootProps()}
          className={`p-6 cursor-pointer transition-colors ${
            isDragActive
              ? "bg-emerald-500/10 border-emerald-500"
              : "hover:bg-white/5"
          }`}
        >
          <input {...getInputProps()} />

          {isUploading ? (
            <div className="text-center py-4">
              <div className="w-12 h-12 mx-auto mb-4 relative">
                <div className="absolute inset-0 rounded-full border-4 border-white/10" />
                <div
                  className="absolute inset-0 rounded-full border-4 border-emerald-500 border-t-transparent animate-spin"
                  style={{
                    clipPath: `inset(0 ${100 - progress}% 0 0)`,
                  }}
                />
                <span className="absolute inset-0 flex items-center justify-center text-sm font-bold text-emerald-400">
                  {progress}%
                </span>
              </div>
              <p className="text-gray-400">Uploading...</p>
            </div>
          ) : progress === 100 ? (
            <div className="text-center py-4">
              <div className="w-12 h-12 mx-auto mb-4 rounded-full bg-emerald-500/20 flex items-center justify-center">
                <span className="material-symbols-outlined text-2xl text-emerald-400">
                  check
                </span>
              </div>
              <p className="text-emerald-400 font-medium">Upload Complete!</p>
            </div>
          ) : (
            <div className="text-center py-4">
              <div
                className={`w-12 h-12 mx-auto mb-4 rounded-full flex items-center justify-center ${
                  isDragActive ? "bg-emerald-500/20" : "bg-white/5"
                }`}
              >
                <span
                  className={`material-symbols-outlined text-2xl ${
                    isDragActive ? "text-emerald-400" : "text-gray-400"
                  }`}
                >
                  cloud_upload
                </span>
              </div>
              <p className="text-white font-medium mb-1">
                {isDragActive
                  ? "Drop file here"
                  : submitted
                  ? "Upload new version"
                  : "Drag & drop file here"}
              </p>
              <p className="text-sm text-gray-400">
                or <span className="text-emerald-400">browse</span> to choose
              </p>
              <p className="text-xs text-gray-500 mt-2">
                PDF, JPG, PNG, DOC up to 10MB
              </p>
            </div>
          )}
        </div>

        {/* Uploaded File Info */}
        {submitted && requirements && (
          <div className="p-4 bg-white/5 border-t border-white/10">
            {(() => {
              const doc = requirements.find(
                (r) => r.document_type === docType
              )?.document;
              if (!doc) return null;
              return (
                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-3">
                    <span className="material-symbols-outlined text-gray-400">
                      attach_file
                    </span>
                    <div>
                      <p className="text-sm text-white">{doc.file_name}</p>
                      <p className="text-xs text-gray-500">
                        Uploaded{" "}
                        {new Date(doc.uploaded_at).toLocaleDateString()}
                      </p>
                    </div>
                  </div>
                  <a
                    href={ "http://localhost"+doc.file_url}
                    target="_blank"
                    rel="noopener noreferrer"
                    onClick={(e) => e.stopPropagation()}
                    className="text-emerald-400 hover:text-emerald-300 text-sm flex items-center gap-1"
                  >
                    <span className="material-symbols-outlined text-sm">
                      open_in_new
                    </span>
                    View
                  </a>
                </div>
              );
            })()}
          </div>
        )}
      </motion.div>
    );
  };

  if (isLoading) {
    return (
      <div className="flex items-center justify-center min-h-[400px]">
        <div className="w-10 h-10 border-4 border-emerald-500/30 border-t-emerald-500 rounded-full animate-spin" />
      </div>
    );
  }

  const requiredDocs = requirements?.filter((r) => r.required) || [];
  const optionalDocs = requirements?.filter((r) => !r.required) || [];
  const completedRequired = requiredDocs.filter((r) => r.submitted).length;
  const allRequiredComplete = completedRequired === requiredDocs.length;

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
        <h1 className="text-2xl font-bold text-white mb-2">
          Document Verification
        </h1>
        <p className="text-gray-400">
          Upload the required documents to complete your verification
        </p>
      </motion.div>

      {/* Progress */}
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ delay: 0.1 }}
        className="bg-[#111827] border border-white/10 rounded-xl p-6"
      >
        <div className="flex items-center justify-between mb-4">
          <h2 className="font-bold text-white">Progress</h2>
          <span className="text-sm text-gray-400">
            {completedRequired} of {requiredDocs.length} required documents
          </span>
        </div>
        <div className="h-2 bg-white/10 rounded-full overflow-hidden">
          <motion.div
            initial={{ width: 0 }}
            animate={{
              width: `${
                requiredDocs.length > 0
                  ? (completedRequired / requiredDocs.length) * 100
                  : 0
              }%`,
            }}
            transition={{ duration: 0.5 }}
            className="h-full bg-gradient-to-r from-emerald-500 to-teal-500 rounded-full"
          />
        </div>
        {allRequiredComplete && (
          <p className="mt-3 text-sm text-emerald-400 flex items-center gap-2">
            <span className="material-symbols-outlined text-sm">
              check_circle
            </span>
            All required documents uploaded! Your documents are being reviewed.
          </p>
        )}
      </motion.div>

      {/* Required Documents */}
      {requiredDocs.length > 0 && (
        <div className="space-y-4">
          <h2 className="text-lg font-bold text-white flex items-center gap-2">
            <span className="material-symbols-outlined text-red-400">
              priority_high
            </span>
            Required Documents
          </h2>
          <div className="grid gap-4">
            {requiredDocs.map((req, index) => (
              <DocumentDropzone
                key={req.document_type}
                docType={req.document_type}
                title={req.title}
                description={req.description}
                required={req.required}
                submitted={req.submitted}
                status={req.status}
              />
            ))}
          </div>
        </div>
      )}

      {/* Optional Documents */}
      {optionalDocs.length > 0 && (
        <div className="space-y-4">
          <h2 className="text-lg font-bold text-white flex items-center gap-2">
            <span className="material-symbols-outlined text-gray-400">
              add_circle
            </span>
            Optional Documents
          </h2>
          <div className="grid gap-4">
            {optionalDocs.map((req) => (
              <DocumentDropzone
                key={req.document_type}
                docType={req.document_type}
                title={req.title}
                description={req.description}
                required={req.required}
                submitted={req.submitted}
                status={req.status}
              />
            ))}
          </div>
        </div>
      )}

      {/* Help */}
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ delay: 0.3 }}
        className="bg-blue-500/10 border border-blue-500/20 rounded-xl p-6"
      >
        <div className="flex gap-4">
          <span className="material-symbols-outlined text-blue-400 shrink-0">
            help
          </span>
          <div>
            <h3 className="font-bold text-white mb-2">Need Help?</h3>
            <p className="text-sm text-gray-400">
              Make sure your documents are clear, readable, and not expired.
              Accepted formats: PDF, JPG, PNG, DOC. Maximum file size: 10MB.
            </p>
          </div>
        </div>
      </motion.div>
    </div>
  );
}

